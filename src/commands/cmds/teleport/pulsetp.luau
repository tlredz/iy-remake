local resolvePlayers = require("../../systems/resolvePlayers")

return {
	action = "pulsetp|ptp",
	description = "Teleports you to a player for a specified amount of time",
	args = {
		{
			kind = "player"
		},
		{
			kind = "number",
			name = "time amount",
			optional = true
		}
	},
	run = function(self, args)
		local target = resolvePlayers(args:nextValue())[1]
		local seconds = args:nextValue() or 1 -- the time argument is optional, default 1

		local targetRoot = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		if not targetRoot then return end

		local startRoot = self.playerService:getRootPart()
		if not startRoot then return end
		local startCFrame = startRoot.CFrame

		self.playerService:teleportTo(targetRoot.CFrame + Vector3.new(3, 1, 0))
		task.wait(seconds)

		self.playerService:setRootCFrame(startCFrame)
	end
}
