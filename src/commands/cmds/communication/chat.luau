return {
	{
		action = "chat|say",
		description = "Makes you chat a string (possible mute bypass)",
		args = {
			kind = "string",
			name = "your message"
		}
	},
	{
		action = "spam",
		description = "Makes you spam the chat",
		args = {
			kind = "string",
			name = "your message"
		}
	},
	{
		action = "unspam",
		description = "Turns off spam"
	},
	{
		action = "whisper|pm",
		description = "Makes you whisper a string to someone (possible mute bypass)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "string",
				name = "your message"
			}
		}
	},
	{
		action = "pmspam",
		description = "Makes you spam a players whispers",
		args = {
			{
				kind = "player",
			},
			{
				kind = "string",
				name = "your message"
			}
		}
	},
	{
		action = "unpmspam",
		description = "Turns off pm spam",
		args = { kind = "player" }
	},
	{
		action = "spamspeed|spamdelay",
		description = "How quickly you spam (default is 1)",
		args = { kind = "number" }
	}
}