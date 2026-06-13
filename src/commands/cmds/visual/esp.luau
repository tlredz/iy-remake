return {
	{
		action = "esp",
		description = "View all players and their status"
	},
	{
		action = "espteam",
		description = "ESP but teammates are green and bad guys are red"
	},
	{
		action = "noesp|unesp|unespteam",
		description = "Removes ESP"
	},
	{
		action = "esptransparency",
		description = "Changes the transparency of ESP related commands",
		args = { kind = "number" }
	},
	{
		action = "partesp",
		description = "Highlights a part",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "unpartesp|nopartesp",
		description = "removes partesp",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "chams",
		description = "ESP but without text in the way"
	},
	{
		action = "nochams|unchams",
		description = "Removes chams"
	}
}