return {
	{
		action = "logs",
		description = "Opens the logs GUI"
	},
	{
		action = "chatlogs|clogs",
		description = "Log what people say or whisper"
	},
	{
		action = "joinlogs|jlogs",
		description = "Log when people join"
	},
	{
		action = "chatlogswebhook|logswebhook",
		description = "Set a discord webhook for chatlogs to go to (provide no url to disable this)",
		args = {
			kind = "string",
			name = "url",
			optional = true
		}
	}
}