-- src/ui/components/settings/importExportEditor.luau
-- The Import / Export page. Export copies the settings, keybinds, aliases, event binds and waypoints as one text:
-- through the exploit's clipboard, or into the box when the exploit has none. Import reads the text in the box and
-- puts back every part the text has. A part the text does not have is left as it is.
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

-- puts the parts of the text back. Returns the names of the parts, or nil and the reason why there is nothing to import
local function importText(text: string): ({ string }?, string?)
	if text:match("^%s*$") then
		return nil, TEXT.empty
	end

	local data = json.decode(text, "import")
	if type(data) ~= "table" then
		return nil, TEXT.notAnExport
	end

	local imported = {}

	for _, name in PARTS do
		if type(data[name]) == "table" then
			datas[name]:replaceData(data[name])
			table.insert(imported, name)
		end
	end

	if #imported == 0 then
		return nil, TEXT.notAnExport
	end

	-- the theme and its colors apply at once. The rest is read when IY starts (see restartNote)
	local selected = datas.settings:getValue(config.keys.theme)
	if isUsableTheme(selected) then
		themeService:selectTheme(selected)
	end

	return imported
end

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, TEXT.title, ctx.back)

	widgets.header(list, TEXT.exportTitle)

	local exportRow = widgets.row(list)
	widgets.label(exportRow, TEXT.exportRow, 0)

	widgets.note(list, TEXT.exportHint)

	widgets.header(list, TEXT.importTitle)

	local box = widgets.textBox(list, TEXT.placeholder)
	box.MultiLine = true
	box.TextWrapped = true
	box.TextYAlignment = Enum.TextYAlignment.Top
	box.Size = UDim2.new(1, 0, 0, 96)

	local importRow = widgets.row(list)
	widgets.label(importRow, TEXT.importRow, 0)

	widgets.note(list, TEXT.importHint)
	widgets.note(list, TEXT.restartNote)

	exportRow.Activated:Connect(function()
		local text = exportText()

		if executorEnv.setclipboard then
			executorEnv.setclipboard(text)
			notifier:notify(TEXT.notifyTitle, TEXT.copied)
		else
			-- no clipboard: the text goes into the box, so it can be copied from there
			box.Text = text
			notifier:notify(TEXT.notifyTitle, TEXT.copyFailed)
		end
	end)

	importRow.Activated:Connect(function()
		local imported, reason = importText(box.Text)

		if imported then
			box.Text = ""
			notifier:notify(TEXT.notifyTitle, string.format(TEXT.imported, table.concat(imported, ", ")))
		else
			notifier:notify(TEXT.notifyTitle, reason or TEXT.notAnExport)
		end
	end)
end

return build
