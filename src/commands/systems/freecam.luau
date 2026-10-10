-- Freecam: moves the camera on its own, so your character stays where it is.
-- The freecam commands use it. The commands that take the camera back (view, fixcam)
-- stop it first, otherwise it would keep overriding the camera every frame.
--
-- On a computer the keyboard moves and the mouse turns. On a phone or tablet (isMobile)
-- the Roblox thumbstick moves, the same way it flies the character. Buttons on screen go up and down,
-- BOOST (held) makes it faster, a close button turns it off, and dragging on the right half of the screen turns the
-- camera. A finger on the left half only moves the thumbstick. The character is anchored meanwhile, so it does not walk away, and the Roblox jump
-- button is hidden, since jumping does nothing then.

local robloxServices = require("../../framework/services/rbxServices")
local isMobile = require("../../framework/config/isMobile")
local coreGui = require("../../ui/coreGui")

local ContextActionService = robloxServices.ContextActionService
local UserInputService = robloxServices.UserInputService

local freecam = {}

freecam.DEFAULT_SPEED = 1
freecam.DEFAULT_BOOST = 2 -- speed multiplier while the BOOST button is held
freecam.MIN_BOOST = 1
freecam.MAX_BOOST = 50
local BOOST_SETTING = "freecam.boost" -- saved in the settings, so it is kept next time

local GARBAGE_NAME = "freecam"
local KEYS_ACTION = "freecamKeys"
local MOUSE_ACTION = "freecamMouse"
local ACTION_PRIORITY = Enum.ContextActionPriority.High.Value
local GUI_NAME = "freecamControls"

local MOVE_KEYS = {
	Enum.KeyCode.W,
	Enum.KeyCode.A,
	Enum.KeyCode.S,
	Enum.KeyCode.D,
	Enum.KeyCode.E,
	Enum.KeyCode.Q,
	Enum.KeyCode.Up,
	Enum.KeyCode.Down,
}

local REFERENCE_FOV = 70 -- the default field of view, used to scale the turn speed
local STUDS_PER_SECOND = 64 -- movement at speed 1
local SPRING_FREQUENCY = 5
local PAN_PER_PIXEL = math.pi / 64
local SPEED_CHANGE_PER_SECOND = 0.75 -- how fast Up and Down change the speed multiplier
local MIN_MULTIPLIER = 0.01
local MAX_MULTIPLIER = 4
local SHIFT_MULTIPLIER = 0.25 -- holding Shift moves slower, for precise placement
local NEAR_PLANE = 0.1
local MAX_FOCUS_DISTANCE = 512

local TOUCH_LOOK_SCALE = 1 -- same turn speed as the mouse; raise it if drags feel too slow on a phone
local BUTTON_SIZE = 64
local EDGE_OFFSET = 24
local BOTTOM_OFFSET = 40 -- keeps the controls clear of the home indicator on phones

local function sinkInput()
	return Enum.ContextActionResult.Sink
end

-- A spring eases a value toward its goal, so movement and turning start and stop smoothly
local function newSpring(initial)
	return {
		position = initial,
		velocity = initial * 0,
	}
end

local function updateSpring(spring, dt: number, goal)
	local frequency = SPRING_FREQUENCY * 2 * math.pi
	local offset = goal - spring.position
	local decay = math.exp(-frequency * dt)

	local position = goal + (spring.velocity * dt - offset * (frequency * dt + 1)) * decay
	local velocity = (frequency * dt * (offset * frequency - spring.velocity) + spring.velocity) * decay

	spring.position = position
	spring.velocity = velocity

	return position
end

-- Returns 1 when the positive key is held, -1 when the negative key is held, otherwise 0
local function readAxis(positiveKey: Enum.KeyCode, negativeKey: Enum.KeyCode): number
	local positive = UserInputService:IsKeyDown(positiveKey) and 1 or 0
	local negative = UserInputService:IsKeyDown(negativeKey) and 1 or 0
	return positive - negative
