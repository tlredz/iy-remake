return {
	{
		client = true,
		action = "delete",
		description = "Removes any part with a certain name from the workspace (DOES NOT REPLICATE)",
		args = {
			{
				kind = "string",
				name = "object name"
			},
			{
				kind = "boolean",
				name = "confirm"
			}
		}
	},
	{
		client = true,
		action = "deleteclass|dc",
		description = "Removes any part with a certain classname from the workspace (DOES NOT REPLICATE)",
		args = {
			{
				kind = "className"
			},
			{
				kind = "boolean",
				name = "confirm"
			}
		}
	}
}