return {
	{
		action = "orbit",
		description = "Makes your character orbit around a player with an optional speed and an optional distance",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "speed"
			},
			{
				kind = "number",
				name = "distance"
			}
		}
	},
	{
		action = "unorbit",
		description = "Disables orbit"
	}
}