end

-- Distance to the nearest surface in view, so the camera focus lands on what is in front of it
local function getFocusDistance(camera: Camera, cframe: CFrame, fieldOfView: number): number
	local viewport = camera.ViewportSize
	local projY = 2 * math.tan(math.rad(fieldOfView) / 2)
	local projX = viewport.X / viewport.Y * projY

	local minDistance = MAX_FOCUS_DISTANCE
	local minDirection = cframe.LookVector

	for x = 0, 1, 0.5 do
		for y = 0, 1, 0.5 do
			local offset = cframe.RightVector * ((x - 0.5) * projX)
				- cframe.UpVector * ((y - 0.5) * projY)
				+ cframe.LookVector

			local direction = offset.Unit
			local origin = cframe.Position + offset * NEAR_PLANE
			local result = workspace:Raycast(origin, direction * MAX_FOCUS_DISTANCE)
			local distance = result and (result.Position - origin).Magnitude or MAX_FOCUS_DISTANCE

			if distance < minDistance then
				minDistance = distance
				minDirection = direction
			end
		end
	end

	return cframe.LookVector:Dot(minDirection) * minDistance
end

-- The horizontal part of a vector as a unit vector, or zero when there is none
local function flatten(vector: Vector3): Vector3
	local flat = Vector3.new(vector.X, 0, vector.Z)
	if flat.Magnitude == 0 then
		return Vector3.zero
	end
	return flat.Unit
end

-- The Roblox thumbstick, read from the humanoid's MoveDirection (camera-relative, the same as fly).
-- Returned in camera space like the keys: x to the right, z backward (-1 is forward), each -1 to 1.
-- It keeps working while the character is anchored, because the thumbstick only sets MoveDirection.
local function readThumbstick(humanoid: Humanoid?): Vector3
	if not humanoid then return Vector3.zero end

	local cframe = workspace.CurrentCamera.CFrame
	local move = humanoid.MoveDirection
	return Vector3.new(move:Dot(flatten(cframe.RightVector)), 0, -move:Dot(flatten(cframe.LookVector)))
end

local function isTouch(input): boolean
	return input.UserInputType == Enum.UserInputType.Touch
end

local function make(className: string, parent: Instance?, properties: { [string]: any }): any
	local object = Instance.new(className)
	for key, value in properties do
		object[key] = value
	end
	object.Parent = parent
	return object
end

-- Whether a point on screen is over one of the touch controls
local function isOverControls(garbage, position: Vector3): boolean
	for _, control in garbage.controls do
		local corner = control.AbsolutePosition
		local size = control.AbsoluteSize
		if position.X >= corner.X and position.X <= corner.X + size.X
			and position.Y >= corner.Y and position.Y <= corner.Y + size.Y then
			return true
		end
	end
	return false
end

-- The up and down buttons and the close button. The Roblox thumbstick needs no control of its own.
local function createControls(self, garbage)
	local gui = make("ScreenGui", coreGui, {
		Name = GUI_NAME,
		ResetOnSpawn = false,
		DisplayOrder = 50,
	})
	garbage.gui = gui

	-- Up and down are held: they count while a finger stays on the button
	local function holdButton(name: string, text: string, position: UDim2)
		local button = make("TextButton", gui, {
			Name = name,
			AnchorPoint = Vector2.new(1, 1),
			Position = position,
			Size = UDim2.fromOffset(BUTTON_SIZE, BUTTON_SIZE),
			BackgroundColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 0.5,
			AutoButtonColor = false,
			Text = text,
			TextColor3 = Color3.new(1, 1, 1),
			TextScaled = true,
			Active = true,
		})

		table.insert(garbage.controls, button)
		table.insert(garbage.connections, self:connect(button.InputBegan, function(input)
			if isTouch(input) then
				garbage.holds[name] = input
			end
		end))
	end

	holdButton("rise", "UP", UDim2.new(1, -EDGE_OFFSET, 1, -BOTTOM_OFFSET - BUTTON_SIZE - 12))
	holdButton("fall", "DOWN", UDim2.new(1, -EDGE_OFFSET, 1, -BOTTOM_OFFSET))
	holdButton("boost", "BOOST", UDim2.new(1, -EDGE_OFFSET - BUTTON_SIZE - 12, 1, -BOTTOM_OFFSET))

	local close = make("TextButton", gui, {
		Name = "Close",
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -EDGE_OFFSET, 0, EDGE_OFFSET),
		Size = UDim2.fromOffset(BUTTON_SIZE, BUTTON_SIZE),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.5,
		AutoButtonColor = false,
		Text = "X",
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,
		Active = true,
	})

	table.insert(garbage.controls, close)
	table.insert(garbage.connections, self:connect(close.Activated, function()
		freecam.stop(self)
	end))

	-- Lifting a finger lets go of whatever it was holding
	table.insert(garbage.connections, self:connect(UserInputService.InputEnded, function(input)
		for name, touch in garbage.holds do
			if input == touch then
				garbage.holds[name] = nil
			end
		end
	end))
