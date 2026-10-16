-- src/ui/components/settings/themePicker.luau
-- The Edit Theme page: lists the themes, and the one in use has its box filled. Tapping a theme uses it at once,
-- and it is kept for the next start. A theme without its Colors or Font is listed, but can't be picked yet.
--
-- The theme in use also shows a row of mini checkboxes, one per primary color (framework/config/ui/themes). The
-- one picked is filled, and tapping another one applies it at once. Each theme keeps its own pick (themeService).
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel. See settings/init.lua.

local createService = require("../../services/createService")
local themeService = require("../../services/themeService")
local settingsData = require("../../../storage/data/settings")
local config = require("../../../framework/config/ui/settings")
local widgets = require("./widgets")

local PANEL = config.panel
local BOX = config.box
local TEXT = config.textSizes

local CHECK_SIZE = 14 -- the colored square of a checkbox
local CHECK_HIT = 20 -- the area a finger can tap for it
local CHECK_GAP = 4

-- the row of primary color checkboxes, under the row of its theme. Shown only while that theme is in use
local function createSwatchRow(list, entry, onPick: (string) -> ())
	list.order += 1

	local options = themeService:getPrimaryOptions()

	local row = createService.new("Frame", "Primary", list.parent, {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, PANEL.rowHeight),
		Visible = false,
	})

	createService.new("TextLabel", "Label", row, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(config.row.labelInset, 0),
		Size = UDim2.new(1, -config.row.labelInset, 1, 0),
		Text = config.pages.theme.primary,
		TextSize = TEXT.value,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Darker",
		},
	})

	local visuals = {} -- [option key] = the colored square, filled when the option is picked

	for index, option in options do
		-- the first option is the right-most one, so the options read from left to right in the order of the config
		local slot = #options - index

		local hit = createService.new("TextButton", "Pick", row, {
			AnchorPoint = Vector2.new(1, 0.5),
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -(PANEL.padding + slot * (CHECK_HIT + CHECK_GAP)), 0.5, 0),
			Size = UDim2.fromOffset(CHECK_HIT, CHECK_HIT),
			Text = "",
		})

		local visual = createService.new("Frame", "Check", hit, {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = themeService:getPrimaryColor(entry.theme, option.key),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(CHECK_SIZE, CHECK_SIZE),

			createService.new("UICorner", {
				CornerRadius = UDim.new(0, BOX.cornerRadius),
			}),
			createService.new("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = themeService:getPrimaryColor(entry.theme, option.key),
				Thickness = 1.5,
			}),
		})

		visuals[option.key] = visual

		hit.Activated:Connect(function()
			onPick(option.key)
		end)
	end

	local function redraw()
		local picked = themeService:getPrimaryKey(entry.key)

		for key, visual in visuals do
			visual.BackgroundTransparency = if key == picked then 0 else 1
		end
	end

	return row, redraw
end

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, config.pages.theme.title, ctx.back)

	local items = {} -- { entry, fill, swatchRow, redrawSwatches }

	local function redraw()
		local inUse = themeService.selectedKey

		for _, item in items do
			local selected = inUse == item.entry.key

			item.fill.Visible = selected
			item.swatchRow.Visible = selected

			if selected and item.redrawSwatches then
				item.redrawSwatches()
			end
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

		local item = { entry = entry, fill = fill }

		if entry.usable then
			local swatchRow, redrawSwatches = createSwatchRow(list, entry, function(primaryKey)
				themeService:setPrimary(entry.key, primaryKey)
				redraw()
			end)

			item.swatchRow = swatchRow
			item.redrawSwatches = redrawSwatches
		else
			-- a theme that can't be used has no colors to pick, so its row stays empty
			local empty = createService.new("Frame", "Primary", list.parent, {
				Visible = false,
				Size = UDim2.new(1, 0, 0, 0),
				BackgroundTransparency = 1,
			})

			item.swatchRow = empty
		end

		table.insert(items, item)
	end

	redraw()
end

return build
