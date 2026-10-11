local resolvePlayers = require("../../systems/resolvePlayers")

return {
	action = "vehiclegoto|vgoto|vehicletp|vtp",
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

		-- PivotTo keeps the vehicle's rotation and does not push it out of what it touches
		local vehicle = seat:FindFirstAncestorWhichIsA("Model")
		if vehicle then
			vehicle:PivotTo(targetRoot:GetPivot())
		end
	end
}