end

-- The Roblox jump button does nothing while the character is anchored, so it is hidden while freecam is on.
-- It is put back when freecam stops. If it shows again on its own, it is hidden again.
local function hideJumpButton(self, garbage)
	local playerGui = robloxServices.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	local touchGui = playerGui and playerGui:FindFirstChild("TouchGui")
	local jumpButton = touchGui and touchGui:FindFirstChild("JumpButton", true)
	if not jumpButton then return end

	garbage.jumpButton = jumpButton
	garbage.jumpVisible = jumpButton.Visible
	jumpButton.Visible = false

	table.insert(garbage.connections, self:connect(jumpButton:GetPropertyChangedSignal("Visible"), function()
		if jumpButton.Visible then
			jumpButton.Visible = false
		end
	end))
end

-- The thumbstick would walk the character, so it is anchored in place while the camera flies
local function freezeCharacter(self, garbage)
	local root = self.playerService:getRootPart()
	if not root then return end

	garbage.root = root
	garbage.rootAnchored = root.Anchored
	root.Anchored = true
end

local function releaseCharacter(garbage)
	local root = garbage.root
	if root and root.Parent ~= nil then
		root.Anchored = garbage.rootAnchored
	end
end

local function stepFreecam(self, garbage, dt: number)
	local camera = workspace.CurrentCamera

	-- Up and Down change the speed while flying
	garbage.navMultiplier = math.clamp(
		garbage.navMultiplier + dt * readAxis(Enum.KeyCode.Up, Enum.KeyCode.Down) * SPEED_CHANGE_PER_SECOND,
		MIN_MULTIPLIER,
		MAX_MULTIPLIER
	)

	-- Keyboard, thumbstick and buttons all add up, so they can be used together
	local humanoid = self.playerService:getHumanoid()
	local thumbstick = if isMobile then readThumbstick(humanoid) else Vector3.zero
	if isMobile and humanoid then
		humanoid.Jump = false -- jumping does nothing while the character is anchored
	end

	local rise = garbage.holds.rise and 1 or 0
	local fall = garbage.holds.fall and 1 or 0
	local keys = Vector3.new(
		readAxis(Enum.KeyCode.D, Enum.KeyCode.A) + thumbstick.X,
		readAxis(Enum.KeyCode.E, Enum.KeyCode.Q) + rise - fall,
		readAxis(Enum.KeyCode.S, Enum.KeyCode.W) + thumbstick.Z
	)

	local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and SHIFT_MULTIPLIER or 1
	local boost = if garbage.holds.boost then freecam.getBoost(self) else 1
	local speed = (self.privateEnv.freecamSpeed or freecam.DEFAULT_SPEED) * garbage.navMultiplier * shift * boost
	local velocity = updateSpring(garbage.velocitySpring, dt, keys * speed)

	local pan = updateSpring(garbage.panSpring, dt, garbage.mouseDelta * PAN_PER_PIXEL)
	garbage.mouseDelta = Vector2.zero

	-- Turning is slower when the field of view is zoomed in
	local zoomFactor = math.sqrt(math.tan(math.rad(REFERENCE_FOV / 2)) / math.tan(math.rad(garbage.fieldOfView / 2)))
	local rotation = garbage.rotation + pan * Vector2.new(0.75, 1) * 8 * (dt / zoomFactor)
	garbage.rotation = Vector2.new(
		math.clamp(rotation.X, -math.rad(90), math.rad(90)),
		rotation.Y % (2 * math.pi)
	)

	local orientation = CFrame.fromOrientation(garbage.rotation.X, garbage.rotation.Y, 0)
	local cframe = CFrame.new(garbage.position) * orientation * CFrame.new(velocity * STUDS_PER_SECOND * dt)
	garbage.position = cframe.Position

	camera.CFrame = cframe
	if garbage.anchor then
		garbage.anchor.CFrame = cframe
	end
	camera.Focus = cframe * CFrame.new(0, 0, -getFocusDistance(camera, cframe, garbage.fieldOfView))
	camera.FieldOfView = garbage.fieldOfView
