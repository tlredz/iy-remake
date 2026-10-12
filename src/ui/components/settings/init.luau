-- src/ui/components/settings/init.luau
-- The settings panel, opened by the settings button in the top bar (like the original IY).
-- It slides up over the command list. Its layout, text and options come from framework/config/ui/settings.
--
-- An option that has a page (Edit Theme, Edit Keybinds, Edit Aliases, Edit/Goto Waypoints, Manage Plugins, Edit Event Binds)
-- opens it: the page slides in from the right, and its back row slides the list back in. Closing the panel always brings
-- the list back. The options that open a page show an arrow at the right.

local createService = require("../../services/createService")
local connectionService = require("../../../framework/services/connectionService")
local settingsData = require("../../../storage/data/settings")
local config = require("../../../framework/config/ui/settings")
local frameworkSettings = require("../../../framework/settings")

local widgets = require("./widgets")
local buildThemePicker = require("./themePicker")
local buildKeybindsEditor = require("./keybindsEditor")
local buildAliasesEditor = require("./aliasesEditor")
local buildWaypointsEditor = require("./waypointsEditor")
local buildPluginsEditor = require("./pluginsEditor")
local buildEventBindsEditor = require("./eventBindsEditor")

local PANEL = config.panel
local BOX = config.box
local ROW = config.row
local VALUE = config.value

local SHOWN_Y = PANEL.shownY
local HIDDEN_Y = PANEL.hiddenY

-- the editor pages, by the action of the button that opens them
local PAGES = {
	theme = buildThemePicker,
	keybinds = buildKeybindsEditor,
	aliases = buildAliasesEditor,
	waypoints = buildWaypointsEditor,
	plugins = buildPluginsEditor,
	eventBinds = buildEventBindsEditor,
}

local settings = {}
settings.__index = settings

local function saveFlag(key: string, enabled: boolean)
	settingsData:setValue(key, enabled == true)
	settingsData:save()
end

local function readFlag(key: string): boolean
	return settingsData:getValue(key) == true
end

local function slide(frame: GuiObject, position: UDim2, onDone: ((boolean) -> ())?)
	frame:TweenPosition(position, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, PANEL.tweenTime, true, onDone)
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

-- builds one option row. Returns a function that redraws it, when the option has a state to show
function settings:createOption(list, option): (() -> ())?
	local row = widgets.row(list)

	if option.icon then
		widgets.icon(row, option.icon)
	end

	if option.kind == "switch" then
		local key = config.keys[option.setting]
		widgets.label(row, option.label, BOX.size + 2 * PANEL.padding)

		local _, fill = widgets.box(row)

		local function refresh()
			fill.Visible = readFlag(key)
		end

		row.Activated:Connect(function()
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
		widgets.label(row, option.label, VALUE.keybindWidth + 2 * PANEL.padding)
		
		local refresh, stop = widgets.keybind(row, option.binding)
		table.insert(self.stoppers, stop)
		
		return refresh
	end

	-- a button: opens its page when it has one (and shows an arrow for it), and reports its action otherwise
	local hasPage = PAGES[option.action] ~= nil

	if hasPage then
		widgets.chevron(row)
	end

	widgets.label(row, option.label, if hasPage then ROW.chevronSize + 2 * PANEL.padding else 0)

	row.Activated:Connect(function()
		if PAGES[option.action] then
			self:openPage(option.action)
		elseif self.onButton then
			self.onButton(option.action)
		end
	end)

	return nil
end

function settings:createOptions()
	local list = widgets.list(self.panel)

	for _, section in config.sections do
		widgets.header(list, section.title)

		for _, option in section.options do
			local refresh = self:createOption(list, option)

			if refresh then
				table.insert(self.refreshers, refresh)
			end
		end
	end

	-- the version, at the very end of the list
	local footer = config.footer
		:gsub("{name}", frameworkSettings.applicationName)
		:gsub("{version}", frameworkSettings.version)

	widgets.footer(list, footer)
end

function settings:createPages()
	for name, build in PAGES do
		self.pages[name] = {
			frame = widgets.page(self.holder, `{name}Page`, UDim2.fromScale(1, HIDDEN_Y)),
			build = build,
		}
	end
end

function settings.new(options)
	return setmetatable({
		onSwitch = options.onSwitch,
		onButton = options.onButton,
		isOpen = false,
		isShown = false,
		holder = nil,
		panel = nil, -- the list of options
		current = nil, -- the frame on screen: the list, or an editor page
		pages = {},
		refreshers = {},
		stoppers = {}, -- end the waits of the list's keybind boxes
		pageStoppers = {}, -- end the waits of the open page's keybind boxes
		pageConnections = {}, -- the scroll of the open page, followed to place the floating back button
		backRow = nil, -- the back row of the open page
		floatingBack = nil, -- the back button in the corner
		floatingIcon = nil, -- its icon
		backIcon = nil, -- the icon of the back row of the open page, which the floating icon copies
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

	self.holder = holder
	self.panel = widgets.page(holder, "Settings", UDim2.fromScale(0, HIDDEN_Y))
	self.current = self.panel

	self:createOptions()
	self:createPages()
	self:createFloatingBack(holder)

	return holder
end

-- A back button in the top right corner of the panel. It shows while an editor page has scrolled its back row out of
-- view, and does what that row does.
function settings:createFloatingBack(holder: Frame)
	local button = createService.new("TextButton", "FloatingBack", holder, {
		AnchorPoint = Vector2.new(1, 0),
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -(PANEL.floatBackMargin + PANEL.scrollBarThickness), 0, PANEL.floatBackMargin),
		Size = UDim2.fromOffset(PANEL.floatBackSize, PANEL.floatBackSize),
		Text = "",
		Visible = false,
		ZIndex = 2,
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Holding",
		},
		
		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
		createService.new("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 1,
			ThemeTag = {
				Color = "Colors.Border.Default",
			},
		}),
	})

	-- above the button, whatever the ZIndexBehavior is
	local icon = widgets.icon(button, config.pages.backIcon)
	icon.ZIndex = button.ZIndex + 1

	button.Activated:Connect(function()
		self:back()
	end)

	self.floatingBack = button
	self.floatingIcon = icon
