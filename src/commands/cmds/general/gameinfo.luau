local copyArg = {
	kind = "boolean",
	name = "copy",
	optional = true
}

return {
	{
		action = "jobid",
		description = "Copies the games JobId to your clipboard, or notify",
		args = copyArg
	},
	{
		action = "placeid",
		description = "Copies the current place id to your clipboard, or notify",
		args = copyArg
	},
	{
		action = "gameid",
		description = "Copies the current game id to your clipboard, or notify",
		args = copyArg
	}
}