end

-- Turns freecam off and gives back the camera, mouse and character. Returns true if it was on.
function freecam.stop(self): boolean
	local garbage = self:collectGarbage(GARBAGE_NAME)
	if not garbage then return false end

	for _, connection in garbage.connections do
		connection:Disconnect()
	end

	ContextActionService:UnbindAction(KEYS_ACTION)
	ContextActionService:UnbindAction(MOUSE_ACTION)

	if garbage.gui then
		garbage.gui:Destroy()
	end
	if garbage.jumpButton then
		garbage.jumpButton.Visible = garbage.jumpVisible
	end
	releaseCharacter(garbage)

	local camera = workspace.CurrentCamera
	camera.CameraType = garbage.cameraType
	camera.CameraSubject = garbage.cameraSubject
	if garbage.anchor then
		garbage.anchor:Destroy()
	end
	camera.Focus = garbage.focus
	camera.FieldOfView = garbage.fieldOfView

	UserInputService.MouseBehavior = garbage.mouseBehavior
	UserInputService.MouseIconEnabled = garbage.mouseIconEnabled

	return true
end

-- Runs an optional part of freecam (the buttons, the jump button). If it fails, freecam keeps
-- working without it and says what failed.
local function guarded(self, what: string, fn, ...)
	local ok, err = pcall(fn, ...)
	if not ok then
		self:notify("Freecam", `{what} failed: {err}`)
	end
end

