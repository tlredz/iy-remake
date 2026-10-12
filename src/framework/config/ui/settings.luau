-- src/framework/config/ui/settings.luau
-- The settings panel (src/ui/components/settings): its layout, its text, and the options it shows.
--
-- Each option is one row, with a kind:
--   "switch"   an on/off box. `setting` names a key in `keys` below, and the value is saved there
--   "keybind"  a box that shows the key of `binding` (framework/config/services/keybinds). Tapping it waits for the
--              next key press, which becomes the new key. Tapping again, or Escape, cancels
--   "button"   `action` is the name of a page in `pages` below, and the button opens that page. An action without a
--              page is reported to the component (onButton)
--
-- `icon` is a name from ui/themes/icons/interface.luau.

local keepiy = require("../commands/keepiy")

return {
	-- settings keys (saved in storage/data/settings)
	keys = {
		keepMenuOpen = "interface.keepMenuOpen",
		keepIY = keepiy.settingKey,
		theme = "selectedTheme",
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
		floatBackSize = 25, -- the back button that shows in the corner when the back row has scrolled away
		floatBackMargin = 6,
		floatBackFlat = 0.3, -- the width of the button as it comes out of the corner, as a share of its size
		floatBackOut = 0.5, -- how far above the corner it starts, as a share of its size (the panel hides the rest)
		floatBackTime = 0.35, -- seconds for it to come out of the corner, or to go back in
	},

	row = {
		labelInset = 28,
		iconInset = 5,
		iconSize = 16,
		chevronSize = 14, -- the arrow of the buttons that open a page
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
		keybindWidth = 88, -- wide enough for "press a key" and key names like "Right Control"
		aliasWidth = 110, -- the command an alias runs
		inputWidth = 110, -- the boxes of a form row (conditions)
		formDelayWidth = 46, -- the delay box in the line that adds a bind
		addWidth = 44, -- the add button of that line
		delayWidth = 44, -- the delay of a bind
		buttonWidth = 36, -- the small buttons at the right of a row ("Del", "Add")
		reloadWidth = 52, -- the "Reload" button of a plugin
		positionWidth = 92, -- the position box in the line that adds a waypoint
	},

	-- the count of binds on an event button (widgets.choices): a small pill at the top right corner, shown when it has binds
	badge = {
		height = 12,
		overhang = 3, -- how far it sticks out past the corner of the button
	},

	textSizes = {
		header = 12,
		label = 14,
		value = 12,
		footer = 11, -- the version line at the bottom of the panel
		badge = 10, -- the count on an event button
	},

	-- the line at the bottom of the panel. {name} and {version} are filled in from framework/settings
	footer = "{name} {version}",

	-- the text of the editor pages (components/settings/themePicker, keybindsEditor, aliasesEditor)
	pages = {
		back = "Back",
		backIcon = "lucide-chevron-left",
		
		theme = {
			title = "#theme",
			incomplete = "(incomplete)",
		},
		keybinds = {
			title = "#keybinds",
			reset = "Reset to defaults",
			alwaysWorks = "%s also works as the %s", -- a fixed key and the label of its binding
		},
		aliases = {
			title = "#aliases",
			addTitle = "#add alias",
			aliasHint = "alias",
			commandHint = "command it runs",
			addButton = "Add alias",
			listTitle = "#custom aliases",
			listHint = "tap an alias to remove it",
			empty = "no custom aliases yet",
			missing = "write the alias and the command it runs",
			spaces = "an alias can't have spaces",
			badCharacters = "an alias can't have \\ ^ ! , | & or quotes: the command bar reads them as something else",
			added = "added '%s'",
			removed = "removed '%s'",
			notifyTitle = "Aliases", -- the title of the notification when an alias is refused
			undoTitle = "Alias Removed",
			undoMessage = "'%s' ran '%s'", -- the alias and the command
			undo = "Undo",
			undoTime = 10, -- seconds the undo notification stays open
			restored = "restored '%s'",
		},
		waypoints = {
			title = "#waypoints",
			notifyTitle = "Waypoints",
			newTitle = "#new waypoint",
			nameHint = "name",
			positionHint = "x, y, z",
			addButton = "Add",
			formHint = "no position saves where you are standing",
			modeTitle = "#tap a waypoint to",
			-- what a tap on a waypoint does (waypoints.go): `mode` is the name that function takes
			modes = {
				{ mode = "teleport", label = "Teleport" },
				{ mode = "tween", label = "Tween" },
				{ mode = "walk", label = "Walk" },
			},
			markers = "Show markers in the world",
			listTitle = "#waypoints of this game",
			listHint = "tap one to go there, Del removes it",
			empty = "no waypoints in this game yet",
			delete = "Del",
			clearTitle = "#clear",
			clearGame = "Clear this game",
			clearAll = "Clear every game",
			missingName = "write a name for the waypoint",
			badPosition = "the position needs 3 numbers, like 10, 5, -20",
			noCharacter = "your character was not found",
			noMarkers = "there are no waypoints to show",
			saved = "saved '%s' at %s",
			updated = "updated '%s' to %s",
			went = "teleported to '%s' %s",
			wentTween = "tweening to '%s' %s",
			wentWalk = "walking to '%s' %s",
			cantGo = "can't go there: your character was not found",
			removed = "removed '%s'",
			restored = "restored '%s'",
			nameTaken = "there is already a waypoint named '%s'",
			undoTitle = "Waypoint Removed",
			undoMessage = "'%s' %s was removed", -- the name and its position
			undo = "Undo",
			undoTime = 10, -- seconds the undo notification stays open
			confirmTitle = "Clear Waypoints",
			confirmGame = "Delete the %d waypoint(s) of this game?",
			confirmAll = "Delete the %d waypoint(s) of every game?",
			confirmClear = "Delete",
			confirmCancel = "Cancel",
			cleared = "deleted %d waypoint(s)",
			nothingToClear = "there are no waypoints to delete",
		},
		plugins = {
			title = "#plugins",
			notifyTitle = "Plugins",
			errorTitle = "Plugin Error",
			addTitle = "#add plugin",
			fileHint = "plugin file name",
			addButton = "Add plugin",
			folderHint = "plugins are .luau files in the %s folder", -- the folder
			trustHint = "a plugin runs code with full access: only add files you trust",
			installedTitle = "#installed plugins",
			installedHint = "tap a plugin to see its state, Reload reads its file again",
			noneInstalled = "no plugins installed yet",
			folderTitle = "#in the plugins folder",
			noneInFolder = "no new plugins in the folder",
			add = "Add",
			addAll = "Add all (%d)",
			reload = "Reload",
			remove = "Del",
			failedLabel = "%s (failed)",
			loadedLabel = "%s (%d)", -- the plugin and how many commands it has
			stateLoaded = "'%s' is loaded with %d command(s)",
			stateFailed = "'%s' did not load: %s",
			stateUnknown = "'%s' is installed but not loaded",
			added = "added '%s' (%d command(s))",
			reloaded = "reloaded '%s' (%d command(s))",
			removed = "removed '%s'",
			missingName = "write the file name of the plugin",
			addedAll = "added %d plugin(s)",
			failedAll = ", %d failed (see the console)",
		},
		eventBinds = {
			title = "#event binds",
			notifyTitle = "Event Binds", -- the title of the notification when a bind is refused
			notAdded = "the bind was not added",
			columns = 4, -- event buttons in each line
			commandHint = "command (goto $1)",
			delayHint = "delay",
			-- what a condition box accepts, by the kind of the condition
			conditionHints = {
				Player = "any, me, friends...",
				String = "any, or text",
				Number = "any, or max",
			},
			addButton = "Add",
			header = "#%s - %s", -- the event and what it is
			listTitle = "#binds of %s",
			listHint = "tap a bind to remove it, or type a new delay in its box",
			empty = "no binds for this event yet",
			badDelay = "the delay must be a number",
			negativeDelay = "the delay must be 0 or more",
			added = "added a bind to %s",
			removed = "removed '%s'",
			delayChanged = "the delay of '%s' is now %s",
			restored = "restored '%s'",
			undoTitle = "Bind Removed",
			undoMessage = "'%s' was removed from #%s", -- the command and the event
			undoDelay = "delay %s",
			undo = "Undo",
			undoTime = 10, -- seconds the undo notification stays open
		},
	},

	sections = {
		{
			title = "#general",
			options = {
				{ kind = "keybind", label = "Prefix", icon = "lucide-terminal", binding = "prefix" },
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
