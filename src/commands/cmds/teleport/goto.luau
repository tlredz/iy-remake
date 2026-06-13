return {
	{
		action = "goto",
		description = "Go to a player",
		args = { kind = "player" }
	},
	{
		action = "tweengoto|tgoto",
		description = "Tween to a player (bypasses some anti cheats)",
		args = {
			{ kind = "player" },
			{
				kind = "number",
				name = "tween speed",
				optional = true
			}
		}
	},
	{
		action = "loopgoto",
		description = "Loop teleport to a player",
		args = {
			{
				kind = "string",
				name = "player distance"
			},
			{
				kind = "number",
				name = "delay"
			}
		}
	},
	{
		action = "unloopgoto",
		description = "Stops teleporting you to a player"
	}
}