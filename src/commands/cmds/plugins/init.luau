return {
	{
		action = "addplugin|plugin",
		description = "Add a plugin via command",
		args = {
			kind = "string",
			name = "plugin name"
		}
	},
	{
		action = "removeplugin|deleteplugin",
		description = "Remove a plugin via command",
		args = { kind = "plugin" }
	},
	{
		action = "reloadplugin",
		description = "Reloads a plugin",
		args = { kind = "plugin" }
	},
	{
		action = "addallplugins|loadallplugins",
		description = "Adds all available plugins from the workspace folder"
	}
}