-- src/ui/components/settings/themePicker.luau
-- The Edit Theme page: lists the themes, and the one in use has its box filled. Tapping a theme uses it at once,
-- and it is kept for the next start. A theme without its Colors or Font is listed, but can't be picked yet.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel. See settings/init.luau.

local themeService = require("../../services/themeService")
local settingsData = require("../../../storage/data/settings")
local config = require("../../../framework/config/ui/settings")
local widgets = require("./widgets")

local PANEL = config.panel
local BOX = config.box

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, config.pages.theme.title, ctx.back)

	local fills = {} -- [theme entry] = the fill of its box

	local function redraw()
		for entry, fill in fills do
			fill.Visible = themeService.selectedTheme == entry.theme
		end
	end

	local function select(entry)
		themeService:selectTheme(entry.key)

		settingsData:setValue(config.keys.theme, entry.key)
		settingsData:save()

		redraw()
	end

	for _, entry in themeService:getThemes() do
		local row = widgets.row(list)

		if entry.usable then
			widgets.label(row, entry.name, BOX.size + 2 * PANEL.padding)
			row.Activated:Connect(function()
				select(entry)
			end)
		else
			widgets.label(row, `{entry.name} {config.pages.theme.incomplete}`, BOX.size + 2 * PANEL.padding, "Colors.Text.Darker")
		end

		local _, fill = widgets.box(row)
		fills[entry] = fill
	end

	redraw()
end

return build
