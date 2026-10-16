-- src/ui/components/settings/keybindsEditor.luau
-- The keybind pages. Edit Keybinds lists the interface keys (the prefix), and Command Settings lists the keys of the
-- commands, under a header for each command. Both are made by makePage: a row for each binding of their groups
-- (framework/config/services/keybinds), and a row that puts those bindings back to their default keys.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel, and ctx.stoppers collects the functions that
-- end a wait for a key. See settings/init.luau.

local keyboardService = require("../../../framework/services/keyboardService")
local keybindsConfig = require("../../../framework/config/services/keybinds")
local config = require("../../../framework/config/ui/settings")
local widgets = require("./widgets")

local PANEL = config.panel
local VALUE = config.value

-- the names of the bindings of a group, sorted, so the rows keep the same order
local function namesIn(group: string): { string }
	local names = {}

	for name, binding in keybindsConfig.bindings do
		if binding.group == group then
			table.insert(names, name)
		end
	end

	table.sort(names)
	return names
end

-- the keys that always work for the bindings of the groups, as one line each ("Right Control also works as the Prefix")
local function fixedKeyLines(groups: { string }): { string }
	local lines = {}

	for _, group in groups do
		for _, name in namesIn(group) do
			local binding = keybindsConfig.bindings[name]

			for _, keyName in binding.also or {} do
				local keyCode = (Enum.KeyCode :: any)[keyName]

				if keyCode then
					table.insert(lines, string.format(
						config.pages.keybinds.alwaysWorks,
						keyboardService:getKeyName(keyCode),
						binding.label or name
					))
				end
			end
		end
	end

	return lines
end

-- pageConfig: title (the page's header), groups ({ key, title? } in order; a title adds a header over the group),
-- reset (the text of the reset row). Returns the build function of the page
local function makePage(pageConfig)
	return function(page: ScrollingFrame, ctx)
		local list = widgets.list(page)
		widgets.pageTop(list, pageConfig.title, ctx.back)

		local refreshers = {}
		local keys = {}

		for _, group in pageConfig.groups do
			if group.title then
				widgets.header(list, group.title)
			end

			table.insert(keys, group.key)

			for _, name in namesIn(group.key) do
				local binding = keybindsConfig.bindings[name]
				local row = widgets.row(list)

				widgets.label(row, binding.label or name, VALUE.keybindWidth + 2 * PANEL.padding)

				local refresh, stop = widgets.keybind(row, name)
				table.insert(refreshers, refresh)
				table.insert(ctx.stoppers, stop)
			end
		end

		local fixedLines = fixedKeyLines(keys)
		if #fixedLines > 0 then
			widgets.note(list, table.concat(fixedLines, "\n"))
		end

		local reset = widgets.row(list)
		widgets.label(reset, pageConfig.reset, 0)

		reset.Activated:Connect(function()
			-- a wait for a key ends first, so it does not capture the reset keys
			for _, stop in ctx.stoppers do
				stop()
			end

			for _, key in keys do
				for _, name in namesIn(key) do
					keyboardService:resetBinding(name)
				end
			end

			for _, refresh in refreshers do
				refresh()
			end
		end)
	end
end

-- Edit Keybinds: the interface keys. Command Settings: the keys of the commands, under a header for each command
return {
	interface = makePage({
		title = config.pages.keybinds.title,
		reset = config.pages.keybinds.reset,
		groups = {
			{ key = "interface" },
		},
	}),

	commands = makePage({
		title = config.pages.commands.title,
		reset = config.pages.commands.reset,
		groups = keybindsConfig.groups,
	}),
}