end

-- the floating icon shows the same image as the icon of the back row, once that has loaded
function settings:syncFloatingIcon()
	local icon, source = self.floatingIcon, self.backIcon

	if icon and source and source.Image ~= "" and icon.Image ~= source.Image then
		icon.Image = source.Image
	end
end

-- shows the floating back button when the open page has scrolled its back row out of view, and hides it otherwise
function settings:updateFloatingBack()
	local button = self.floatingBack
	if not button then return end

	local page = self.current
	local row = self.backRow
	local show = false

	if self.isShown and page ~= self.panel and row and row.Parent then
		show = row.AbsolutePosition.Y + row.AbsoluteSize.Y <= page.AbsolutePosition.Y
	end

	button.Visible = show

	if show then
		self:syncFloatingIcon()
	end
end

function settings:refresh()
	for _, refresh in self.refreshers do
		refresh()
	end
end

-- stops every box that waits for a key (the panel closed, a page changed, or the command bar took focus)
function settings:stopWaiting()
	for _, stop in self.stoppers do
		stop()
	end

	for _, stop in self.pageStoppers do
		stop()
	end
end

-- builds a page again, so it shows what is current when it opens (its keys, its aliases, its theme)
function settings:buildPage(page)
	widgets.clear(page.frame)
	self.pageStoppers = {}

	for _, connection in self.pageConnections do
		connection:Disconnect()
	end
	table.clear(self.pageConnections)

	page.build(page.frame, {
		back = function()
			self:back()
		end,
		stoppers = self.pageStoppers,
	})

	self.backRow = page.frame:FindFirstChild("BackRow")
	self.backIcon = if self.backRow then self.backRow:FindFirstChild("Icon") else nil

	if self.backIcon then
		-- the image of the back row can arrive after the page is built
		table.insert(self.pageConnections, self.backIcon:GetPropertyChangedSignal("Image"):Connect(function()
			self:syncFloatingIcon()
		end))

		self:syncFloatingIcon()
	end

	table.insert(self.pageConnections, page.frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		self:updateFloatingBack()
	end))
end

-- slides an editor page in from the right, and the list out to the left
function settings:openPage(name: string)
	local page = self.pages[name]
	if not page or not self.isShown or self.current ~= self.panel then return end

	self:stopWaiting()
	self:buildPage(page)

	page.frame.CanvasPosition = Vector2.zero
	page.frame.Position = UDim2.fromScale(1, SHOWN_Y)
	self.current = page.frame

	slide(self.panel, UDim2.fromScale(-1, SHOWN_Y))
	slide(page.frame, UDim2.fromScale(0, SHOWN_Y))

	self:updateFloatingBack()
end

-- slides the editor page out to the right, and the list back in
function settings:back()
	if self.current == self.panel then return end
	
	self:stopWaiting()

	slide(self.current, UDim2.fromScale(1, SHOWN_Y))
	slide(self.panel, UDim2.fromScale(0, SHOWN_Y))
	self.current = self.panel

	self:updateFloatingBack()
end

-- puts every frame back where it rests: the list below the view, the editor pages to the right of it
function settings:reset()
	self.current = self.panel
	self.panel.Position = UDim2.fromScale(0, HIDDEN_Y)

	for _, page in self.pages do
		page.frame.Position = UDim2.fromScale(1, HIDDEN_Y)
	end
end

function settings:toggle()
	self.isOpen = not self.isOpen
	self:setShown(self.isOpen)
end

function settings:setShown(shown: boolean)
	if not self.panel or self.isShown == shown then return end

	self.isShown = shown
	local current = self.current

	self:updateFloatingBack()

	if shown then
		self.holder.Visible = true
		slide(current, UDim2.fromScale(0, SHOWN_Y))
		return
	end

	self:stopWaiting()

	slide(current, UDim2.fromScale(0, HIDDEN_Y), function(completed)
		if completed and not self.isShown then
			self.holder.Visible = false

			-- closed with the button: the next time it opens, it shows the list. A command bar focus keeps the page
			if not self.isOpen then
				self:reset()
			end
		end
	end)
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
