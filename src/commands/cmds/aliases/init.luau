return {
	{
		action = "addalias",
		description = "Adds an alias to a command",
		args = {
			{
				kind = "command"
			},
			{
				kind = "string",
				name = "alias"
			}
		}
	},
	{
		action = "removealias",
		description = "Removes a custom alias",
		args = { kind = "alias" }
	},
	{
		action = "clraliases",
		description = "Removes all custom aliases",
		args = {
			kind = "boolean",
			name = "confirm"
		}
	}
}