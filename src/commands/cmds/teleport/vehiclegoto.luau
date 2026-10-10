local resolvePlayers = require("../../systems/resolvePlayers")

return {
	action = "vehiclegoto|vgoto",
	description = "Go to a player while in a vehicle",
	args = { kind = "player" },
	run = function(self, args)
		local humanoid = self.playerService:getHumanoid()
		local seat = humanoid and humanoid.SeatPart
		if not seat then
			self:notify("vehiclegoto", "you are not sitting in a vehicle")
			return
		end

		local target = resolvePlayers(args:nextValue())[1]
		local targetRoot = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		if not targetRoot then return end

		local vehicle = seat:FindFirstAncestorWhichIsA("Model")
		if vehicle then
			vehicle:MoveTo(targetRoot.Position)
		end
	end
}
