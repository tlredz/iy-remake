return {
	{
		action = "spectate|view",
		description = "View a player",
		args = { kind = "player" }
	},
	{
		action = "viewpart|viewp",
		description = "View a part",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "unspectate|unview",
		description = "Stops viewing player, or part."
	}
}