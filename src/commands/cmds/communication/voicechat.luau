return {
	{
		action = "listento",
		description = "Listens to the area around a player. Can also eavesdrop with vc",
		args = { kind = "player" }
	},
	{
		action = "unlistento",
		description = "Disables listento"
	},
	{
		action = "muteallvoices|muteallvcs",
		description = "Mutes voice chat for all players"
	},
	{
		action = "unmuteallvoices|unmuteallvcs",
		description = "Unmutes voice chat for all players"
	},
	{
		action = "mutevc",
		description = "Mutes the voice chat of a player",
		args = { kind = "player" }
	},
	{
		action = "unmutevc",
		description = "Unmutes the voice chat of a player",
		args = { kind = "player" }
	},
	{
		action = "phonebook|call",
		description = "Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled"
	}
}