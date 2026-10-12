-- src/ui/components/settings/keybindsEditor.luau
-- The Edit Keybinds page: a row for each binding in framework/config/services/keybinds, and a row that puts
-- every binding back to its default key.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel, and ctx.stoppers collects the functions that
-- end a wait for a key. See settings/init.luau.

local keyboardService = require("../../../framework/services/keyboardService")
local keybindsConfig = require("../../../framework/config/services/keybinds")
local config = require("../../../framework/config/ui/settings")
local widgets = require("./widgets")

local PANEL = config.panel
local VALUE = config.value

local function sortedNames(): { string }
	local names = {}

	for name in keybindsConfig.bindings do
		table.insert(names, name)
	end

	table.sort(names)
	return names
end

-- the keys that always work for a binding, whatever key it is set to, as one line each ("Right Control also works as the Prefix")
local function fixedKeyLines(): { string }
	local lines = {}

	for _, name in sortedNames() do
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

	return lines
end

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, config.pages.keybinds.title, ctx.back)

	local refreshers = {}

	for _, name in sortedNames() do
		local binding = keybindsConfig.bindings[name]
		local row = widgets.row(list)

		widgets.label(row, binding.label or name, VALUE.keybindWidth + 2 * PANEL.padding)

		local refresh, stop = widgets.keybind(row, name)
		table.insert(refreshers, refresh)
		table.insert(ctx.stoppers, stop)
	end

	local fixedLines = fixedKeyLines()
	if #fixedLines > 0 then
		widgets.note(list, table.concat(fixedLines, "\n"))
	end

	local reset = widgets.row(list)
	widgets.label(reset, config.pages.keybinds.reset, 0)

	reset.Activated:Connect(function()
		-- a wait for a key ends first, so it does not capture the reset keys
		for _, stop in ctx.stoppers do
			stop()
		end

		for name in keybindsConfig.bindings do
			keyboardService:resetBinding(name)
		end

		for _, refresh in refreshers do
			refresh()
		end
	end)
end

return build
