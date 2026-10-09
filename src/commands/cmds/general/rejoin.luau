return {
	action = "rejoin|rj",
	description = "Makes you rejoin the game",
	run = function(self)
		self.playerService:teleportToJobId(game.JobId)
	end
}