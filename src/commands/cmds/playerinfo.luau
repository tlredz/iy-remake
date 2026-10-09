return {
	{
		action = "inspect|examine",
		description = "Opens InspectMenu for a certain player",
		args = { kind = "player" }
	},
	{
		action = "age|playerage",
		description = "Tells you the age of a player",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "chatage",
		description = "Chats the age of a player",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "joindate|jd",
		description = "Tells you the date the player joined Roblox",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "chatjoindate|cjd",
		description = "Chats the date the player joined Roblox",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "copyname|copyuser",
		description = "Copies a players full username to your clipboard",
		args = { kind = "player" }
	},
	{
		action = "userid|id",
		description = "Notifies a players user ID",
		args = {
			kind = "player",
			optional = true
		}
	}
}