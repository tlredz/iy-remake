return {
	action = "togglecoregui|togglegui|tcgui",
	description = "Toggles visibility of coregui items",
	args = {
		{
			kind = "options",
			options = "inventory|playerlist|chat|reset|emotes|all",
			name = "gui name"
		},
		{
			kind = "boolean",
			name = "enabled"
		}
	}
}