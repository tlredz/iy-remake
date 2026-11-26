-- src/ui/components/settings/importExportEditor.luau
-- The Import / Export page: an Export and an Import button side by side, and a box for a copied text.
-- Export copies the settings, keybinds, aliases, event binds and waypoints as one text, through the exploit's clipboard
-- (or into the box when the exploit has none). Its notification has a copy button, so the text can be copied again.
-- Import reads the text in the box, and asks first: it replaces only the parts the text holds, and a part the text does
-- not have is left as it is.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel. See settings/init.lua.

local themeService = require("../../services/themeService")
local notifier = require("../../notifier")
local widgets = require("./widgets")

local frameworkSettings = require("../../../framework/settings")
local executorEnv = require("../../../framework/environment/executor")
local config = require("../../../framework/config/ui/settings")
local datas = require("../../../storage")
local json = require("../../../utils/json")

local TEXT = config.pages.importExport

-- the parts of an export, by the name they have in the text. Used commands and places are not part of it
local PARTS = { "settings", "aliases", "eventBinds", "waypoints" }

local function exportText(): string
	local data = { version = frameworkSettings.version }

	for _, name in PARTS do
		data[name] = datas[name]:getData()
	end

	return json.encode(data, "export") or ""
end

-- true when the theme is one that can be used. A saved name that is gone is not, so the default is kept
local function isUsableTheme(name: any): boolean
	if type(name) ~= "string" then return false end

	for _, entry in themeService:getThemes() do
		if entry.key == name:lower() and entry.usable then
			return true
		end
	end

	return false
end

-- reads the text of an export. Returns the data and the names of the parts it holds, or nil and the reason why there
-- is nothing to import. Nothing is changed here, so the question can be asked before anything is replaced
local function readText(text: string): ({ [string]: any }?, { string }?, string?)
	if text:match("^%s*$") then
		return nil, nil, TEXT.empty
	end

	local data = json.decode(text, "import")
	if type(data) ~= "table" then
		return nil, nil, TEXT.notAnExport
	end

	local names = {}

	for _, name in PARTS do
		if type(data[name]) == "table" then
			table.insert(names, name)
		end
	end

	if #names == 0 then
		return nil, nil, TEXT.notAnExport
	end

	return data, names
end

-- puts the parts back. The theme and its colors apply at once. The rest is read when IY starts (see restartNote)
local function applyText(data: { [string]: any }, names: { string })
	for _, name in names do
		datas[name]:replaceData(data[name])
	end

	local selected = datas.settings:getValue(config.keys.theme)
	if isUsableTheme(selected) then
		themeService:selectTheme(selected)
	end
end

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, TEXT.title, ctx.back)

	-- the buttons use the box, which is made under them, so it is declared first
	local box: TextBox

	local function exportSettings()
		local text = exportText()

		if executorEnv.setclipboard then
			executorEnv.setclipboard(text)
			notifier:notify(TEXT.notifyTitle, TEXT.copied, nil, { copy = true, copyText = text })
		else
			-- no clipboard: the text goes into the box, so it can be copied from there
			box.Text = text
			notifier:notify(TEXT.notifyTitle, TEXT.copyFailed)
		end
	end

	local function importSettings()
		local data, names, reason = readText(box.Text)

		if not data or not names then
			notifier:notify(TEXT.notifyTitle, reason or TEXT.notAnExport)
			return
		end

		notifier:ask(TEXT.confirmTitle, string.format(TEXT.confirmMessage, table.concat(names, ", ")), {
			{
				text = TEXT.confirmButton,
				primary = true,
				onTap = function()
					applyText(data, names)
					box.Text = ""

					notifier:notify(
						TEXT.notifyTitle,
						string.format(TEXT.imported, table.concat(names, ", ")) .. ". " .. TEXT.restartNote
					)
				end,
			},
			{
				text = TEXT.cancel,
				onTap = function() end,
			},
		}, TEXT.confirmTime)
	end

	widgets.buttonRow(list, {
		{ icon = TEXT.exportIcon, text = TEXT.exportRow, onTap = exportSettings },
		{ icon = TEXT.importIcon, text = TEXT.importRow, onTap = importSettings },
	})

	box = widgets.textBox(list, TEXT.placeholder)
	box.MultiLine = true
	box.TextWrapped = true
	box.TextYAlignment = Enum.TextYAlignment.Top
	box.Size = UDim2.new(1, 0, 0, 96)

	widgets.note(list, TEXT.hint)
end

return build
