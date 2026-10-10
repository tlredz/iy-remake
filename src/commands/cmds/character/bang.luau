local resolvePlayers = require("../../systems/resolvePlayers")

local BANG_R6_ANIMATION = "rbxassetid://148840371"
local BANG_R15_ANIMATION = "rbxassetid://5918726674"
local CARPET_ANIMATION = "rbxassetid://282574440"

-- The torso that bang and carpet follow: R6 has Torso, R15 has UpperTorso or LowerTorso
local function getTorso(character: Model?)
	if not character then return nil end

	return character:FindFirstChild("Torso")
		or character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("LowerTorso")
		or character:FindFirstChild("HumanoidRootPart")
end

-- Plays an animation on the humanoid and returns its track and the Animation instance.
local function playAnimation(humanoid: Humanoid, animationId: string)
	local animation = Instance.new("Animation")
	animation.AnimationId = animationId

	local track = humanoid:LoadAnimation(animation)
	track:Play(0.1, 1, 1)
	return track, animation
end

local function stopBang(self)
	local garbage = self:collectGarbage("bang")
	if not garbage then return end

	for _, connection in garbage.connections do
		connection:Disconnect()
	end
	garbage.track:Stop()
	garbage.animation:Destroy()
end

local function stopCarpet(self)
	local garbage = self:collectGarbage("carpet")
	if not garbage then return end

	for _, connection in garbage.connections do
		connection:Disconnect()
	end
	garbage.track:Stop()
	garbage.animation:Destroy()
end

return {
	{
		action = "bang",
		description = "owo",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "speed",
				optional = true
			}
		},
		run = function(self, args)
			stopBang(self)

			local target = resolvePlayers(args:nextValue())[1]
			local speed = args:nextValue() or 3

			local humanoid = self.playerService:getHumanoid()
			if not (target and humanoid) then return end

			local animationId = humanoid.RigType == Enum.HumanoidRigType.R15 and BANG_R15_ANIMATION or BANG_R6_ANIMATION
			local track, animation = playAnimation(humanoid, animationId)
			track:AdjustSpeed(speed)

			local garbage = self:createGarbage("bang")
			garbage.track = track
			garbage.animation = animation
			garbage.connections = {}

			table.insert(garbage.connections, self:connect(humanoid.Died, function()
				stopBang(self)
			end))

			local offset = CFrame.new(0, 0, 1.1)
			table.insert(garbage.connections, self:connect(self.runService.Stepped, function()
				local root = self.playerService:getRootPart()
				local torso = getTorso(target.Character)
				if root and torso then
					root.CFrame = torso.CFrame * offset
				end
			end))
		end
	},
	{
		action = "unbang",
		description = "uwu",
		run = function(self)
			stopBang(self)
		end
	},
	{
		action = "carpet",
		description = "Be someones carpet",
		args = {
			kind = "player"
		},
		run = function(self, args)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end

			if humanoid.RigType == Enum.HumanoidRigType.R15 then
				self:notify("R6 Required", "This command requires the r6 rig type")
				return
			end

			stopCarpet(self)

			local target = resolvePlayers(args:nextValue())[1]
			if not target then return end

			local track, animation = playAnimation(humanoid, CARPET_ANIMATION)

			local garbage = self:createGarbage("carpet")
			garbage.track = track
			garbage.animation = animation
			garbage.connections = {}

			table.insert(garbage.connections, self:connect(humanoid.Died, function()
				stopCarpet(self)
			end))

			table.insert(garbage.connections, self:connect(self.runService.Heartbeat, function()
				local root = self.playerService:getRootPart()
				local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
				if root and targetRoot then
					root.CFrame = targetRoot.CFrame
				end
			end))
		end
	},
	{
		action = "uncarpet",
		description = "Undoes carpet",
		run = function(self)
			stopCarpet(self)
		end
	}
}
