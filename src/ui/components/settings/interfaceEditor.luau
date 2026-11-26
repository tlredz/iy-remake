-- src/ui/components/settings/interfaceEditor.luau
-- The Interface page, the first entry of Editors (above Edit Theme). Its rows:
--   Keep Menu Open              the switch that was in General: the window stays open (the dock reads it)
--   UI Scale                    a slider of the UI scale, from the min to the max scale of framework/settings
--   Transparent When Minimized  the window fades out while it is minimized, so it covers less of the game (the dock)
--   Hide IY                     the box of hideiy: checked, the window is hidden until the prefix key or the IY button
-- Built by build(page, ctx): ctx.back goes to the panel, ctx.actions has the window's functions (getScale, setScale,
-- isHidden, setHidden), and ctx.onSwitch tells the panel that a switch changed. See settings/init.lua.

local frameworkSettings = require("../../../framework/settings")
local settingsData = require("../../../storage/data/settings")
local config = require("../../../framework/config/ui/settings")
local widgets = require("./widgets")

local PANEL = config.panel
local BOX = config.box
local TEXT = config.pages.interface

local SCALE = frameworkSettings.ui.scale

-- the UI scale of a slider amount: 0 is the min scale, 1 the max scale. Kept to two decimals
local function scaleAt(amount: number): number
	local scale = SCALE.minScale + amount * (SCALE.maxScale - SCALE.minScale)
	return math.round(scale * 100) / 100
end

local function amountOf(scale: number): number
	return math.clamp((scale - SCALE.minScale) / (SCALE.maxScale - SCALE.minScale), 0, 1)
end

local function saveFlag(key: string, enabled: boolean)
	settingsData:setValue(key, enabled)
	settingsData:save()
end

local function readFlag(key: string): boolean
	return settingsData:getValue(key) == true
end

-- a row with a box: its label, and the box filled while read() is true. Tapping it writes the opposite value
local function switchRow(list, label: string, iconName: string, read: () -> boolean, write: (boolean) -> ())
	local row = widgets.row(list)
	widgets.icon(row, iconName)
	widgets.label(row, label, BOX.size + 2 * PANEL.padding)

	local _, fill = widgets.box(row)

	local function refresh()
		fill.Visible = read()
	end

	row.Activated:Connect(function()
		write(not read())
		refresh()
	end)

	refresh()
end

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, TEXT.title, ctx.back)

	local actions = ctx.actions

	switchRow(list, TEXT.keepMenuOpen, TEXT.icons.keepMenuOpen, function()
		return readFlag(config.keys.keepMenuOpen)
	end, function(enabled: boolean)
		saveFlag(config.keys.keepMenuOpen, enabled)

		if ctx.onSwitch then
			ctx.onSwitch("keepMenuOpen", enabled)
		end
	end)

	local scaleRow = widgets.row(list)
	widgets.icon(scaleRow, TEXT.icons.uiScale)

	widgets.slider(scaleRow, TEXT.uiScale, amountOf(actions.getScale()), function(amount: number)
		actions.setScale(scaleAt(amount))
	end, function(amount: number): string
		return `{math.round(scaleAt(amount) * 100)}%`
	end)

	switchRow(list, TEXT.transparent, TEXT.icons.transparent, function()
		return readFlag(config.keys.transparentMinimized)
	end, function(enabled: boolean)
		saveFlag(config.keys.transparentMinimized, enabled)

		if ctx.onSwitch then
			ctx.onSwitch("transparentWhenMinimized", enabled)
		end
	end)

	switchRow(list, TEXT.hide, TEXT.icons.hide, function()
		return actions.isHidden()
	end, function(hidden: boolean)
		actions.setHidden(hidden)
	end)
end

return build
