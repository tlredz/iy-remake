-- src/ui/components/settings/aliasesEditor.luau
-- The Edit Aliases page: type an alias and the command it runs to add it, and tap an alias in the list to remove it.
-- A notification (with an Undo button, see ui/notifier) says which alias was removed.
-- It lists the custom aliases only (the ones made with addalias), and uses the same functions as addalias and
-- removealias, so the change is saved and works in the command bar at once.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel. See settings/init.luau.

local aliasesData = require("../../../storage/data/aliases")
local customAliases = require("../../../commands/systems/customAliases")
local commandsList = require("../../../commands/list")
local config = require("../../../framework/config/ui/settings")
local notifier = require("../../notifier")
local widgets = require("./widgets")

local PANEL = config.panel
local VALUE = config.value
local TEXT = config.pages.aliases

local function trim(text: string): string
	return text:match("^%s*(.-)%s*$") or ""
end

-- the command bar reads these as something else (a separator, a loop, a repeat, a list, quotes), so an alias with
-- one of them could never be typed
local function hasReservedCharacter(alias: string): boolean
	return alias:find("[\\%^!,|&\"']") ~= nil
end

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, config.pages.aliases.title, ctx.back)

	widgets.header(list, TEXT.addTitle)
	local aliasBox = widgets.textBox(list, TEXT.aliasHint)
	local commandBox = widgets.textBox(list, TEXT.commandHint)

	local addRow = widgets.row(list)
	widgets.label(addRow, TEXT.addButton, 0)

	local note = widgets.note(list, "")

	widgets.header(list, TEXT.listTitle)
	widgets.note(list, TEXT.listHint)

	local rowsGroup = widgets.group(list)

	local renderAliases

	-- tells which alias was removed, in the stack of notifications, with a button to put it back
	local function askUndo(alias: string, commandName: string)
		notifier:ask(TEXT.undoTitle, string.format(TEXT.undoMessage, alias, commandName), {
			{
				text = TEXT.undo,
				primary = true,
				onTap = function()
					local added, reason = customAliases.add(commandsList, alias, commandName)

					if not added then
						notifier:notify(TEXT.notifyTitle, reason or "")
						return
					end

					-- the page may have been built again (or closed) meanwhile
					if rowsGroup.Parent then
						note.Text = string.format(TEXT.restored, alias)
						renderAliases()
					end
				end,
			},
		}, TEXT.undoTime)
	end

	function renderAliases()
		widgets.clear(rowsGroup)

		local aliases = aliasesData:getData()
		local names = {}

		for alias in aliases do
			table.insert(names, alias)
		end

		table.sort(names)

		local rows = widgets.list(rowsGroup)

		if #names == 0 then
			widgets.note(rows, TEXT.empty)
			return
		end

		for _, alias in names do
			local row = widgets.row(rows)

			widgets.label(row, alias, VALUE.aliasWidth + 2 * PANEL.padding)
			widgets.value(row, tostring(aliases[alias]), VALUE.aliasWidth)

			row.Activated:Connect(function()
				local removed, target = customAliases.remove(commandsList, alias)

				if removed then
					note.Text = string.format(TEXT.removed, alias)
					askUndo(alias, target :: string)
				end

				renderAliases()
			end)
		end
	end

	local function addAlias()
		local alias = trim(aliasBox.Text)
		local commandName = trim(commandBox.Text)

		if alias == "" or commandName == "" then
			note.Text = TEXT.missing
			return
		end

		if alias:find("%s") then
			note.Text = TEXT.spaces
			return
		end

		if hasReservedCharacter(alias) then
			note.Text = TEXT.badCharacters
			return
		end

		local added, reason = customAliases.add(commandsList, alias, commandName)

		if added then
			note.Text = string.format(TEXT.added, alias:lower())
			aliasBox.Text = ""
			commandBox.Text = ""
			renderAliases()
		else
			note.Text = reason or ""
		end
	end

	addRow.Activated:Connect(addAlias)

	-- enter in the alias box moves to the command, and enter in the command box adds it
	aliasBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			commandBox:CaptureFocus()
		end
	end)

	commandBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			addAlias()
		end
	end)

	renderAliases()
end

return build
