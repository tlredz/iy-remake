-- src/ui/components/chatlogs.luau

local createService = require("../services/createService")
local assetsService = require("../services/assetsService")
local themeService = require("../services/themeService")
local dragInstance = require("../utils/dragInstance")
local scaleObject = require("../utils/scaleObject")
local scrollBarComponent = require("./scrollBar")
local notifier = require("../notifier")

local privateEnv = require("../../framework/environment/private")
local config = require("../../framework/config/ui/chatlogs")
local robloxServices = require("../../framework/services/rbxServices")
local executorEnv = require("../../framework/environment/executor")
local tweenService = require("../../framework/services/tweenService")
local chatLogs = require("../../commands/systems/chatLogs")
local argColors = require("../../framework/config/ui/colors").args
local highlight = require("../../utils/textHighlight")
local tools = require("../../utils/tools")
local settingsData = require("../../storage/data/settings")

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

-- The Chat/Join switch is a pill-shaped track holding two tabs; a lighter thumb slides under the selected one
local SEGMENT_WIDTH = 0.5 -- each tab takes half of the track
local TAB_X = { chat = 0, join = 0.5 } -- where each tab sits inside the track
local SEGMENT_INSET = windowConfig.tabInset -- gap between the track and the thumb and tabs
local PILL = UDim.new(0.5, 0)

-- Clicking an entry copies it: the message in the chat tab, the user id in the joins tab
local ENTRY_HOVER_TRANSPARENCY = windowConfig.entryHoverTransparency

local chatLogsComponent = {
	window = nil,
	listening = false,
}

-- Places a button in its parent: x and width are fractions of the parent, with a small inset on every side
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
	return chatLogs[if kind == "chat" then "chatEnabled" else "joinEnabled"]
end

local function saveEnabled(kind: string, enabled: boolean)
	settingsData:setValue(`chatlogs.{kind}.enabled`, enabled == true)
	settingsData:save()
end

local function loadEnabled(kind: string, setEnabled)
	setEnabled(settingsData:getValue(`chatlogs.{kind}.enabled`) == true)
end

local function formatEntry(kind: string, entry): string
	local time = tools.colorFromRGB(`[{entry.time}]`, argColors.comment)
	local name = `<b>{tools.colorFromRGB(tools.escapeRichText(entry.name), entry.color or argColors.others)}</b>`

	if kind == "chat" then
		return `{time} {name}: {highlight:apply(entry.message)}`
	end
	return `{time} {name} {highlight:apply(`joined (id {entry.userId})`)}`
end

-- What an entry copies: the message (chat) or the user id (joins)
local function copyValue(kind: string, entry): string
	if kind == "chat" then
		return tostring(entry.message)
	end
	return tostring(entry.userId)
end

local function copyEntry(kind: string, entry)
	if not executorEnv.setclipboard then
		notifier:notify(config.messages.copied, config.messages.noClipboard)
		return
	end

	local value = copyValue(kind, entry)
	executorEnv.setclipboard(value)

	if kind == "chat" then
		notifier:notify(config.messages.copied, config.messages.chatCopied)
	else
		notifier:notify(config.messages.copied, `{config.messages.joinCopied} {value}`)
	end
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

-- Moves the thumb under the selected tab. When animate is set (switching tabs), it slides there with a short tween.
local function moveThumb(window, animate: boolean)
	cancelTabTweens(window)

	local position = UDim2.new(TAB_X[window.tab], SEGMENT_INSET, 0, SEGMENT_INSET)
	local duration = tweenService:getScale(windowConfig.tabTweenTime)
	if not animate or duration <= 0 then
		window.thumb.Position = position
		return
	end

	local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local tween = robloxServices.TweenService:Create(window.thumb, info, {
		Position = position,
	})
	table.insert(window.tweens, tween)
	tween:Play()
end

