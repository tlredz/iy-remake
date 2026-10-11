-- src/framework/config/settings.luau
-- The settings panel (src/ui/components/settings.luau): its layout, its text, and the options it shows.
--
-- Each option is one row, with a kind:
--   "switch"  an on/off box. `setting` names a key in `keys` below, and the value is saved there
--   "button"  opens an editor. `icon` is a name from ui/themes/icons/interface.luau, and `action` is
--             the name the component reports when it is pressed (nothing is wired to it yet)
--   "prefix"  a read-only box that shows `value`

local keepiy = require("./keepiy")

return {
	-- settings keys of the switches (saved in storage/data/settings)
	keys = {
		keepMenuOpen = "interface.keepMenuOpen",
		keepIY = keepiy.settingKey,
	},

	-- the panel that slides over the command list: where it rests, how fast it moves, its spacing
	panel = {
		shownY = 0,
		hiddenY = 1,
		tweenTime = 0.5,
		padding = 5,
		rowHeight = 25,
		rowGap = 4,
		headerHeight = 16,
		stripeTransparency = 0.5,
		scrollBarThickness = 4,
	},

	row = {
		labelInset = 28,
		iconInset = 5,
		iconSize = 16,
	},

	box = {
		size = 16,
		inset = 4,
		cornerRadius = 3,
		fillCornerRadius = 2,
	},

	value = {
		width = 20,
		height = 16,
		cornerRadius = 4,
	},

	textSizes = {
		header = 12,
		label = 14,
		value = 12,
	},

	sections = {
		{
			title = "#general",
			options = {
				{ kind = "prefix", label = "Prefix", icon = "lucide-terminal", value = ";" },
				{ kind = "switch", label = "Keep Menu Open", icon = "lucide-pin", setting = "keepMenuOpen" },
				{ kind = "switch", label = "Keep Interface", icon = "lucide-refresh-cw", setting = "keepIY" },
			},
		},
		{
			title = "#editors",
			options = {
				{ kind = "button", label = "Edit Theme", icon = "lucide-palette", action = "theme" },
				{ kind = "button", label = "Edit Keybinds", icon = "lucide-keyboard", action = "keybinds" },
				{ kind = "button", label = "Edit Aliases", icon = "lucide-tag", action = "aliases" },
				{ kind = "button", label = "Edit/Goto Waypoints", icon = "lucide-map-pin", action = "waypoints" },
				{ kind = "button", label = "Manage Plugins", icon = "lucide-puzzle", action = "plugins" },
				{ kind = "button", label = "Edit Event Binds", icon = "lucide-zap", action = "eventBinds" },
			},
		},
	},
}
