return {
	{
		action = "freecam|fc",
		description = "Allows you to freely move camera around the game",
		args = {
			kind = "number",
			name = "camera speed",
			optional = true
		}
	},
	{
		action = "freecampos|fcpos",
		description = "Moves / opens freecam in a certain position",
		args = { kind = "vector3" }
	},
	{
		action = "freecamwaypoint|fcwp",
		description = "Moves / opens freecam to a waypoint",
		args = {
			kind = "waypoint"
		}
	},
	{
		action = "freecamgoto|fcgoto|fctp",
		description = "Moves / opens freecam to a player",
		args = { kind = "player" }
	},
	{
		action = "unfreecam|unfc",
		description = "Disables freecam"
	},
	{
		action = "freecamspeed|fcspeed",
		description = "Adjusts freecam speed (default is 1)",
		args = { kind = "number" }
	},
	{
		action = "notifyfreecamposition|notifyfcpos",
		description = "Noitifies you your freecam coordinates"
	},
	{
		action = "copyfreecamposition|copyfcpos",
		description = "Copies your freecam coordinates to your clipboard"
	},
}