return {
	action = "notifyjobid",
	description = "Notifies the JobId and PlaceId of the current server. Its copy button copies them",
	run = function(self)
		self:notify("JobId / PlaceId", `{game.JobId} / {game.PlaceId}`, nil, { copy = true })
	end
}
