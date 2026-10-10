-- src/ui/components/chatlogs.luau
-- The chat logs window, opened with infiniteYield:chatLogs(tab). It is styled like the other windows
-- (Reference and server info). Every button is on one row:
--   left half:  Clear and Save share the first quarter, Enabled takes the second quarter
--   right half: the Chat and Joins tabs. The selected tab takes 3/4 of the half, the other one 1/4.
-- It is built when opened, slides in, and is destroyed when closed. The entries are kept by the chat
-- logs system, so closing the window does not lose them.

local createService = require("../services/createService")
local assetsService = require("../services/assetsService")
local themeService = require("../services/themeService")
local dragInstance = require("../utils/dragInstance")
local scaleObject = require("../utils/scaleObject")
local scrollBarComponent = require("./scrollBar")
local notifier = require("../notifier")

local privateEnv = require("../../framework/environment/private")
local config = require("../../framework/config/chatlogs")
local robloxServices = require("../../framework/services/rbxServices")
local tweenService = require("../../framework/services/tweenService")
local chatLogs = require("../../commands/systems/chatLogs")
local argColors = require("../../framework/config/colors").args
local highlight = require("../../utils/textHighlight")
local tools = require("../../utils/tools")

local windowConfig = config.window
local TOP_BAR_HEIGHT = windowConfig.topBarHeight
local BODY_TOP = TOP_BAR_HEIGHT + windowConfig.rowHeight
local SHOWN_POSITION = UDim2.new(0, windowConfig.shownX, 0, windowConfig.shownY)
local HIDDEN_POSITION = UDim2.new(0, windowConfig.hiddenX, 0, windowConfig.shownY)

-- Shares of the row, as fractions of its width
local CLEAR_X, CLEAR_WIDTH = 0, 0.125
local SAVE_X, SAVE_WIDTH = 0.125, 0.125
local ENABLED_X, ENABLED_WIDTH = 0.25, 0.25
local TABS_X, TABS_WIDTH = 0.5, 0.5
local SELECTED_TAB_SHARE = 0.75 -- the selected tab takes this part of the tabs half

local chatLogsComponent = {
	window = nil,
	listening = false,
}

-- Places a button in the row: x and width are fractions of the row, with a small inset on every side
local function placeButton(button, scaleX: number, scaleWidth: number)
	local inset = windowConfig.buttonInset
	button.Position = UDim2.new(scaleX, inset, 0, inset)
	button.Size = UDim2.new(scaleWidth, -inset * 2, 1, -inset * 2)
end

-- State colors use theme tokens, so they keep following the selected theme
local function paint(button, token: string)
	themeService:updateObjectProperties(button, { BackgroundColor3 = token })
end

local function isEnabled(kind: string): boolean
	if kind == "chat" then
		return chatLogs.chatEnabled
	end
	return chatLogs.joinEnabled
end

-- The time is dimmed, the name is bold in its chat color, and the rest keeps the token colors of textHighlight
local function formatEntry(kind: string, entry): string
	local time = tools.colorFromRGB(`[{entry.time}]`, argColors.comment)
	local name = `<b>{tools.colorFromRGB(tools.escapeRichText(entry.name), entry.color or argColors.others)}</b>`

	if kind == "chat" then
		return `{time} {name}: {highlight:apply(entry.message)}`
	end
	return `{time} {name} {highlight:apply(`joined (id {entry.userId})`)}`
end

local function isSelectedTab(window, button): boolean
	return window.tabButtons[window.tab] == button
end

local function cancelTabTweens(window)
	for _, tween in window.tweens do
		tween:Cancel()
	end
	table.clear(window.tweens)
end

-- Moves a tab to its place. When animate is set (switching tabs), it slides there with a short tween.
local function moveTab(window, button, scaleX: number, scaleWidth: number, animate: boolean)
	local inset = windowConfig.buttonInset
	local position = UDim2.new(scaleX, inset, 0, inset)
	local size = UDim2.new(scaleWidth, -inset * 2, 1, -inset * 2)

	local duration = tweenService:getScale(windowConfig.tabTweenTime)
	if not animate or duration <= 0 then
		button.Position = position
		button.Size = size
		return
	end

	local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local tween = robloxServices.TweenService:Create(button, info, {
		Position = position,
		Size = size,
	})
	table.insert(window.tweens, tween)
	tween:Play()
end

-- The selected tab takes most of the right half, the other one the rest
local function layoutTabs(window, animate: boolean)
	cancelTabTweens(window)

	local chatShare = if window.tab == "chat" then SELECTED_TAB_SHARE else 1 - SELECTED_TAB_SHARE
	local chatWidth = TABS_WIDTH * chatShare
	local joinWidth = TABS_WIDTH - chatWidth

	moveTab(window, window.tabButtons.chat, TABS_X, chatWidth, animate)
	moveTab(window, window.tabButtons.join, TABS_X + chatWidth, joinWidth, animate)
