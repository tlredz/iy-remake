-- src/framework/config/services/keybinds.luau
-- The keys the player can change (see framework/services/keyboardService). Each binding is a name the
-- features ask for, with:
--   label       the name shown in Settings
--   settingKey  where the key is saved (storage/data/settings), as the key's name, like "Semicolon"
--   default     the key used until the player picks one (in Settings)
--   also        keys that always work for the binding too, whatever key it is set to
--   group       the page of Settings it is listed on: "interface" is Edit Keybinds, the others are Command Settings
--
-- groups lists the headers of the Command Settings page, in order (key = the group, title = its header)

return {
	bindings = {
		prefix = {
			label = "Prefix",
			settingKey = "keybinds.prefix",
			default = "Semicolon",
			also = { "RightControl" },
			group = "interface",
		},

		flyUp = {
			label = "Up",
			settingKey = "keybinds.flyUp",
			default = "E",
			group = "fly",
		},
		flyDown = {
			label = "Down",
			settingKey = "keybinds.flyDown",
			default = "Q",
			group = "fly",
		},

		floatUp = {
			label = "Up",
			settingKey = "keybinds.floatUp",
			default = "E",
			group = "float",
		},
		floatDown = {
			label = "Down",
			settingKey = "keybinds.floatDown",
			default = "Q",
			group = "float",
		},

		freecamBoost = {
			label = "Boost (held)",
			settingKey = "keybinds.freecamBoost",
			default = "LeftControl",
			group = "freecam",
		},
	},

	groups = {
		{ key = "fly", title = "Fly" },
		{ key = "float", title = "Float" },
		{ key = "freecam", title = "Freecam" },
	},
}
