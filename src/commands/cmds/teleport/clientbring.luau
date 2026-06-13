return {
	{
		action = "clientbring|cbring",
		description = "Bring a player (CLIENT)",
		args = {
			kind = "player"
		}
	},
	{
		action = "loopbring",
		description = "Loop brings a player to you (useful for killing) (CLIENT)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "distance",
				optional = true
			},
			{
				kind = "number",
				name = "bring delay",
				optional = true
			}
		}
	},
	{
		action = "unloopbring",
		description = "Undoes loopbring",
		args = { kind = "player" }
	}
}