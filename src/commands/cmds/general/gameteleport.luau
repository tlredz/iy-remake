local stringPlaceId = tostring(game.PlaceId)
local stringJobId = tostring(game.JobId)

return {
	{
		action = "gameteleport|gametp",
		description = "Joins a game by ID",
		args = {
			kind = "number",
			name = "place id",
			options = { stringPlaceId }
		},
		run = function(self, args)
			self.teleportService:Teleport(args:nextValue())
		end
	},
	{
		action = "teleportjobid|tpjobid",
		description = "Joins a game by jobid",
		args = {
			{
				kind = "string",
				name = "job id",
				options = { stringJobId }
			},
			{
				kind = "number",
				name = "place id",
				options = { stringPlaceId },
				optional = true
			}
		},
		run = function(self, args)
			local jobId = args:nextValue() or game.JobId
			local placeId = args:nextValue() or game.PlaceId
			
			self.playerService:teleportToJobId(jobId, placeId)
		end
	}
}