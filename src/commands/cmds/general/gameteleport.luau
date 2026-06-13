return {
	{
		action = "gameteleport|gametp",
		description = "Joins a game by ID",
		args = {
			kind = "number",
			name = "place id"
		}
	},
	{
		action = "jobidteleport|tpjobid",
		description = "Joins a game by jobid",
		args = {
			{
				kind = "string",
				name = "job id"
			},
			{
				kind = "number",
				name = "place id",
				optional = true
			}
		}
	}
}