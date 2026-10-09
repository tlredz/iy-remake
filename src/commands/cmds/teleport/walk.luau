return {
	{
		action = "tpwalk|teleportwalk",
		description = "Teleports you to your move direction",
		args = {
			{
				kind = "number",
				name = "distance"
			},
			{
				kind = "boolean",
				name = "stack distance",
				optional = true
			}
		}
	},
	{
		action = "untpwalk|unteleportwalk",
		description = "Undoes tpwalk / teleportwalk"
	},
	{
		action = "wallwalk|walkonwalls",
		description = "Walk on walls"
	}
}