-- Turns freecam on. With a position it starts there, otherwise at the current camera.
-- The camera keeps the direction it is already looking in.
local function startFreecam(self, position: Vector3?)
	freecam.stop(self)

	local camera = workspace.CurrentCamera
	local startCFrame = camera.CFrame
	local pitch, yaw = startCFrame:ToOrientation()

	local garbage = self:createGarbage(GARBAGE_NAME)
	garbage.connections = {}
	garbage.controls = {}
	garbage.holds = {}
	garbage.cameraType = camera.CameraType
	garbage.cameraSubject = camera.CameraSubject
	garbage.focus = camera.Focus
	garbage.fieldOfView = camera.FieldOfView
	garbage.mouseBehavior = UserInputService.MouseBehavior
	garbage.mouseIconEnabled = UserInputService.MouseIconEnabled

	garbage.position = position or startCFrame.Position
	garbage.rotation = Vector2.new(pitch, yaw)
	garbage.mouseDelta = Vector2.zero
	garbage.navMultiplier = 1
	garbage.velocitySpring = newSpring(Vector3.zero)
	garbage.panSpring = newSpring(Vector2.zero)

	camera.CameraType = Enum.CameraType.Custom

	-- The camera subject becomes this invisible part, which moves with the freecam. Roblox may measure
	-- some things it draws (chat bubble sizes, for example) from the camera subject. The character stays
	-- behind when the camera flies away, so without this those measurements would use the wrong spot.
	garbage.anchor = make("Part", workspace, {
		Name = "freecamAnchor",
		Anchored = true,
		CanCollide = false,
		CanQuery = false,
		CanTouch = false,
		CastShadow = false,
		Transparency = 1,
		Size = Vector3.one * 0.2,
		CFrame = CFrame.new(garbage.position),
	})
	camera.CameraSubject = garbage.anchor
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = true

	-- Movement keys and the mouse are sunk, so the character does not walk or turn meanwhile
	ContextActionService:BindActionAtPriority(KEYS_ACTION, sinkInput, false, ACTION_PRIORITY, table.unpack(MOVE_KEYS))
	ContextActionService:BindActionAtPriority(MOUSE_ACTION, function(_, _, input)
		local delta = input.Delta
		garbage.mouseDelta += Vector2.new(-delta.Y, -delta.X)
		return Enum.ContextActionResult.Sink
	end, false, ACTION_PRIORITY, Enum.UserInputType.MouseMovement)

	if isMobile then
		freezeCharacter(self, garbage)
		guarded(self, "buttons", createControls, self, garbage)
		guarded(self, "jump button", hideJumpButton, self, garbage)

		-- A touch that starts over the game's own GUI (gameProcessed), or over our controls, is not a camera drag
		table.insert(garbage.connections, self:connect(UserInputService.InputBegan, function(input, gameProcessed)
			if gameProcessed or not isTouch(input) then return end
			if garbage.lookTouch ~= nil or isOverControls(garbage, input.Position) then return end

			-- the left half is the thumbstick's: the finger moving it must not turn the camera too
			if input.Position.X < workspace.CurrentCamera.ViewportSize.X / 2 then return end

			garbage.lookTouch = input
		end))
		table.insert(garbage.connections, self:connect(UserInputService.InputChanged, function(input)
			if input == garbage.lookTouch then
				garbage.mouseDelta += Vector2.new(-input.Delta.Y, -input.Delta.X) * TOUCH_LOOK_SCALE
			end
		end))
		table.insert(garbage.connections, self:connect(UserInputService.InputEnded, function(input)
			if input == garbage.lookTouch then
				garbage.lookTouch = nil
			end
		end))
	end

	table.insert(garbage.connections, self:connect(self.runService.RenderStepped, function(dt)
		local ok, err = pcall(stepFreecam, self, garbage, dt)
		if not ok then
			freecam.stop(self)
			self:notify("Freecam", `stopped, the camera was given back: {err}`)
		end
	end))
end

-- Turns freecam on. If anything fails while it starts, freecam is turned off again, so the camera
-- is given back, and the error is shown.
function freecam.start(self, position: Vector3?)
	local ok, err = pcall(startFreecam, self, position)
	if not ok then
		freecam.stop(self)
		self:notify("Freecam", `could not start: {err}`)
	end
end

-- The boost multiplier, from the saved settings (DEFAULT_BOOST when there is none yet)
function freecam.getBoost(self): number
	local value = self.storage.settings:getValue(BOOST_SETTING)
	if type(value) ~= "number" then
		return freecam.DEFAULT_BOOST
	end

	return math.clamp(value, freecam.MIN_BOOST, freecam.MAX_BOOST)
end

-- Adds amount to the boost multiplier (a negative amount lowers it), keeps it in range, and saves it
function freecam.addBoost(self, amount: number): number
	local value = math.clamp(freecam.getBoost(self) + amount, freecam.MIN_BOOST, freecam.MAX_BOOST)

	self.storage.settings:setValue(BOOST_SETTING, value)
	self.storage.settings:save()

	return value
end

-- Where the freecam camera is right now, or nil when freecam is off
function freecam.getPosition(self): Vector3?
	local garbage = self:getGarbage(GARBAGE_NAME)
	return garbage and garbage.position
end

return freecam
