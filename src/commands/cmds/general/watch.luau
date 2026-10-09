return {
	{
		action = "rolewatch",
		description = "Notify if someone from a watched group joins the server",
		args = {
			{
				kind = "number",
				name = "group id"
			},
			{
				kind = "string",
				name = "role name"
			}
		}
	},
	{
		action = "rolewatchstop|unrolewatch",
		description = "Disable Rolewatch"
	},
	{
		action = "rolewatchleave",
		description = "Toggle if you should leave the game if someone from a watched group joins the server"
	},
	{
		action = "staffwatch",
		description = "Notify if a staff member of the game joins the server"
	},
	{
		action = "unstaffwatch",
		description = "Disable Staffwatch"
	},
	{
		action = "findfriendgroups",
		description = "Notifies you if any players are friends with each other"
	}
}
