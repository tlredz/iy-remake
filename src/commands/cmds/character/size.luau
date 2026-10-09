return {
	{
		action = "headsize",
		description = "Expands the head size for players Head (default is 1)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "head size"
			}
		}
	},
	{
		action = "hitbox",
		description = "Expands the hitbox for players HumanoidRootPart (default is 1)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "size"
			},
			{
				kind = "number",
				name = "transparency",
				clamp = {0, 1}
			}
		}
	}
}
