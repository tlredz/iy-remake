local resolvePlayers = require("../../systems/resolvePlayers")

-- Stops the loopbring loop for a set of players, or for everyone when no player is given
local function removeLoopBring(self, targets)
	local garbage = self:getGarbage("loopbring")
	if not garbage then return end

	if targets then
		for _, target in targets do
			garbage.targets[target] = nil
		end
	else
		garbage.targets = {}
	end

	if next(garbage.targets) == nil then
		self:collectGarbage("loopbring")
		if garbage.id then
			self.loopService:remove(garbage.id)
		end
	end
end

return {
	{
		action = "clientbring|cbring",
		description = "Bring a player (CLIENT)",
		args = {
			kind = "player"
		},
		run = function(self, args)
			for _, target in resolvePlayers(args:nextValue()) do
				local character = target.Character
				local targetRoot = character and character:FindFirstChild("HumanoidRootPart")
				if targetRoot then
					local humanoid = character:FindFirstChildOfClass("Humanoid")
					if humanoid then
						humanoid.Sit = false
					end
					task.wait()

					local root = self.playerService:getRootPart()
					if root then
						targetRoot.CFrame = root.CFrame + Vector3.new(3, 1, 0)
					end
				end
			end
		end
	},
	{
		action = "loopbring",
		description = "Loop brings a player to you (useful for killing) (CLIENT)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "distance",
				optional = true
			},
			{
				kind = "number",
				name = "bring delay",
				optional = true
			}
		},
		run = function(self, args)
			local targets = resolvePlayers(args:nextValue())
			local distance = args:nextValue() or 3
			local delay = args:nextValue() or 0

			-- Running loopbring again adds players to the same loop, with the new distance and delay
			local garbage = self:registerGarbage("loopbring")
			garbage.targets = garbage.targets or {}
			garbage.distance = distance
			for _, target in targets do
				if target ~= self.localPlayer then
					garbage.targets[target] = true
				end
			end

			if garbage.id then
				self.loopService:remove(garbage.id)
			end

			garbage.id = self.loopService:add(function()
				local root = self.playerService:getRootPart()

				for target in garbage.targets do
					if target.Parent == nil then
						garbage.targets[target] = nil
					else
						local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
						if root and targetRoot then
							targetRoot.CFrame = root.CFrame + Vector3.new(garbage.distance, 1, 0)
						end
					end
				end
			end, delay)
		end
	},
	{
		action = "unloopbring",
		description = "Undoes loopbring",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			local text = args:nextValue()
			if text then
				removeLoopBring(self, resolvePlayers(text))
			else
				removeLoopBring(self, nil)
			end
		end
	}
}
