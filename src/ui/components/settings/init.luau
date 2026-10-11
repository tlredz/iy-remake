-- src/ui/components/settings.luau
-- The settings panel, opened by the settings button in the top bar (like the original IY).
-- It slides up over the command list. Its layout, text and options come from framework/config/ui/settings.

local createService = require("../../services/createService")
local assetsService = require("../../services/assetsService")
local themeService = require("../../services/themeService")

local connectionService = require("../../../framework/services/connectionService")
local keyboardService = require("../../../framework/services/keyboardService")
local settingsData = require("../../../storage/data/settings")
local config = require("../../../framework/config/ui/settings")

local PANEL = config.panel
local ROW = config.row
local BOX = config.box
local VALUE = config.value
local TEXT = config.textSizes

local SHOWN_POSITION = UDim2.fromScale(0, PANEL.shownY)
local HIDDEN_POSITION = UDim2.fromScale(0, PANEL.hiddenY)

local settings = {}
settings.__index = settings

local function saveFlag(key: string, enabled: boolean)
	settingsData:setValue(key, enabled == true)
	settingsData:save()
end

local function readFlag(key: string): boolean
	return settingsData:getValue(key) == true
end

function settings.isKeepMenuOpen(): boolean
	return readFlag(config.keys.keepMenuOpen)
end

function settings.setKeepMenuOpen(enabled: boolean)
	saveFlag(config.keys.keepMenuOpen, enabled)
end

function settings.isKeepIY(): boolean
	return readFlag(config.keys.keepIY)
end

function settings.setKeepIY(enabled: boolean)
	saveFlag(config.keys.keepIY, enabled)
end

-- a row shows its stripe when idle, and the holding colour while the pointer is over it
local function paintRow(row: GuiObject, stripe: number, hovered: boolean)
	themeService:updateObjectProperties(row, {
		BackgroundColor3 = if hovered then "Colors.Buttons.Holding" else "Colors.Buttons.Default",
	})
	row.BackgroundTransparency = if hovered then 0 else stripe
end

local function createRow(panel: Frame, order: number, index: number): GuiObject
	local stripe = if index % 2 == 1 then PANEL.stripeTransparency else 1

	local row = createService.new("TextButton", "Option", panel, {
		AutoButtonColor = false,
		BackgroundTransparency = stripe,
		BorderSizePixel = 0,
		LayoutOrder = order,
		Size = UDim2.new(1, 0, 0, PANEL.rowHeight),
		Text = "",
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},
	})

	connectionService:Connect(row.MouseEnter, function()
		paintRow(row, stripe, true)
	end)

	connectionService:Connect(row.MouseLeave, function()
		paintRow(row, stripe, false)
	end)

	return row
end

local function createHeader(panel: Frame, order: number, title: string)
	createService.new("TextLabel", "Header", panel, {
		BackgroundTransparency = 1,
		LayoutOrder = order,
		Size = UDim2.new(1, 0, 0, PANEL.headerHeight),
		Text = title,
		TextSize = TEXT.header,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Darker",
		},
	})
end

local function createLabel(row: GuiObject, text: string, rightSpace: number)
	return createService.new("TextLabel", "Label", row, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(ROW.labelInset, 0),
		Size = UDim2.new(1, -(ROW.labelInset + rightSpace), 1, 0),
		Text = text,
		TextSize = TEXT.label,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})
end

local function createIcon(row: GuiObject, option)
	local icon = createService.new("ImageLabel", "Icon", row, {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, ROW.iconInset, 0.5, 0),
		Size = UDim2.fromOffset(ROW.iconSize, ROW.iconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	--[[if option.spriteX then
		icon.ScaleType = Enum.ScaleType.Crop
		icon.ImageRectSize = Vector2.new(ROW.iconSize, ROW.iconSize)
		icon.ImageRectOffset = Vector2.new(option.spriteX, 0)
	end]]

	assetsService:loadImage(icon, option.icon)
	return icon
end

local function createBox(row: GuiObject): (Frame, Frame)
	local box = createService.new("Frame", "Box", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -PANEL.padding, 0.5, 0),
		Size = UDim2.fromOffset(BOX.size, BOX.size),
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, BOX.cornerRadius),
		}),
		createService.new("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 1,
			ThemeTag = {
				Color = "Colors.Border.Default",
			},
		}),
	})

	local fill = createService.new("Frame", "Fill", box, {
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(BOX.inset, BOX.inset),
		Size = UDim2.new(1, -2 * BOX.inset, 1, -2 * BOX.inset),
		ThemeTag = {
			BackgroundColor3 = "Colors.Primary",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, BOX.fillCornerRadius),
		}),
	})

	return box, fill
end

-- a box that shows some text. Returns the box and its text label
local function createValue(row: GuiObject, text: string, width: number): (Frame, TextLabel)
	local value = createService.new("Frame", "Value", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -PANEL.padding, 0.5, 0),
		Size = UDim2.fromOffset(width, VALUE.height),
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
	})

	local label = createService.new("TextLabel", "Text", value, {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = text,
		TextSize = TEXT.value,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},
	})

	return value, label
end