local function refreshPaint(window)
	local enabled = isEnabled(window.tab)
	window.toggle.Text = if enabled then config.controls.enabled else config.controls.disabled
	paint(window.toggle, if enabled then "Colors.OnPrimary" else "Colors.Buttons.Default")

	for _, button in window.actions do
		paint(button, "Colors.Buttons.Default")
	end

	-- the thumb marks the selected tab, so the tabs stay see-through (hovering an unselected one tints it)
	for _, button in window.tabButtons do
		button.BackgroundTransparency = 1
	end
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
			button.BackgroundTransparency = 0
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

-- The thumb and the tabs share this rectangle: their half of the track, minus the same gap on every side
local function placeSegment(segment, scaleX: number)
	segment.Position = UDim2.new(scaleX, SEGMENT_INSET, 0, SEGMENT_INSET)
	segment.Size = UDim2.new(SEGMENT_WIDTH, -SEGMENT_INSET * 2, 1, -SEGMENT_INSET * 2)
end

-- A Chat/Join tab. It has no background of its own: the thumb shows the selected one.
local function createTab(parent, name: string, text: string, scaleX: number)
	local tab = createService.new("TextButton", name, parent, {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = text,
		TextSize = config.textSizes.tab,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ThemeTag = {
			Font = "Font.Bold",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UICorner", {
			CornerRadius = PILL,
		}),
	})

	placeSegment(tab, scaleX)
	return tab
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

	local stripeTransparency = if window.order % 2 == 1 then windowConfig.stripeTransparency else 1

	local label = createService.new("TextButton", "Entry", window.content, {
		AutoButtonColor = false,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = stripeTransparency,
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

	-- these connections end with the label, which is destroyed when it is trimmed, cleared or the window closes
	label.MouseEnter:Connect(function()
		label.BackgroundTransparency = ENTRY_HOVER_TRANSPARENCY
	end)
	label.MouseLeave:Connect(function()
		label.BackgroundTransparency = stripeTransparency
	end)
	label.Activated:Connect(function()
		copyEntry(kind, entry)
	end)

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

	refreshPaint(window)
	moveThumb(window, animate == true)
end

local function createWindow(tab: string)
	local window = {
		tab = tab,
		labels = {},
		order = 0,
		connections = {},
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

	-- one row for every button; the switch on the right is placed by refreshPaint() for the selected tab
	local row = createService.new("Frame", "Controls", frame, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, TOP_BAR_HEIGHT),
		Size = UDim2.new(1, 0, 0, windowConfig.rowHeight),
	})

	local clearButton = createButton(row, "Clear", config.controls.clear, CLEAR_X, CLEAR_WIDTH)
	local saveButton = createButton(row, "Save", config.controls.save, SAVE_X, SAVE_WIDTH)
	window.toggle = createButton(row, "Toggle", config.controls.enabled, ENABLED_X, ENABLED_WIDTH)

	-- the switch: a dark track, the thumb sliding under the selected tab, then the two tabs on top of it
	local switch = createService.new("Frame", "Switch", row, {
		BorderSizePixel = 0,
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},

		createService.new("UICorner", {
			CornerRadius = PILL,
		}),
	})
	placeButton(switch, TABS_X, TABS_WIDTH)

	window.thumb = createService.new("Frame", "Thumb", switch, {
		BorderSizePixel = 0,
		ThemeTag = {
			BackgroundColor3 = "Colors.Border.Holding",
		},

		createService.new("UICorner", {
			CornerRadius = PILL,
		}),
	})
	placeSegment(window.thumb, TAB_X.chat)

	local chatTab = createTab(switch, "ChatTab", config.tabs.chat, TAB_X.chat)
	local joinTab = createTab(switch, "JoinTab", config.tabs.join, TAB_X.join)

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
		
		saveEnabled(window.tab, not enabled)
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

function chatLogsComponent:restore()
	loadEnabled("chat", chatLogs.setChat)
	loadEnabled("join", chatLogs.setJoin)
end

function chatLogsComponent:open(tab: string)
	self:restore()
	
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