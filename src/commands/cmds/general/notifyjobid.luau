return {
	action = "notifyjobid",
	description = "Notifies the JobId and PlaceId of the current server",
	run = function(self)
		self:notify("JobId / PlaceId", `{game.JobId} / {game.PlaceId}`)
	end
}
