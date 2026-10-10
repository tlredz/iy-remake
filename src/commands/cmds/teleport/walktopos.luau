return {
	action = "walktoposition|walktopos",
	description = "Makes you walk to a coordinate",
	args = { kind = "vector3" },
	run = function(self, args)
		local position = args:nextValue()

		local humanoid = self.playerService:getHumanoid()
		if humanoid and humanoid.SeatPart then
			humanoid.Sit = false
			task.wait(0.1)
		end

		humanoid = self.playerService:getHumanoid()
		if humanoid then
			humanoid.WalkToPoint = position
		end
	end
}
