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
			name = "time amount"
		}
	},
	run = function(self, args)
		local target = resolvePlayers(args:nextValue())[1]
		local seconds = args:nextValue() or 1

		local targetRoot = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		if not targetRoot then return end

		local humanoid = self.playerService:getHumanoid()
		if humanoid and humanoid.SeatPart then
			humanoid.Sit = false
			task.wait(0.1)
		end

		local root = self.playerService:getRootPart()
		if not root then return end

		local startCFrame = root.CFrame
		root.CFrame = targetRoot.CFrame + Vector3.new(3, 1, 0)
		task.wait(seconds)

		local currentRoot = self.playerService:getRootPart()
		if currentRoot then
			currentRoot.CFrame = startCFrame
			currentRoot.AssemblyLinearVelocity = Vector3.zero
		end
	end
}
