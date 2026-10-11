-- src/framework/config/services/keybinds.luau
-- The keys the player can change (see framework/services/keyboardService). Each binding is a name the
-- features ask for, with:
--   settingKey  where the key is saved (storage/data/settings), as the key's name, like "Semicolon"
--   default     the key used until the player picks one (in Settings)
--   also        keys that always work for the binding too, whatever key it is set to

return {
	bindings = {
		prefix = {
			settingKey = "keybinds.prefix",
			default = "Semicolon",
			also = { "RightControl" },
		},
	},
}