-- a row that shows the key of a binding. Tapping it waits for the next key press to become the new key;
-- tapping again, or Escape, cancels. Returns the function that redraws it
local function createKeybind(self, row: GuiObject, option): () -> ()
	createLabel(row, option.label, VALUE.keybindWidth + 2 * PANEL.padding)

	local value, text = createValue(row, "", VALUE.keybindWidth)
	local cancelWait = nil -- set while the box waits for a key

	local function refresh()
		local waiting = cancelWait ~= nil

		text.Text = if waiting then "press a key" else keyboardService:getBindingName(option.binding)
		themeService:updateObjectProperties(value, {
			BackgroundColor3 = if waiting then "Colors.Primary" else "Colors.Buttons.Default",
		})
	end

	local function stopWaiting()
		if cancelWait then
			local cancel = cancelWait
			cancelWait = nil
			cancel()
		end

		refresh()
	end

	table.insert(self.stoppers, stopWaiting)

	connectionService:Connect(row.Activated, function()
		if cancelWait then
			stopWaiting()
			return
		end

		cancelWait = keyboardService:capture(function(keyCode)
			cancelWait = nil
			keyboardService:setBinding(option.binding, keyCode)
			refresh()
		end, function()
			-- Escape
			cancelWait = nil
			refresh()
		end)

		refresh()
	end)

	refresh()
	return refresh
end

-- builds one option row. Returns a function that redraws it, when the option has a state to show
local function createOption(self, panel: Frame, order: number, index: number, option): (() -> ())?
	local row = createRow(panel, order, index)

	if option.icon then
		createIcon(row, option)
	end

	if option.kind == "switch" then
		local key = config.keys[option.setting]
		createLabel(row, option.label, BOX.size + 2 * PANEL.padding)

		local _, fill = createBox(row)

		local function refresh()
			fill.Visible = readFlag(key)
		end

		connectionService:Connect(row.Activated, function()
			local enabled = not readFlag(key)
			saveFlag(key, enabled)
			refresh()

			if self.onSwitch then
				self.onSwitch(option.setting, enabled)
			end
		end)

		refresh()
		return refresh
	end

	if option.kind == "keybind" then
		return createKeybind(self, row, option)
	end

	createLabel(row, option.label, 0)

	connectionService:Connect(row.Activated, function()
		if self.onButton then
			self.onButton(option.action)
		end
	end)

	return nil
end

function settings.new(options)
	return setmetatable({
		onSwitch = options.onSwitch,
		onButton = options.onButton,
		isOpen = false,
		isShown = false,
		holder = nil,
		panel = nil,
		refreshers = {},
		stoppers = {},
	}, settings)
end

function settings:create(parent: Instance, listArea: GuiObject): Frame
	local holder = createService.new("Frame", "SettingsHolder", parent, {
		AnchorPoint = listArea.AnchorPoint,
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Position = listArea.Position,
		Size = listArea.Size,
		Visible = false,
	})

	-- a scrolling panel: the list is longer than the area it is shown in
	local panel = createService.new("ScrollingFrame", "Settings", holder, {
		Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
		ElasticBehavior = Enum.ElasticBehavior.Never,
		Position = HIDDEN_POSITION,
		ScrollBarThickness = PANEL.scrollBarThickness,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Size = UDim2.fromScale(1, 1),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
			ScrollBarImageColor3 = "Colors.ScrollBar.Thumb",
		},

		createService.new("UIPadding", {
			PaddingLeft = UDim.new(0, PANEL.padding),
			PaddingRight = UDim.new(0, PANEL.padding),
			PaddingTop = UDim.new(0, PANEL.padding),
			PaddingBottom = UDim.new(0, PANEL.padding),
		}),
		createService.new("UIListLayout", {
			Padding = UDim.new(0, PANEL.rowGap),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	self.holder = holder
	self.panel = panel

	local order = 0

	for _, section in config.sections do
		order += 1
		createHeader(panel, order, section.title)

		for index, option in section.options do
			order += 1

			local refresh = createOption(self, panel, order, index, option)
			if refresh then
				table.insert(self.refreshers, refresh)
			end
		end
	end

	return holder
end

function settings:refresh()
	for _, refresh in self.refreshers do
		refresh()
	end
end

-- stops every box that waits for a key (the panel closed, or the command bar took focus)
function settings:stopWaiting()
	for _, stop in self.stoppers do
		stop()
	end
end

function settings:toggle()
	self.isOpen = not self.isOpen
	self:setShown(self.isOpen)
end

function settings:setShown(shown: boolean)
	if not self.panel or self.isShown == shown then return end

	self.isShown = shown
	local holder = self.holder
	local panel = self.panel

	if shown then
		holder.Visible = true
		panel:TweenPosition(SHOWN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, PANEL.tweenTime, true)
	else
		self:stopWaiting()

		panel:TweenPosition(HIDDEN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, PANEL.tweenTime, true, function(completed)
			if completed and not self.isShown then
				holder.Visible = false
			end
		end)
	end
end

function settings:watchCommandBar(searchBox: TextBox)
	connectionService:Connect(searchBox.Focused, function()
		self:setShown(false)
	end)

	connectionService:Connect(searchBox.FocusLost, function()
		self:setShown(self.isOpen)
	end)
end

return settings