end

local function refreshPaint(window)
	local enabled = isEnabled(window.tab)
	window.toggle.Text = if enabled then config.controls.enabled else config.controls.disabled
	paint(window.toggle, if enabled then "Colors.OnPrimary" else "Colors.Buttons.Default")
	
	for _, button in window.actions do
		paint(button, "Colors.Buttons.Default")
	end

	for kind, button in window.tabButtons do
		local selected = kind == window.tab
		paint(button, if selected then "Colors.Primary" else "Colors.Buttons.Default")
		themeService:updateObjectProperties(button, { Font = if selected then "Font.Bold" else "Font.Normal" })
	end
end

local function refresh(window, animate: boolean?)
	refreshPaint(window)
	layoutTabs(window, animate == true)
end

local function disconnect(window)
	for _, connection in window.connections do
		connection:Disconnect()
	end
	table.clear(window.connections)
end

local function connect(window, signal, callback)
	table.insert(window.connections, signal:Connect(callback))
end

local function hover(window, button)
	connect(window, button.MouseEnter, function()
		if not isSelectedTab(window, button) then
			paint(button, "Colors.Buttons.Holding")
		end
	end)

	connect(window, button.MouseLeave, function()
		refreshPaint(window)
	end)
end

local function createButton(parent, name: string, text: string, scaleX: number, scaleWidth: number)
	local button = createService.new("TextButton", name, parent, {
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Text = text,
		TextSize = config.textSizes.control,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
		
		createService.new("UICorner", {
			CornerRadius = UDim.new(0, windowConfig.buttonCorner),
		}),
	})

	placeButton(button, scaleX, scaleWidth)
	return button
end

local function applyScroll(window)
	window.content.Position = UDim2.fromOffset(0, -window.scrollBar.index)
end

local function refreshScroll(window)
	local scale = scaleObject:getScale()
	window.scrollBar:setTotalSpace(math.ceil(window.content.AbsoluteSize.Y / scale))
	window.scrollBar:setVisibleSpace(math.ceil(window.container.AbsoluteSize.Y / scale))
	applyScroll(window)
end

local function clearLabels(window)
	for _, label in window.labels do
		label:Destroy()
	end
	table.clear(window.labels)
end

local function addLabel(window, kind: string, entry)
	window.order += 1

	local label = createService.new("TextLabel", "Entry", window.content, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = if window.order % 2 == 1 then windowConfig.stripeTransparency else 1,
		BorderSizePixel = 0,
		LayoutOrder = window.order,
		Size = UDim2.new(1, 0, 0, 0),
		RichText = true,
		Text = formatEntry(kind, entry),
		TextSize = config.textSizes.entry,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},
	})

	table.insert(window.labels, label)
	while #window.labels > config.maxLabels do
		table.remove(window.labels, 1):Destroy()
	end

	-- stay at the newest entry once the layout has updated
	task.defer(function()
		if window.frame.Parent then
			refreshScroll(window)
			window.scrollBar:scrollTo(math.huge)
		end
	end)
end

local function render(window, animate: boolean?)
	clearLabels(window)

	for _, entry in chatLogs.entries[window.tab] do
		addLabel(window, window.tab, entry)
	end

	refresh(window, animate)
end

