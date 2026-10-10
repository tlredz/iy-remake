local resolvePlayers = require("../../systems/resolvePlayers")

-- Gets the character out of a seat first, or the game would drag it along (same as IY)
local function unseat(self)
	local humanoid = self.playerService:getHumanoid()
	if humanoid and humanoid.SeatPart then
		humanoid.Sit = false
		task.wait(0.1)
	end
end

-- Stops the loopgoto loop
local function stopLoopGoto(self)
	local garbage = self:collectGarbage("loopgoto")
	if garbage and garbage.id then
		self.loopService:remove(garbage.id)
	end
end

return {
	{
		action = "goto",
		description = "Go to a player",
		args = { kind = "player" },
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			local character = target and target.Character
			if not character then return end

			unseat(self)

			local root = self.playerService:getRootPart()
			if root then
				root.CFrame = character:GetPivot() + Vector3.new(3, 1, 0)
				root.AssemblyLinearVelocity = Vector3.zero
			end
		end
	},
	{
		action = "tweengoto|tgoto",
		description = "Tween to a player (bypasses some anti cheats)",
		args = {
			{ kind = "player" },
			{
				kind = "number",
				name = "tween speed",
				optional = true
			}
		},
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			local character = target and target.Character
			if not character then return end

			local duration = args:nextValue() or self.privateEnv.tweenSpeed or 1

			unseat(self)

			local root = self.playerService:getRootPart()
			if not root then return end

			local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
			self.robloxServices.TweenService:Create(root, info, {
				CFrame = character:GetPivot() + Vector3.new(3, 1, 0)
			}):Play()
		end
	},
	{
		action = "loopgoto",
		description = "Loop teleport to a player",
		args = {
			{ kind = "player" },
			{
				kind = "number",
				name = "distance",
				optional = true
			},
			{
				kind = "number",
				name = "delay",
				optional = true
			}
		},
		run = function(self, args)
			stopLoopGoto(self)

			local target = resolvePlayers(args:nextValue())[1]
			local distance = args:nextValue() or 3
			local delay = args:nextValue() or 0
			if not target then return end

			unseat(self)

			local garbage = self:createGarbage("loopgoto")
			garbage.id = self.loopService:add(function()
				if target.Parent == nil then
					stopLoopGoto(self)
					return
				end

				local root = self.playerService:getRootPart()
				local character = target.Character
				if root and character then
					root.CFrame = character:GetPivot() + Vector3.new(distance, 1, 0)
				end
			end, delay)
		end
	},
	{
		action = "unloopgoto",
		description = "Stops teleporting you to a player",
		run = function(self)
			stopLoopGoto(self)
		end
	}
}
