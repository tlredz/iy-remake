-- Flight shared by fly and vehiclefly.
-- Movement follows the camera and reads humanoid.MoveDirection, so keyboard and the
-- mobile thumbstick both work. Q and E move down and up while the qefly hotkeys are on.

local robloxServices = require("../../framework/services/rbxServices")

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
		if UserInputService:IsKeyDown(Enum.KeyCode.E) then
			vertical += 1
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
			vertical -= 1
		end
	end

	local direction = cframe.LookVector * forward + cframe.RightVector * sideways + Vector3.yAxis * vertical
	if direction.Magnitude > 1 then
		direction = direction.Unit
	end
	return direction
end

-- Stops the flight that was started with this garbage name.
function flight.stop(self, garbageName: string)
	local garbage = self:collectGarbage(garbageName)
	if not garbage then return end

	if garbage.connection then
		garbage.connection:Disconnect()
	end
	if garbage.velocity then
		garbage.velocity:Destroy()
	end
	if garbage.gyro then
		garbage.gyro:Destroy()
	end
	if garbage.humanoid then
		garbage.humanoid.PlatformStand = false
	end
end

-- options.garbageName: name used to stop this flight later.
-- options.getSpeed: returns the speed every frame, so flyspeed changes apply while flying.
-- options.platformStand: keeps the humanoid stiff while flying.
function flight.start(self, options)
	flight.stop(self, options.garbageName)

	local humanoid = self.playerService:getHumanoid()
	local root = self.playerService:getRootPart()
	if not (humanoid and root) then
		self:notify("Fly", "your character is not loaded")
		return
	end

	local velocity = Instance.new("BodyVelocity")
	velocity.MaxForce = MAX_FORCE
	velocity.Velocity = Vector3.zero
	velocity.Parent = root

	local gyro = Instance.new("BodyGyro")
	gyro.MaxTorque = MAX_FORCE
	gyro.P = 9e4
	gyro.CFrame = root.CFrame
	gyro.Parent = root

	if options.platformStand then
		humanoid.PlatformStand = true
	end

	local garbage = self:createGarbage(options.garbageName)
	garbage.velocity = velocity
	garbage.gyro = gyro
	garbage.humanoid = humanoid

	garbage.connection = self:connect(self.runService.Heartbeat, function()
		if not root:IsDescendantOf(workspace) or humanoid.Health <= 0 then
			flight.stop(self, options.garbageName)
			return
		end

		velocity.Velocity = getDirection(self, humanoid) * options.getSpeed()
		gyro.CFrame = workspace.CurrentCamera.CFrame
	end)
end

return flight