local function createWindow(tab: string)
	local window = {
		tab = tab,
		labels = {},
		order = 0,
		connections = {},
		tabButtons = {},
		tweens = {},
	}

	local frame = createService.new("Frame", "ChatLogs", {
		Active = true,
		BorderSizePixel = 0,
		Position = HIDDEN_POSITION,
		Size = UDim2.fromOffset(windowConfig.width, windowConfig.height),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},
	})
	window.frame = frame

	-- title bar, same as the other windows: centered title and a close icon on the right
	local topBar = createService.new("Frame", "TopBar", frame, {
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, TOP_BAR_HEIGHT),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},
	})

	createService.new("TextLabel", "Title", topBar, {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = config.title,
		TextSize = config.textSizes.title,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local closeButton = createService.new("TextButton", "Close", topBar, {
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -TOP_BAR_HEIGHT, 0, 0),
		Size = UDim2.fromOffset(TOP_BAR_HEIGHT, TOP_BAR_HEIGHT),
		Text = "",
	})

	local closeIcon = createService.new("ImageLabel", "Icon", closeButton, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5, 5),
		Size = UDim2.fromOffset(windowConfig.closeIconSize, windowConfig.closeIconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})
	assetsService:loadImage(closeIcon, "close")

	-- one row for every button; refresh() places the two tabs for the selected one
	local row = createService.new("Frame", "Controls", frame, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, TOP_BAR_HEIGHT),
		Size = UDim2.new(1, 0, 0, windowConfig.rowHeight),
	})

	local clearButton = createButton(row, "Clear", config.controls.clear, CLEAR_X, CLEAR_WIDTH)
	local saveButton = createButton(row, "Save", config.controls.save, SAVE_X, SAVE_WIDTH)
	window.toggle = createButton(row, "Toggle", config.controls.enabled, ENABLED_X, ENABLED_WIDTH)

	local chatTab = createButton(row, "ChatTab", config.tabs.chat, TABS_X, TABS_WIDTH / 2)
	local joinTab = createButton(row, "JoinTab", config.tabs.join, TABS_X + TABS_WIDTH / 2, TABS_WIDTH / 2)
	
	window.tabButtons = { chat = chatTab, join = joinTab }
	window.actions = { saveButton, clearButton }

	-- the same scroll bar and scrolling as the Reference window
	local scrollBar = scrollBarComponent.new({
		isHorizontal = false,
		barThickness = config.scrollBar.barThickness,
		increment = config.scrollBar.increment,
		wheelIncrement = config.scrollBar.wheelIncrement,
	})
	local scrollBarFrame = scrollBar:create()
	local container = scrollBar.container

	local content = createService.new("Frame", "Content", container, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),

		createService.new("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	createService.new("Frame", "ScrollHolder", frame, {
		Active = true,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, BODY_TOP),
		Size = UDim2.new(1, 0, 1, -BODY_TOP),

		scrollBarFrame,
		container,
	})

	window.scrollBar = scrollBar
	window.container = container
	window.content = content

	connect(window, scrollBar.scrolledSignal, function()
		applyScroll(window)
	end)
	connect(window, content:GetPropertyChangedSignal("AbsoluteSize"), function()
		refreshScroll(window)
	end)
	connect(window, container:GetPropertyChangedSignal("AbsoluteSize"), function()
		refreshScroll(window)
	end)
	connect(window, container.MouseWheelForward, function()
		scrollBar:scrollTo(scrollBar.index - scrollBar.wheelIncrement)
	end)
	connect(window, container.MouseWheelBackward, function()
		scrollBar:scrollTo(scrollBar.index + scrollBar.wheelIncrement)
	end)
	connect(window, dragInstance.dragStarted, function(object)
		if object == frame then
			scrollBar:disableScroll()
		end
	end)
	connect(window, dragInstance.dragEnded, function(object)
		if object == frame then
			scrollBar:enableScroll()
		end
	end)

	connect(window, closeButton.Activated, function()
		chatLogsComponent:close()
	end)

	connect(window, chatTab.Activated, function()
		chatLogsComponent:select("chat")
	end)

	connect(window, joinTab.Activated, function()
		chatLogsComponent:select("join")
	end)

	connect(window, window.toggle.Activated, function()
		local enabled = isEnabled(window.tab)
		if window.tab == "chat" then
			chatLogs.setChat(not enabled)
		else
			chatLogs.setJoin(not enabled)
		end
		refreshPaint(window)
	end)
	
	connect(window, saveButton.Activated, function()
		local success, result = chatLogs.save(window.tab)
		if success then
			notifier:notify(config.messages.saved, result)
		else
			notifier:notify(config.messages.saveFailed, result)
		end
	end)
	
	connect(window, clearButton.Activated, function()
		chatLogs.clear(window.tab)
		clearLabels(window)
	end)

	for _, button in { chatTab, joinTab, window.toggle, saveButton, clearButton } do
		hover(window, button)
	end

	return window
end

-- Adds the new entries of the open tab. Connected once, the first time the window is opened.
local function listen()
	if chatLogsComponent.listening then
		return
	end
	chatLogsComponent.listening = true

	chatLogs.onEntry(function(kind: string, entry)
		local window = chatLogsComponent.window
		if window and window.tab == kind then
			addLabel(window, kind, entry)
		end
	end)
end

-- Opens the window on a tab ("chat" or "join"). If it is already open, it switches to that tab.
function chatLogsComponent:open(tab: string)
	listen()

	local window = self.window
	if window then
		self:select(tab)
		return window
	end

	window = createWindow(tab)
	self.window = window

	window.frame.Parent = privateEnv.screenGui
	window.frame:TweenPosition(SHOWN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, windowConfig.tweenTime, true)
	dragInstance:addGuiObject(window.frame)

	render(window)
	return window
end

function chatLogsComponent:select(tab: string)
	local window = self.window
	if not window then
		return
	end

	window.tab = tab
	render(window, true)
end

function chatLogsComponent:close()
	local window = self.window
	if not window then
		return
	end

	self.window = nil
	disconnect(window)
	cancelTabTweens(window)

	window.frame:TweenPosition(HIDDEN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, windowConfig.tweenTime, true)
	task.delay(windowConfig.tweenTime, function()
		window.frame:Destroy()
	end)
end

-- Forgets the window without tweening it, used when the interface is destroyed
function chatLogsComponent:reset()
	local window = self.window
	if window then
		disconnect(window)
		cancelTabTweens(window)
	end
	self.window = nil
end

return chatLogsComponent
