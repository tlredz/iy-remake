local resolvePlayers = require("../../systems/resolvePlayers")

return {
	{
		action = "walkto|follow",
		description = "Walks your character to a player and keeps following them",
		args = { kind = "player" },
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			if not target then return end
			
			local previous = self:collectGarbage("walkto")
			if previous then
				previous.running = false
			end
			
			local humanoid = self.playerService:getHumanoid()
			if humanoid and humanoid.SeatPart then
				humanoid.Sit = false
				task.wait(0.1)
			end
			
			local garbage = self:createGarbage("walkto")
			garbage.running = true
			
			task.spawn(function()
				while garbage.running do
					local currentHumanoid = self.playerService:getHumanoid()
					local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
					
					if not (currentHumanoid and targetRoot) then
						break
					end
					
					currentHumanoid:MoveTo(targetRoot.Position)
					task.wait()
				end
			end)
		end
	},
	{
		action = "unwalkto|nowalkto|unfollow|nofollow",
		description = "Stops walking to the player",
		run = function(self)
			local garbage = self:collectGarbage("walkto")
			if garbage then
				garbage.running = false
			end
		end
	}
}
