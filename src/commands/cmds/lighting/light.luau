return {
	{
		action = "restorelighting|rlighting",
		description = "Restores Lighting properties"
	},
	{
		action = "light",
		description = "Gives your player dynamic light (CLIENT)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "radius",
				optional = true
			}
		}
	},
	{
		action = "nolight|unlight",
		description = "Removes dynamic light from your player"
	}
}