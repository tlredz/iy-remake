-- Flight shared by fly and vehiclefly.
-- Movement follows the camera and reads humanoid.MoveDirection, so keyboard and the
-- mobile thumbstick both work. The up and down keys (flyUp / flyDown in Settings > Command Settings) move the
-- character up and down while the qefly hotkeys are on.

local robloxServices = require("../../framework/services/rbxServices")
local keyboardService = require("../../framework/services/keyboardService")
local objectDecoy = require("./objectDecoy")

local UserInputService = robloxServices.UserInputService

local flight = {}

local MAX_FORCE = Vector3.one * 9e9

-- The horizontal part of a vector, or zero when there is none.
local function flatten(vector: Vector3): Vector3
	local flat = Vector3.new(vector.X, 0, vector.Z)
	if flat.Magnitude == 0 then
		return Vector3.zero
	end
	return flat.Unit
end

-- Direction the player wants to fly in. Forward follows the camera, including its pitch.
local function getDirection(self, humanoid: Humanoid): Vector3
	local cframe = workspace.CurrentCamera.CFrame
	local move = humanoid.MoveDirection

	local forward = move:Dot(flatten(cframe.LookVector))
	local sideways = move:Dot(flatten(cframe.RightVector))

	local vertical = 0
	if self.privateEnv.qeFly ~= false then
		if UserInputService:IsKeyDown(keyboardService:getBinding("flyUp")) then
			vertical += 1
		end
		if UserInputService:IsKeyDown(keyboardService:getBinding("flyDown")) then
			vertical -= 1
		end
	end

	local direction = cframe.LookVector * forward + cframe.RightVector * sideways + Vector3.yAxis * vertical
	if direction.Magnitude > 1 then
		direction = direction.Unit
	end
	return direction
end

-- Any part of the character can hold a BodyVelocity or BodyGyro, since they move the whole character.
-- Each one picks a random body part other than the root, so they are not all on the root.
local function pickMountPart(root: BasePart): BasePart
	local parts = {}
	local character = root.Parent
	if character then
		for _, child in character:GetChildren() do
			if child:IsA("BasePart") and child ~= root then
				table.insert(parts, child)
			end
		end
	end

	if #parts == 0 then
		return root
	end
	return parts[math.random(#parts)]
end

-- Stops the flight that was started with this garbage name.
function flight.stop(self, garbageName: string)
	local garbage = self:collectGarbage(garbageName)
	if not garbage then return end

	if garbage.connection then
		garbage.connection:Disconnect()
	end
	if garbage.velocity then
		objectDecoy.destroy(garbage.velocity)
	end
	if garbage.gyro then
		objectDecoy.destroy(garbage.gyro)
	end
	if garbage.humanoid then
		objectDecoy.setProperty(garbage.humanoid, "PlatformStand", false)
	end
end

-- options.garbageName: name used to stop this flight later.
-- options.getSpeed: returns the speed every frame, so flyspeed changes apply while flying.
-- options.kind: "fly" or "vehiclefly", so the toggle commands know which one is on.
-- options.platformStand: keeps the humanoid stiff while flying.
function flight.start(self, options)
	flight.stop(self, options.garbageName)

	local humanoid = self.playerService:getHumanoid()
	local root = self.playerService:getRootPart()
	if not (humanoid and root) then
		self:notify("Fly", "your character is not loaded")
		return
	end

	local velocity = objectDecoy.createProtected("BodyVelocity", {
		MaxForce = MAX_FORCE,
		Velocity = Vector3.zero,
		Parent = pickMountPart(root),
	})

	local gyro = objectDecoy.createProtected("BodyGyro", {
		MaxTorque = MAX_FORCE,
		P = 9e4,
		CFrame = root.CFrame,
		Parent = pickMountPart(root),
	})

	if options.platformStand then
		objectDecoy.setProperty(humanoid, "PlatformStand", true)
	end

	local garbage = self:createGarbage(options.garbageName)
	garbage.velocity = velocity
	garbage.gyro = gyro
	garbage.humanoid = humanoid
	garbage.kind = options.kind

	garbage.connection = self:connect(self.runService.Heartbeat, function()
		if not root:IsDescendantOf(workspace) or humanoid.Health <= 0 then
			flight.stop(self, options.garbageName)
			return
		end

		objectDecoy.setProperty(velocity, "Velocity", getDirection(self, humanoid) * options.getSpeed())
		objectDecoy.setProperty(gyro, "CFrame", workspace.CurrentCamera.CFrame)
	end)
end

return flight
