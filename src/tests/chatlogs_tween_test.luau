
local passed, failed = 0, 0
local function check(name, cond)
	if cond then passed += 1; print("PASS  " .. name)
	else failed += 1; print("FAIL  " .. name) end
end

-- ===== scheduler for task.* (time only moves when advance() is called) =====
local clock = 0
local sleepers = {}
local function drive(co, ...)
	local ok, delay = coroutine.resume(co, ...)
	if not ok then error(delay, 0) end
	if coroutine.status(co) ~= "dead" then
		table.insert(sleepers, { at = clock + (delay or 0), co = co })
	end
end
task = {}
function task.spawn(f, ...) local co = coroutine.create(f); drive(co, ...); return co end
function task.defer(f, ...) return task.spawn(f, ...) end
function task.delay(t, f) task.spawn(function() task.wait(t); f() end) end
function task.wait(t) return coroutine.yield(t or 0) end
local function advance(dt)
	local target = clock + dt
	while true do
		local best, index
		for i, s in sleepers do
			if s.at <= target and (best == nil or s.at < best.at) then best, index = s, i end
		end
		if not best then break end
		table.remove(sleepers, index)
		clock = best.at
		drive(best.co)
	end
	clock = target
end

-- ===== Roblox-ish values =====
local enumCache = {}
local function enumProxy(path)
	if enumCache[path] then return enumCache[path] end
	local t = setmetatable({}, { __index = function(_, k) return enumProxy(path .. "." .. k) end })
	enumCache[path] = t
	return t
end
Enum = enumProxy("Enum")
Color3 = { fromRGB = function(r, g, b) return { r = r, g = g, b = b } end, new = function(r, g, b) return { r = r, g = g, b = b } end }
UDim2 = { new = function(...) return { ... } end, fromOffset = function(...) return { ... } end, fromScale = function(...) return { ... } end }
UDim = { new = function(...) return { ... } end }
Vector2 = { new = function(x, y) return { X = x, Y = y } end }
game = { PlaceId = 123 }

local Signal = {}
Signal.__index = Signal
function Signal.new() return setmetatable({ handlers = {} }, Signal) end
function Signal:Connect(fn)
	local conn = { connected = true }
	conn.Disconnect = function() conn.connected = false end
	table.insert(self.handlers, { fn = fn, conn = conn })
	return conn
end
function Signal:fire(...)
	for _, h in self.handlers do
		if h.conn.connected then task.spawn(h.fn, ...) end
	end
end

local created = {}
Instance = { new = function(className)
	local obj = {
		ClassName = className,
		AbsoluteCanvasSize = Vector2.new(0, 0),
		AbsoluteSize = Vector2.new(0, 0),
		MouseWheelForward = Signal.new(),
		MouseWheelBackward = Signal.new(),
		Activated = Signal.new(),
		MouseEnter = Signal.new(),
		MouseLeave = Signal.new(),
		destroyed = false,
	}
	function obj:Destroy() self.destroyed = true; self.Parent = nil end
	function obj:WaitForChild() return self.waitResult or self end
	function obj:TweenPosition(position) self.Position = position end
	function obj:GetPropertyChangedSignal() return Signal.new() end
	table.insert(created, obj)
	return obj
end }
local function findByName(name: string)
	for i = #created, 1, -1 do
		local o = created[i]
		if o.Name == name and not o.destroyed then return o end
	end
	error("no live object named " .. name)
end
local function labelsContaining(text: string)
	local found = {}
	for _, o in created do
		if o.ClassName == "TextLabel" and not o.destroyed and type(o.Text) == "string" and string.find(o.Text, text, 1, true) then
			table.insert(found, o)
		end
	end
	return found
end

-- ===== services and state =====
local SENT = {}
local SEND_FAIL = false
local ASYNC_CALLS, FIRE_CALLS = 0, 0
local CONFIG = {
	BubbleChatConfiguration = { Enabled = false },
	ChatWindowConfiguration = { Enabled = false },
	ChatInputBarConfiguration = { Enabled = false },
}
local TEXT, LEGACY = Enum.ChatVersion.TextChatService, Enum.ChatVersion.LegacyChatService
local TEXT_CHAT = {
	ChatVersion = TEXT,
	MessageReceived = Signal.new(),
	TextChannels = { RBXGeneral = { SendAsync = function(self, msg)
		if SEND_FAIL then error("muted by the game") end
		ASYNC_CALLS += 1
		table.insert(SENT, msg)
	end } },
	BubbleChatConfiguration = CONFIG.BubbleChatConfiguration,
	ChatWindowConfiguration = CONFIG.ChatWindowConfiguration,
	ChatInputBarConfiguration = CONFIG.ChatInputBarConfiguration,
	FindFirstChildOfClass = function(self, className) return CONFIG[className] end,
}
local ALL_PLAYERS = {}
local PLAYERS_SERVICE = { PlayerAdded = Signal.new() }
local function newPlayer(name, userId)
	return { Name = name, UserId = userId, Chatted = Signal.new(), CharacterAdded = Signal.new(), Parent = PLAYERS_SERVICE }
end
function PLAYERS_SERVICE:GetPlayers()
	local list = {}
	for _, p in ALL_PLAYERS do if p.Parent == PLAYERS_SERVICE then table.insert(list, p) end end
	return list
end
function PLAYERS_SERVICE:GetPlayerByUserId(id)
	for _, p in ALL_PLAYERS do if p.UserId == id then return p end end
end
LOCAL = newPlayer("Me", 1)
BOB = newPlayer("Bob", 2)
CARL = newPlayer("Carl", 3)
ANN = newPlayer("Ann", 4)
ALL_PLAYERS = { LOCAL, BOB, CARL, ANN }
PLAYERS_SERVICE.LocalPlayer = LOCAL

local LEG_TARGET = nil
local ReplicatedStorage = { DefaultChatSystemChatEvents = { SayMessageRequest = { FireServer = function(self, msg, to)
	if SEND_FAIL then error("muted by the game") end
	FIRE_CALLS += 1
	table.insert(SENT, msg); LEG_TARGET = to
end } } }
local CHAT_SERVICE = { BubbleChatEnabled = false }
local CORE = {}
local STARTER_GUI = { SetCore = function(self, name, value) CORE[name] = value end }
local LISTENER = {}
local SOUND_SERVICE = { SetListener = function(self, kind, obj) LISTENER = { kind, obj } end }
local HTTP_LOG = {}
local HttpService = {
	JSONEncode = function(self, t) return t end,
	JSONDecode = function(self, s) if s == "avatar" then return { data = { { state = "Completed", imageUrl = "https://cdn.test/avatar.png" } } } end return { data = {} } end,
}
local VC = { PAUSE_ALL = nil, PAUSE = {} }
VC.SubscribePauseAll = function(self, v) VC.PAUSE_ALL = v end
VC.SubscribePause = function(self, id, v) VC.PAUSE[id] = v end
local CAN_CALL = true
local PROMPTED = nil
local SocialService = {
	CanSendCallInviteAsync = function(self, p) return CAN_CALL end,
	PromptPhoneBook = function(self, p, s) PROMPTED = p end,
}
local RBX = {
	Players = PLAYERS_SERVICE,
	TextChatService = TEXT_CHAT,
	ReplicatedStorage = ReplicatedStorage,
	Chat = CHAT_SERVICE,
	StarterGui = STARTER_GUI,
	SoundService = SOUND_SERVICE,
	HttpService = HttpService,
	SocialService = SocialService,
	VoiceChatInternal = VC,
}

local FILES, MADE = {}, {}
local EXEC = {
	httprequest = function(req)
		table.insert(HTTP_LOG, req)
		if string.find(req.Url, "thumbnails", 1, true) then return { Body = "avatar" } end
		return { Body = "ok" }
	end,
	writefile = function(path, content) FILES[path] = content end,
	makefolder = function(path) table.insert(MADE, path) end,
}
local SETTINGS_STORE = {}
local SETTINGS = {
	getValue = function(self, key) return SETTINGS_STORE[key] end,
	setValue = function(self, key, value) SETTINGS_STORE[key] = value end,
	save = function(self) end,
}
local WARNINGS = {}

local RESOLVE = setmetatable({
	isSelector = function(text) return text == "all" or text == "me" or text == "others" end,
}, { __call = function(_, text)
	local list = {}
	if text == nil or text == "me" then return { LOCAL } end
	if text == "all" then for _, p in PLAYERS_SERVICE:GetPlayers() do table.insert(list, p) end return list end
	local wanted = string.lower(text)
	for _, p in PLAYERS_SERVICE:GetPlayers() do
		if string.lower(p.Name):sub(1, #wanted) == wanted then table.insert(list, p) end
	end
	return list
end })

-- ===== tweens, as the component calls them =====
TWEEN_LOG = {}
local TWEEN_SCALE = { value = 1 }
TweenInfo = { new = function(duration, style, direction) return { duration = duration, style = style, direction = direction } end }
local TWEEN_SERVICE = { Create = function(self, object, info, props)
	local tween = { object = object, info = info, props = props, played = false, cancelled = false }
	function tween:Play() self.played = true end
	function tween:Cancel() self.cancelled = true end
	table.insert(TWEEN_LOG, tween)
	return tween
end }
RBX.TweenService = TWEEN_SERVICE
local tweenServiceMock = { getScale = function(self, value) return value * TWEEN_SCALE.value end }
local function latestTween(button)
	for i = #TWEEN_LOG, 1, -1 do
		if TWEEN_LOG[i].object == button then return TWEEN_LOG[i] end
	end
	return nil
end
-- where a button is going to rest: its last tween target, or its current place
local function restSize(button)
	local tween = latestTween(button)
	return if tween then tween.props.Size else button.Size
end
local function restPosition(button)
	local tween = latestTween(button)
	return if tween then tween.props.Position else button.Position
end

-- ===== UI services the component uses (same call shapes as the real ones) =====
local SCREEN = Instance.new("ScreenGui")
local DRAGGABLE, UI_NOTES = {}, {}
local themeService = {
	addObject = function(self, object, tag) object.themeTag = tag; for k, v in tag do object[k] = v end end,
	updateObjectProperties = function(self, object, props) for k, v in props do object[k] = v end end,
}
local createServiceMock = { new = function(className, ...)
	local object = Instance.new(className)
	for _, value in {...} do
		if type(value) == "string" then
			object.Name = value
		elseif type(value) == "table" and value.ClassName ~= nil then
			object.Parent = value
		elseif type(value) == "table" then
			for k, v in value do
				if type(k) == "number" and type(v) == "table" and v.ClassName ~= nil then
					v.Parent = object
				elseif k == "ThemeTag" then
					themeService:addObject(object, v)
				else
					object[k] = v
				end
			end
		end
	end
	return object
end }
local assetsServiceMock = { loadImage = function(self, object, name) object.Image = name end }
local dragInstanceMock = {
	addGuiObject = function(self, object) table.insert(DRAGGABLE, object) end,
	dragStarted = Signal.new(),
	dragEnded = Signal.new(),
}

-- the scroll bar component, reduced to what the window uses
local function newScrollBar(config)
	local bar = {
		index = 0,
		increment = config.increment,
		wheelIncrement = config.wheelIncrement,
		totalSpace = 0,
		visibleSpace = 0,
		scrolledSignal = Signal.new(),
		scrollEnabled = true,
	}
	function bar:create()
		self.container = Instance.new("Frame")
		self.container.Name = "Container"
		return Instance.new("Frame")
	end
	function bar:setTotalSpace(value) self.totalSpace = value end
	function bar:setVisibleSpace(value) self.visibleSpace = value end
	function bar:scrollTo(target)
		self.index = math.clamp(target, 0, math.max(0, self.totalSpace - self.visibleSpace))
		self.scrolledSignal:fire(self.index)
	end
	function bar:disableScroll() self.scrollEnabled = false end
	function bar:enableScroll() self.scrollEnabled = true end
	return bar
end
local scrollBarMock = { new = newScrollBar }
local scaleObjectMock = { getScale = function(self) return 1 end }
local uiNotifierMock = { notify = function(self, title, message) table.insert(UI_NOTES, { title, message }) end }
local connectionServiceMock = { Connect = function(self, signal, fn) return signal:Connect(fn) end }
local privateEnvMock = { screenGui = SCREEN }

-- ===== module loading: the real files, through a small require =====
local MODS = {
	rbxServices = RBX,
	executor = EXEC,
	storageConfig = { privateFolder = "infiniteYield" },
	storage = { settings = SETTINGS },
	logger = { warn = function(self, msg) table.insert(WARNINGS, msg) end },
	resolvePlayers = RESOLVE,
	connectionService = connectionServiceMock,
	privateEnv = privateEnvMock,
	createService = createServiceMock,
	assetsService = assetsServiceMock,
	themeService = themeService,
	dragInstance = dragInstanceMock,
	uiNotifier = uiNotifierMock,
	scaleObject = scaleObjectMock,
	tweenService = tweenServiceMock,
	scrollBarComponent = scrollBarMock,
}
local function require(path)
	local key
	if path:find("config/chatlogs") then key = "chatlogsConfig"
	elseif path:find("config/storage") then key = "storageConfig"
	elseif path:find("connectionService") then key = "connectionService"
	elseif path:find("environment/private") then key = "privateEnv"
	elseif path:find("createService") then key = "createService"
	elseif path:find("assetsService") then key = "assetsService"
	elseif path:find("themeService") then key = "themeService"
	elseif path:find("dragInstance") then key = "dragInstance"
	elseif path:find("tweenService") then key = "tweenService"
	elseif path:find("scaleObject") then key = "scaleObject"
	elseif path:find("scrollBar") then key = "scrollBarComponent"
	elseif path:find("notifier") then key = "uiNotifier"
	elseif path:find("rbxServices") then key = "rbxServices"
	elseif path:find("executor") then key = "executor"
	elseif path:find("storage") then key = "storage"
	elseif path:find("logger") then key = "logger"
	elseif path:find("chatSender") then key = "chatSender"
	elseif path:find("chatLogs") then key = "chatLogs"
	elseif path:find("resolvePlayers") then key = "resolvePlayers"
	end
	assert(key and MODS[key] ~= nil, "unmapped require " .. path)
	return MODS[key]
end

MODS.chatSender = (function()
-- Sends a chat message for both chat systems. Same logic as the IY chatMessage helper:
-- the legacy chat takes a SayMessageRequest event, TextChatService takes SendAsync on RBXGeneral.

local rbxServices = require("../../framework/services/rbxServices")

local chatSender = {}

function chatSender.isLegacy(): boolean
	return rbxServices.TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService
end

-- Returns true when the message was sent. Otherwise returns false and the reason.
function chatSender.send(message: string): (boolean, string?)
	message = tostring(message)

	local success, reason = pcall(function()
		if chatSender.isLegacy() then
			rbxServices.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
		else
			rbxServices.TextChatService.TextChannels.RBXGeneral:SendAsync(message)
		end
	end)

	return success, if success then nil else tostring(reason)
end

return chatSender

end)()
local function buildChatLogs()
	return (function()
-- Chat and join logs, the same as the IY logs. Each list keeps the last MAX_ENTRIES entries and tells
-- its listeners about every new one, so the chat logs window can show them as they arrive.
-- The webhook URL is kept in the settings. The hooks are connected once, and the toggles only decide
-- what gets recorded.

local rbxServices = require("../../framework/services/rbxServices")
local executorEnv = require("../../framework/environment/executor")
local storageConfig = require("../../framework/config/storage")
local storage = require("../../storage")
local logger = require("../../utils/logger")
local connectionService = require("../../framework/services/connectionService")
local chatSender = require("./chatSender")

local MAX_ENTRIES = 500
local FALLBACK_AVATAR = "https://files.catbox.moe/i968v2.jpg"
local WEBHOOK_KEY = "logsWebhook"

local chatLogs = {
	chatEnabled = false,
	joinEnabled = false,
	started = false,
	entries = { chat = {}, join = {} },
	listeners = {},
}

local avatarCache = {}

local function addEntry(kind: string, entry)
	entry.time = os.date("%H:%M:%S")

	local list = chatLogs.entries[kind]
	table.insert(list, entry)
	if #list > MAX_ENTRIES then
		table.remove(list, 1)
	end

	for _, listener in chatLogs.listeners do
		task.spawn(listener, kind, entry)
	end
end

function chatLogs.getWebhook(): string?
	local url = storage.settings:getValue(WEBHOOK_KEY)
	if type(url) == "string" and url ~= "" then
		return url
	end
	return nil
end

function chatLogs.setWebhook(url: string?)
	storage.settings:setValue(WEBHOOK_KEY, url)
	storage.settings:save()
end

-- The avatar of the player for the webhook. Cached, and a fallback image when Roblox has none.
local function getAvatar(player: Player): string
	local id = player.UserId
	if avatarCache[id] then
		return avatarCache[id]
	end

	local avatar = FALLBACK_AVATAR
	local request = executorEnv.httprequest

	if request then
		local success, data = pcall(function()
			local response = request({
				Url = `https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds={id}&size=420x420&format=Png&isCircular=false`,
				Method = "GET",
			})
			return rbxServices.HttpService:JSONDecode(response.Body).data
		end)

		local first = success and type(data) == "table" and data[1]
		if type(first) == "table" and first.state == "Completed" and first.imageUrl then
			avatar = first.imageUrl
		end
	end

	avatarCache[id] = avatar
	return avatar
end

local function sendWebhook(player: Player, message: string)
	local url = chatLogs.getWebhook()
	local request = executorEnv.httprequest
	if not (url and request) then
		return
	end

	-- in its own thread, the avatar request must not hold up the chat
	task.spawn(function()
		local body = rbxServices.HttpService:JSONEncode({
			content = message,
			avatar_url = getAvatar(player),
			username = player.Name,
			allowed_mentions = { parse = {} },
		})

		local success, reason = pcall(request, {
			Url = url,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = body,
		})

		if not success then
			logger:warn(`chat logs webhook failed: {reason}`)
		end
	end)
end

local function onChat(player: Player, message: string)
	if not chatLogs.chatEnabled then
		return
	end

	addEntry("chat", { name = player.Name, message = message })
	sendWebhook(player, message)
end

-- Connects the chat and join hooks once. Players who join later are hooked too.
function chatLogs.start()
	if chatLogs.started then
		return
	end
	chatLogs.started = true

	local players = rbxServices.Players

	local function hookPlayer(player: Player)
		if chatSender.isLegacy() then
			connectionService:Connect(player.Chatted, function(message)
				onChat(player, message)
			end)
		end
	end

	for _, player in players:GetPlayers() do
		hookPlayer(player)
	end

	connectionService:Connect(players.PlayerAdded, function(player)
		if chatLogs.joinEnabled then
			addEntry("join", { name = player.Name, userId = player.UserId })
		end
		hookPlayer(player)
	end)

	if not chatSender.isLegacy() then
		connectionService:Connect(rbxServices.TextChatService.MessageReceived, function(textChatMessage)
			local source = textChatMessage.TextSource
			if not source or textChatMessage.Status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
				return
			end

			local player = players:GetPlayerByUserId(source.UserId)
			if not player then
				return
			end

			local message = textChatMessage.Text
			if textChatMessage.WasRewritten then
				message = `(rephrased) {textChatMessage.RewrittenText}`
			end

			onChat(player, message)
		end)
	end
end

function chatLogs.setChat(enabled: boolean)
	chatLogs.chatEnabled = enabled
	if enabled then
		chatLogs.start()
	end
end

function chatLogs.setJoin(enabled: boolean)
	chatLogs.joinEnabled = enabled
	if enabled then
		chatLogs.start()
	end
end

-- Calls `callback(kind, entry)` for every new entry
function chatLogs.onEntry(callback)
	table.insert(chatLogs.listeners, callback)
end

function chatLogs.clear(kind: string)
	table.clear(chatLogs.entries[kind])
end

-- Writes one list to a text file in the IY folder. Returns true and the path, or false and the reason.
function chatLogs.save(kind: string): (boolean, string)
	local writefile = executorEnv.writefile
	if not writefile then
		return false, "your exploit does not support writing files"
	end

	local lines = {}
	for _, entry in chatLogs.entries[kind] do
		if kind == "chat" then
			table.insert(lines, `[{entry.time}] {entry.name}: {entry.message}`)
		else
			table.insert(lines, `[{entry.time}] {entry.name} ({entry.userId}) joined`)
		end
	end

	local folder = storageConfig.privateFolder
	if executorEnv.makefolder then
		pcall(executorEnv.makefolder, folder)
	end

	local path = `{folder}/{kind}logs-{os.time()}.txt`
	local success, reason = pcall(writefile, path, table.concat(lines, "\n"))
	if success then
		return true, path
	end
	return false, tostring(reason)
end

return chatLogs

	end)()
end
MODS.chatLogs = buildChatLogs()
MODS.chatlogsConfig = (function()
-- src/framework/config/chatlogs.luau

return {
	title = "Chat Logs",
	maxLabels = 200,

	window = {
		width = 340,
		height = 240,
		topBarHeight = 20,
		rowHeight = 22,
		closeIconSize = 10,
		buttonCorner = 6,
		buttonInset = 2,
		stripeTransparency = 0.96,
		shownX = 12,
		shownY = 100,
		hiddenX = -360,
		tweenTime = 0.5,
		tabTweenTime = 0.2,
	},

	scrollBar = {
		barThickness = 12,
		increment = 20,
		wheelIncrement = 40,
	},

	textSizes = {
		title = 16,
		control = 12,
		entry = 13,
	},

	tabs = {
		chat = "Chat",
		join = "Joins",
	},

	controls = {
		enabled = "Enabled",
		disabled = "Disabled",
		save = "Save",
		clear = "Clear",
	},

	messages = {
		saved = "Saved",
		saveFailed = "Save failed",
	},
}

end)()
MODS.chatlogs = (function()
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

local function formatEntry(kind: string, entry): string
	if kind == "chat" then
		return `[{entry.time}] {entry.name}: {entry.message}`
	end
	return `[{entry.time}] {entry.name} joined (id {entry.userId})`
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

	local info = TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
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

local function refresh(window, animate: boolean?)
	local enabled = isEnabled(window.tab)
	window.toggle.Text = if enabled then config.controls.enabled else config.controls.disabled
	paint(window.toggle, if enabled then "Colors.OnPrimary" else "Colors.Buttons.Default")

	for kind, button in window.tabButtons do
		local selected = kind == window.tab
		paint(button, if selected then "Colors.Primary" else "Colors.Buttons.Default")
		themeService:updateObjectProperties(button, { Font = if selected then "Font.Bold" else "Font.Normal" })
	end

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
		refresh(window)
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
		refresh(window)
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

end)()

local INTERFACE = {
	chatLogs = function(self, tab) return MODS.chatlogs:open(tab or "chat") end,
}

local CHAT = (function()
local chatSender = require("../../systems/chatSender")
local resolvePlayers = require("../../systems/resolvePlayers")

local SPAM = "spam"
local PM_PREFIX = "pmspam:"

-- Sends a message and tells the person why it failed, if it did
local function say(self, title: string, message: string): boolean
	local success, reason = chatSender.send(message)
	if not success then
		self:notify(title, reason)
	end
	return success
end

local function stopSpam(self)
	local garbage = self:collectGarbage(SPAM)
	if garbage then
		garbage.running = false
	end
end

-- Sends the message again and again, until 'unspam' or until a send fails
local function startSpam(self, message: string)
	stopSpam(self)

	local garbage = self:createGarbage(SPAM)
	garbage.running = true

	task.spawn(function()
		while garbage.running do
			if not say(self, "Spam", message) then
				garbage.running = false
				break
			end
			task.wait(self.privateEnv.spamSpeed or 1)
		end

		if self:getGarbage(SPAM) == garbage then
			self:collectGarbage(SPAM)
		end
	end)
end

local function pmName(player: Player): string
	return PM_PREFIX .. player.Name
end

local function stopPmSpam(self, name: string)
	local garbage = self:collectGarbage(name)
	if garbage then
		garbage.running = false
	end
end

-- Whispers the message again and again, until 'unpmspam' or until the player leaves
local function startPmSpam(self, player: Player, message: string)
	local name = pmName(player)
	stopPmSpam(self, name)

	local garbage = self:createGarbage(name)
	garbage.running = true

	task.spawn(function()
		while garbage.running and player.Parent == self.players do
			if not say(self, "PM Spam", `/w {player.Name} {message}`) then
				garbage.running = false
				break
			end
			task.wait(self.privateEnv.spamSpeed or 1)
		end

		if self:getGarbage(name) == garbage then
			self:collectGarbage(name)
		end
	end)
end

local function everyPmName(self): { string }
	local names = {}
	for name in pairs(self.garbages) do
		if name:sub(1, #PM_PREFIX) == PM_PREFIX then
			table.insert(names, name)
		end
	end
	return names
end

-- The pm spam names for a player argument: the players still in the game (by selector or name), plus the
-- stored ones of players who already left, matched by name. Selectors like 'all' only match players in the game.
local function pmTargets(self, text: string): { string }
	local names = {}
	for _, player in resolvePlayers(text) do
		table.insert(names, pmName(player))
	end

	if not resolvePlayers.isSelector(text) then
		local wanted = text:lower()
		for _, name in everyPmName(self) do
			local playerName = name:sub(#PM_PREFIX + 1):lower()
			if playerName:sub(1, #wanted) == wanted then
				table.insert(names, name)
			end
		end
	end

	return names
end

return {
	{
		action = "chat|say",
		description = "Makes you chat a string (possible mute bypass)",
		args = {
			kind = "string",
			name = "your message"
		},
		run = function(self, args)
			local message = args:nextValue()
			if not message then return end
			say(self, "Chat", message)
		end
	},
	{
		action = "spam",
		description = "Makes you spam the chat",
		args = {
			kind = "string",
			name = "your message"
		},
		run = function(self, args)
			local message = args:nextValue()
			if not message then return end
			startSpam(self, message)
		end
	},
	{
		action = "unspam|nospam",
		description = "Turns off spam",
		run = function(self)
			stopSpam(self)
		end
	},
	{
		action = "whisper|pm",
		description = "Makes you whisper a string to someone (possible mute bypass)",
		args = {
			{ kind = "player" },
			{ kind = "string", name = "your message" }
		},
		run = function(self, args)
			local targets = resolvePlayers(args:nextValue())
			local message = args:nextValue()
			if not message then return end

			for _, player in targets do
				if player ~= self.localPlayer then
					say(self, "Whisper", `/w {player.Name} {message}`)
				end
			end
		end
	},
	{
		action = "pmspam",
		description = "Makes you spam a players whispers",
		args = {
			{ kind = "player" },
			{ kind = "string", name = "your message" }
		},
		run = function(self, args)
			local targets = resolvePlayers(args:nextValue())
			local message = args:nextValue()
			if not message then return end

			for _, player in targets do
				if player ~= self.localPlayer then
					startPmSpam(self, player, message)
				end
			end
		end
	},
	{
		action = "unpmspam|nopmspam",
		description = "Turns off pm spam (no player: turns it off for everyone)",
		args = { kind = "player", optional = true },
		run = function(self, args)
			local text = args:nextValue()
			local names = if text then pmTargets(self, text) else everyPmName(self)

			for _, name in names do
				stopPmSpam(self, name)
			end
		end
	},
	{
		action = "spamspeed|spamdelay",
		description = "How quickly you spam (default is 1)",
		args = { kind = "number", name = "delay", optional = true },
		run = function(self, args)
			self.privateEnv.spamSpeed = math.max(args:nextValue() or 1, 0)
		end
	}
}

end)()
local BUBBLE = (function()
local rbxServices = require("../../../framework/services/rbxServices")
local chatSender = require("../../systems/chatSender")

-- The legacy chat has its own switch (Chat.BubbleChatEnabled), TextChatService has a configuration
local function setBubbleChat(enabled: boolean)
	if chatSender.isLegacy() then
		rbxServices.Chat.BubbleChatEnabled = enabled
	else
		rbxServices.TextChatService.BubbleChatConfiguration.Enabled = enabled
	end
end

return {
	{
		action = "bubblechat",
		description = "Enables bubble chat for your client (CLIENT)",
		client = true,
		run = function()
			setBubbleChat(true)
		end
	},
	{
		action = "unbubblechat|nobubblechat",
		description = "Disables bubble chat for your client (CLIENT)",
		client = true,
		run = function()
			setBubbleChat(false)
		end
	}
}

end)()
local WINDOWCMD = (function()
local rbxServices = require("../../../framework/services/rbxServices")
local chatSender = require("../../systems/chatSender")

local function setChatWindow(enabled: boolean)
	if chatSender.isLegacy() then
		rbxServices.StarterGui:SetCore("ChatActive", enabled)
	else
		rbxServices.TextChatService.ChatWindowConfiguration.Enabled = enabled
	end
end

-- The same colors as the IY darkchat, on the TextChatService configurations
local function darkenChat()
	local textChat = rbxServices.TextChatService

	local settings = {
		{ textChat:FindFirstChildOfClass("BubbleChatConfiguration"), {
			Enabled = true,
			BackgroundColor3 = Color3.fromRGB(),
			BackgroundTransparency = 0.3,
			TailVisible = true,
		} },
		{ textChat:FindFirstChildOfClass("ChatWindowConfiguration"), {
			Enabled = true,
			BackgroundColor3 = Color3.fromRGB(),
			BackgroundTransparency = 0.3,
			TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF),
			TextStrokeColor3 = Color3.fromRGB(),
			TextStrokeTransparency = 0.5,
		} },
		{ textChat:FindFirstChildOfClass("ChatInputBarConfiguration"), {
			Enabled = true,
			BackgroundColor3 = Color3.fromRGB(),
			BackgroundTransparency = 0.5,
			PlaceholderColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF),
			TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF),
			TextStrokeColor3 = Color3.fromRGB(),
			TextStrokeTransparency = 0.5,
		} },
	}

	for _, pair in settings do
		local configuration, properties = pair[1], pair[2]
		if configuration then
			for name, value in properties do
				configuration[name] = value
			end
		end
	end
end

return {
	{
		action = "chatwindow",
		description = "Enables the chat window for your client",
		client = true,
		run = function()
			setChatWindow(true)
		end
	},
	{
		action = "unchatwindow|nochatwindow",
		description = "Disables the chat window for your client",
		client = true,
		run = function()
			setChatWindow(false)
		end
	},
	{
		action = "darkchat",
		description = "Makes the chat window dark for your client",
		client = true,
		run = function(self)
			if chatSender.isLegacy() then
				self:notify("Dark Chat", "darkchat only works with the TextChatService chat")
				return
			end
			darkenChat()
		end
	}
}

end)()
local LOGSCMD = (function()
local chatLogs = require("../../systems/chatLogs")

return {
	{
		action = "logs",
		description = "Opens the chat logs window with chat and join logs turned on",
		run = function(self)
			chatLogs.setChat(true)
			chatLogs.setJoin(true)
			self.infiniteYield:chatLogs("chat")
		end
	},
	{
		action = "chatlogs|clogs",
		description = "Turns on chat logs and opens the chat tab",
		run = function(self)
			chatLogs.setChat(true)
			self.infiniteYield:chatLogs("chat")
		end
	},
	{
		action = "joinlogs|jlogs",
		description = "Turns on join logs and opens the joins tab",
		run = function(self)
			chatLogs.setJoin(true)
			self.infiniteYield:chatLogs("join")
		end
	},
	{
		action = "chatlogswebhook|logswebhook",
		description = "Set a discord webhook for chatlogs to go to (provide no url to disable this)",
		args = {
			kind = "string",
			name = "url",
			optional = true
		},
		run = function(self, args)
			local url = args:nextValue()

			if not url then
				chatLogs.setWebhook(nil)
				self:notify("Logs Webhook", "webhook disabled")
				return
			end

			if not self.executorEnv.httprequest then
				self:notify("Incompatible Exploit", "Your exploit does not support this command (missing request)")
				return
			end

			chatLogs.setWebhook(url)
			self:notify("Logs Webhook", "chat logs will be sent to the webhook")
		end
	}
}

end)()
local VOICE = (function()
local rbxServices = require("../../../framework/services/rbxServices")
local resolvePlayers = require("../../systems/resolvePlayers")

-- The hidden voice chat service the IY uses to mute players. Not every game has it.
local function getVoiceInternal()
	local success, service = pcall(function()
		return rbxServices.VoiceChatInternal
	end)
	if success then
		return service
	end
	return nil
end

-- Runs a call on the voice chat service. Tells the person when the game does not have it, or when it fails.
local function withVoice(self, callback: (any) -> ())
	local voice = getVoiceInternal()
	if not voice then
		self:notify("Voice Chat", "this game has no voice chat service")
		return
	end

	local success, reason = pcall(callback, voice)
	if not success then
		self:notify("Voice Chat", tostring(reason))
	end
end

-- Stops listento, and puts the listener back on the camera. Returns false when nothing was running.
local function stopListen(self): boolean
	local garbage = self:collectGarbage("listento")
	if not garbage then
		return false
	end

	if garbage.connection then
		garbage.connection:Disconnect()
	end
	rbxServices.SoundService:SetListener(Enum.ListenerType.Camera)
	return true
end

-- The listener follows the player's root part, and again after every respawn
local function listenTo(self, player: Player)
	local garbage = self:createGarbage("listento")

	local function follow(character: Model)
		local root = character:WaitForChild("HumanoidRootPart", 10)
		if root and self:getGarbage("listento") == garbage then
			rbxServices.SoundService:SetListener(Enum.ListenerType.ObjectPosition, root)
		end
	end

	garbage.connection = self:connect(player.CharacterAdded, function(character)
		task.spawn(follow, character)
	end)

	if player.Character then
		task.spawn(follow, player.Character)
	end
end

return {
	{
		action = "listento",
		description = "Listens to the area around a player. Can also eavesdrop with vc",
		args = { kind = "player", optional = true },
		run = function(self, args)
			local text = args:nextValue()

			stopListen(self)
			if not text then return end

			local target = resolvePlayers(text)[1]
			if target then
				listenTo(self, target)
			end
		end
	},
	{
		action = "unlistento",
		description = "Disables listento",
		run = function(self)
			stopListen(self)
		end
	},
	{
		action = "muteallvoices|muteallvcs",
		description = "Mutes voice chat for all players",
		run = function(self)
			withVoice(self, function(voice)
				voice:SubscribePauseAll(true)
			end)
		end
	},
	{
		action = "unmuteallvoices|unmuteallvcs",
		description = "Unmutes voice chat for all players",
		run = function(self)
			withVoice(self, function(voice)
				voice:SubscribePauseAll(false)
			end)
		end
	},
	{
		action = "mutevc",
		description = "Mutes the voice chat of a player",
		args = { kind = "player" },
		run = function(self, args)
			local targets = resolvePlayers(args:nextValue())
			withVoice(self, function(voice)
				for _, player in targets do
					if player ~= self.localPlayer then
						voice:SubscribePause(player.UserId, true)
					end
				end
			end)
		end
	},
	{
		action = "unmutevc",
		description = "Unmutes the voice chat of a player",
		args = { kind = "player" },
		run = function(self, args)
			local targets = resolvePlayers(args:nextValue())
			withVoice(self, function(voice)
				for _, player in targets do
					if player ~= self.localPlayer then
						voice:SubscribePause(player.UserId, false)
					end
				end
			end)
		end
	},
	{
		action = "phonebook|call",
		description = "Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled",
		run = function(self)
			local success, canCall = pcall(function()
				return rbxServices.SocialService:CanSendCallInviteAsync(self.localPlayer)
			end)

			if success and canCall then
				rbxServices.SocialService:PromptPhoneBook(self.localPlayer, "")
			else
				self:notify("Phonebook", "It seems you're not able to call anyone. Sorry!")
			end
		end
	}
}

end)()

local function cmd(list, action)
	for _, entry in list do
		if entry.action == action then return entry end
	end
	error("no command " .. action)
end
local function argsOf(...)
	local values, i = { ... }, 0
	return { nextValue = function() i += 1; return values[i] end }
end
local function newSelf()
	local s = { garbages = {}, privateEnv = {}, notes = {}, players = PLAYERS_SERVICE, localPlayer = LOCAL, executorEnv = EXEC, infiniteYield = INTERFACE }
	function s:notify(title, message) table.insert(self.notes, { title, message }) end
	function s:connect(signal, fn) return signal:Connect(fn) end
	function s:createGarbage(name) if self.garbages[name] == nil then self.garbages[name] = {}; return self.garbages[name] end end
	function s:collectGarbage(name) local g = self.garbages[name]; self.garbages[name] = nil; return g end
	function s:getGarbage(name) return self.garbages[name] end
	function s:hasGarbage(name) return self.garbages[name] ~= nil end
	return s
end
local function lastNote(self) return self.notes[#self.notes] end
local CHATLOGS = MODS.chatLogs
local function say(player, text)
	TEXT_CHAT.MessageReceived:fire({ TextSource = { UserId = player.UserId }, Status = Enum.TextChatMessageStatus.Success, Text = text, WasRewritten = false })
end

-- ===== 1. chatSender: each route is checked, not just the message =====
do
	TEXT_CHAT.ChatVersion = TEXT
	local n = #SENT
	local a0, f0 = ASYNC_CALLS, FIRE_CALLS
	local ok = MODS.chatSender.send("hi there")
	check("chatSender new chat: SendAsync on RBXGeneral, not the legacy event", ok == true and SENT[#SENT] == "hi there" and #SENT == n + 1 and ASYNC_CALLS == a0 + 1 and FIRE_CALLS == f0)

	SEND_FAIL = true
	local ok2, reason = MODS.chatSender.send("blocked")
	SEND_FAIL = false
	check("chatSender reports a failed send with the reason", ok2 == false and type(reason) == "string" and string.find(reason, "muted") ~= nil)

	TEXT_CHAT.ChatVersion = LEGACY
	local a1, f1 = ASYNC_CALLS, FIRE_CALLS
	local ok3 = MODS.chatSender.send("legacy one")
	check("chatSender legacy chat: SayMessageRequest to All, not SendAsync", ok3 == true and SENT[#SENT] == "legacy one" and LEG_TARGET == "All" and FIRE_CALLS == f1 + 1 and ASYNC_CALLS == a1)
	TEXT_CHAT.ChatVersion = TEXT
end

-- ===== 2. chat commands =====
do
	local self = newSelf()
	local n = #SENT
	cmd(CHAT, "chat|say").run(self, argsOf("hello"))
	check("chat sends the message", SENT[#SENT] == "hello" and #SENT == n + 1)

	SEND_FAIL = true
	cmd(CHAT, "chat|say").run(self, argsOf("nope"))
	SEND_FAIL = false
	check("chat tells the person when a send fails", lastNote(self)[1] == "Chat")

	n = #SENT
	cmd(CHAT, "whisper|pm").run(self, argsOf("bob", "hi there"))
	check("whisper sends /w to the target", SENT[#SENT] == "/w Bob hi there" and #SENT == n + 1)

	n = #SENT
	cmd(CHAT, "whisper|pm").run(self, argsOf("me", "to myself"))
	check("whisper skips yourself", #SENT == n)

	n = #SENT
	cmd(CHAT, "spam").run(self, argsOf("ping"))
	advance(2)
	check("spam repeats every second (3 sends in 2 seconds)", #SENT - n == 3)
	cmd(CHAT, "unspam|nospam").run(self)
	advance(5)
	check("unspam stops spam", #SENT - n == 3)

	cmd(CHAT, "spamspeed|spamdelay").run(self, argsOf(0.5))
	check("spamspeed sets the delay", self.privateEnv.spamSpeed == 0.5)
	cmd(CHAT, "spamspeed|spamdelay").run(self, argsOf(nil))
	check("spamspeed without a number goes back to 1", self.privateEnv.spamSpeed == 1)
	cmd(CHAT, "spamspeed|spamdelay").run(self, argsOf(-3))
	check("spamspeed never goes below 0", self.privateEnv.spamSpeed == 0)
	self.privateEnv.spamSpeed = 1

	n = #SENT
	cmd(CHAT, "pmspam").run(self, argsOf("bob", "yo"))
	check("pmspam sends right away", SENT[#SENT] == "/w Bob yo" and #SENT == n + 1)
	advance(2)
	check("pmspam keeps going while the player is in the game", #SENT - n == 3)
	BOB.Parent = nil
	advance(3)
	check("pmspam stops when the player leaves", #SENT - n == 3 and self.garbages["pmspam:Bob"] == nil)
	BOB.Parent = PLAYERS_SERVICE

	n = #SENT
	cmd(CHAT, "pmspam").run(self, argsOf("carl", "hey"))
	CARL.Parent = nil
	cmd(CHAT, "unpmspam|nopmspam").run(self, argsOf("carl"))
	advance(3)
	check("unpmspam finds a player who already left", #SENT - n == 1 and self.garbages["pmspam:Carl"] == nil)
	CARL.Parent = PLAYERS_SERVICE

	cmd(CHAT, "pmspam").run(self, argsOf("ann", "x"))
	cmd(CHAT, "unpmspam|nopmspam").run(self, argsOf())
	check("unpmspam without a player stops every pm spam", self.garbages["pmspam:Ann"] == nil)
end

-- ===== 3. chat and join logs (new chat) =====
do
	CHATLOGS.setChat(true)
	local last = nil
	say(BOB, "hello logs")
	last = CHATLOGS.entries.chat[#CHATLOGS.entries.chat]
	check("chat logs record a message", last ~= nil and last.name == "Bob" and last.message == "hello logs")

	CHATLOGS.setChat(false)
	local count = #CHATLOGS.entries.chat
	say(BOB, "not recorded")
	check("chat logs stop when turned off", #CHATLOGS.entries.chat == count)

	CHATLOGS.setJoin(false)
	local joins = #CHATLOGS.entries.join
	PLAYERS_SERVICE.PlayerAdded:fire(newPlayer("Dan", 5))
	check("join logs do nothing when off", #CHATLOGS.entries.join == joins)
	CHATLOGS.setJoin(true)
	PLAYERS_SERVICE.PlayerAdded:fire(newPlayer("Eve", 6))
	local j = CHATLOGS.entries.join[#CHATLOGS.entries.join]
	check("join logs record a join", j ~= nil and j.name == "Eve" and j.userId == 6)

	CHATLOGS.setWebhook("https://discord.test/hook")
	check("webhook is kept in the settings", CHATLOGS.getWebhook() == "https://discord.test/hook")
	CHATLOGS.setChat(true)
	local before = #HTTP_LOG
	say(BOB, "to the webhook")
	advance(0)
	local sent
	for i = before + 1, #HTTP_LOG do
		if HTTP_LOG[i].Method == "POST" then sent = HTTP_LOG[i] end
	end
	check("webhook gets the message, the name and the avatar", sent ~= nil and sent.Url == "https://discord.test/hook" and sent.Body.content == "to the webhook" and sent.Body.username == "Bob" and sent.Body.avatar_url == "https://cdn.test/avatar.png")

	CHATLOGS.setWebhook(nil)
	before = #HTTP_LOG
	say(BOB, "no webhook now")
	advance(0)
	check("no webhook means no request", #HTTP_LOG == before)
end

-- ===== 4. legacy chat hooks (separate module instance) =====
do
	local legacyLogs = buildChatLogs()
	TEXT_CHAT.ChatVersion = LEGACY
	legacyLogs.setChat(true)
	BOB.Chatted:fire("legacy hi")
	local last = legacyLogs.entries.chat[#legacyLogs.entries.chat]
	check("legacy chat logs use player.Chatted", last ~= nil and last.message == "legacy hi" and last.name == "Bob")
	TEXT_CHAT.ChatVersion = TEXT
end

-- ===== 5. logs command -> infiniteYield:chatLogs(tab) -> the chat logs window =====
do
	local self = newSelf()
	local C = MODS.chatlogs
	cmd(LOGSCMD, "logs").run(self)
	local window = C.window
	check("logs opens the window through infiniteYield:chatLogs", window ~= nil and window.tab == "chat")
	check("the window sits in the IY screen", window.frame.Parent == SCREEN)
	check("the window slides to its shown position", window.frame.Position[2] == 12 and window.frame.Position[4] == 100)
	check("the window can be dragged", table.find(DRAGGABLE, window.frame) ~= nil)
	check("logs turns on chat and join logs", CHATLOGS.chatEnabled and CHATLOGS.joinEnabled)
	check("the Enabled toggle is shown in the on color", window.toggle.Text == "Enabled" and window.toggle.BackgroundColor3 == "Colors.OnPrimary")
	check("all buttons share one row", findByName("Clear").Parent == findByName("Save").Parent and findByName("Save").Parent == window.toggle.Parent and window.toggle.Parent == findByName("ChatTab").Parent and findByName("ChatTab").Parent == findByName("JoinTab").Parent)
	check("left half: Clear and Save share the first quarter, Enabled the second", findByName("Clear").Position[1] == 0 and findByName("Clear").Size[1] == 0.125 and findByName("Save").Position[1] == 0.125 and findByName("Save").Size[1] == 0.125 and window.toggle.Position[1] == 0.25 and window.toggle.Size[1] == 0.25)
	check("right half: the selected Chat tab takes 3/4 of it, bold and primary", window.tabButtons.chat.Position[1] == 0.5 and window.tabButtons.chat.Size[1] == 0.375 and window.tabButtons.join.Size[1] == 0.125 and window.tabButtons.chat.Font == "Font.Bold" and window.tabButtons.chat.BackgroundColor3 == "Colors.Primary" and window.tabButtons.join.Font == "Font.Normal")

	say(BOB, "window line")
	check("a new chat entry appears in the open window", #labelsContaining("window line") == 1)

	window.toggle.Activated:fire()
	check("the toggle turns chat logs off and shows it", CHATLOGS.chatEnabled == false and window.toggle.Text == "Disabled" and window.toggle.BackgroundColor3 == "Colors.Buttons.Default")
	window.toggle.Activated:fire()
	check("the toggle turns them back on", CHATLOGS.chatEnabled == true)

	findByName("Save").Activated:fire()
	local written
	for path, content in FILES do written = { path = path, content = content } end
	check("save writes the chat list to a file", written ~= nil and string.find(written.path, "infiniteYield/chatlogs-", 1, true) == 1 and string.find(written.content, "window line", 1, true) ~= nil)
	check("save reports where the file went", UI_NOTES[#UI_NOTES][1] == "Saved")

	findByName("JoinTab").Activated:fire()
	check("the joins tab shows join entries only", #labelsContaining("Eve joined") >= 1 and #labelsContaining("window line") == 0)
	check("the joins tab is the selected one", window.tab == "join" and window.tabButtons.join.BackgroundColor3 == "Colors.Primary")
	check("when Joins is selected it takes 3/4 of the right half, and Chat 1/4", restPosition(window.tabButtons.join)[1] == 0.625 and restSize(window.tabButtons.join)[1] == 0.375 and restSize(window.tabButtons.chat)[1] == 0.125 and window.tabButtons.join.Font == "Font.Bold" and window.tabButtons.chat.Font == "Font.Normal")

	findByName("Clear").Activated:fire()
	check("clear empties the current list", #CHATLOGS.entries.join == 0 and #labelsContaining("Eve joined") == 0)

	local writer = EXEC.writefile
	EXEC.writefile = nil
	findByName("Save").Activated:fire()
	EXEC.writefile = writer
	check("save without writefile says why", UI_NOTES[#UI_NOTES][1] == "Save failed")

	cmd(LOGSCMD, "chatlogs|clogs").run(self)
	check("chatlogs while open reuses the window and selects chat", C.window == window and window.tab == "chat")

	findByName("Close").Activated:fire()
	check("Exit closes the window", C.window == nil)
	advance(0.5)
	check("the closed window is destroyed after the tween", window.frame.destroyed == true)
	say(BOB, "after close")
	check("a closed window gets no new labels", #labelsContaining("after close") == 0)
	check("the entries are kept after closing", CHATLOGS.entries.chat[#CHATLOGS.entries.chat].message == "after close")

	cmd(LOGSCMD, "chatlogs|clogs").run(self)
	check("opening again builds a new window", C.window ~= nil and C.window ~= window)
	local second = C.window
	C:reset()
	check("reset forgets the window", C.window == nil)
	check("reset does not tween or destroy it", second.frame.destroyed == false)
	INTERFACE:chatLogs("join")
	check("interface:chatLogs with a tab opens that tab", C.window ~= nil and C.window.tab == "join")
	C:close()
end

-- ===== 6. chatlogswebhook =====
do
	local self = newSelf()
	cmd(LOGSCMD, "chatlogswebhook|logswebhook").run(self, argsOf("https://discord.test/new"))
	check("chatlogswebhook sets the url", CHATLOGS.getWebhook() == "https://discord.test/new")
	cmd(LOGSCMD, "chatlogswebhook|logswebhook").run(self, argsOf(nil))
	check("chatlogswebhook with no url disables it", CHATLOGS.getWebhook() == nil)
	local request = EXEC.httprequest
	EXEC.httprequest = nil
	cmd(LOGSCMD, "chatlogswebhook|logswebhook").run(self, argsOf("https://discord.test/x"))
	EXEC.httprequest = request
	check("chatlogswebhook says when the exploit has no request", lastNote(self)[1] == "Incompatible Exploit" and CHATLOGS.getWebhook() == nil)
end

-- ===== 7. bubblechat, chatwindow, darkchat =====
do
	local self = newSelf()
	cmd(BUBBLE, "bubblechat").run()
	check("bubblechat turns on TextChatService bubbles", CONFIG.BubbleChatConfiguration.Enabled == true)
	cmd(BUBBLE, "unbubblechat|nobubblechat").run()
	check("unbubblechat turns them off", CONFIG.BubbleChatConfiguration.Enabled == false)

	cmd(WINDOWCMD, "chatwindow").run()
	check("chatwindow turns on the window", CONFIG.ChatWindowConfiguration.Enabled == true)
	cmd(WINDOWCMD, "unchatwindow|nochatwindow").run()
	check("unchatwindow turns it off", CONFIG.ChatWindowConfiguration.Enabled == false)

	cmd(WINDOWCMD, "darkchat").run(self)
	check("darkchat darkens the bubble and input colors", CONFIG.BubbleChatConfiguration.BackgroundTransparency == 0.3 and CONFIG.ChatInputBarConfiguration.BackgroundTransparency == 0.5 and CONFIG.ChatWindowConfiguration.TextStrokeTransparency == 0.5)

	TEXT_CHAT.ChatVersion = LEGACY
	cmd(BUBBLE, "bubblechat").run()
	check("legacy bubblechat uses Chat.BubbleChatEnabled", CHAT_SERVICE.BubbleChatEnabled == true)
	cmd(WINDOWCMD, "chatwindow").run()
	check("legacy chatwindow uses SetCore ChatActive", CORE.ChatActive == true)
	cmd(WINDOWCMD, "darkchat").run(self)
	check("legacy darkchat says it only works with the new chat", lastNote(self)[1] == "Dark Chat")
	TEXT_CHAT.ChatVersion = TEXT
end

-- ===== 8. voice chat =====
do
	local self = newSelf()
	cmd(VOICE, "muteallvoices|muteallvcs").run(self)
	check("muteallvoices pauses everyone", VC.PAUSE_ALL == true)
	cmd(VOICE, "unmuteallvoices|unmuteallvcs").run(self)
	check("unmuteallvoices resumes everyone", VC.PAUSE_ALL == false)

	cmd(VOICE, "mutevc").run(self, argsOf("bob"))
	check("mutevc pauses one player", VC.PAUSE[BOB.UserId] == true)
	cmd(VOICE, "mutevc").run(self, argsOf("me"))
	check("mutevc skips yourself", VC.PAUSE[LOCAL.UserId] == nil)
	cmd(VOICE, "unmutevc").run(self, argsOf("bob"))
	check("unmutevc resumes one player", VC.PAUSE[BOB.UserId] == false)

	local saved = RBX.VoiceChatInternal
	RBX.VoiceChatInternal = nil
	cmd(VOICE, "muteallvoices|muteallvcs").run(self)
	RBX.VoiceChatInternal = saved
	check("muteallvoices says the game has no voice service", lastNote(self)[1] == "Voice Chat")

	local root1 = { name = "root1" }
	BOB.Character = { WaitForChild = function() return root1 end }
	cmd(VOICE, "listento").run(self, argsOf("bob"))
	check("listento listens from the player's root", LISTENER[1] == Enum.ListenerType.ObjectPosition and LISTENER[2] == root1)
	local root2 = { name = "root2" }
	BOB.CharacterAdded:fire({ WaitForChild = function() return root2 end })
	advance(0)
	check("listento follows the player after a respawn", LISTENER[2] == root2)
	cmd(VOICE, "unlistento").run(self)
	check("unlistento puts the listener back on the camera", LISTENER[1] == Enum.ListenerType.Camera)
	BOB.CharacterAdded:fire({ WaitForChild = function() return { name = "root3" } end })
	advance(0)
	check("after unlistento a respawn does not move the listener", LISTENER[1] == Enum.ListenerType.Camera)

	CAN_CALL = true
	cmd(VOICE, "phonebook|call").run(self)
	check("phonebook opens for a player who can call", PROMPTED == LOCAL)
	CAN_CALL = false
	cmd(VOICE, "phonebook|call").run(self)
	check("phonebook says when you cannot call", lastNote(self)[1] == "Phonebook")
	CAN_CALL = true
end

-- ===== 9. tab animation =====
do
	local self = newSelf()
	local C = MODS.chatlogs
	local before = #TWEEN_LOG
	cmd(LOGSCMD, "logs").run(self)
	local window = C.window
	check("opening the window does not animate the tabs", #TWEEN_LOG == before)

	before = #TWEEN_LOG
	findByName("JoinTab").Activated:fire()
	check("switching to Joins animates both tabs", #TWEEN_LOG == before + 2 and TWEEN_LOG[#TWEEN_LOG - 1].played and TWEEN_LOG[#TWEEN_LOG].played)
	local joinTween, chatTween = latestTween(window.tabButtons.join), latestTween(window.tabButtons.chat)
	check("the tabs slide to the new sizes", joinTween.props.Size[1] == 0.375 and joinTween.props.Position[1] == 0.625 and chatTween.props.Size[1] == 0.125)
	check("the tween uses the tab tween time, quart out", joinTween.info.duration == 0.2 and joinTween.info.style == Enum.EasingStyle.Quart and joinTween.info.direction == Enum.EasingDirection.Out)

	findByName("ChatTab").Activated:fire()
	check("switching again cancels the tweens still running", joinTween.cancelled and chatTween.cancelled)
	local back = latestTween(window.tabButtons.chat)
	check("and starts new ones back to the Chat sizes", back ~= chatTween and back.props.Size[1] == 0.375 and restSize(window.tabButtons.join)[1] == 0.125)

	TWEEN_SCALE.value = 0
	local count = #TWEEN_LOG
	findByName("JoinTab").Activated:fire()
	check("with tweens disabled the tabs move at once", #TWEEN_LOG == count and window.tabButtons.join.Size[1] == 0.375 and window.tabButtons.join.Position[1] == 0.625)
	TWEEN_SCALE.value = 1

	findByName("ChatTab").Activated:fire()
	local pending = latestTween(window.tabButtons.join)
	C:close()
	check("closing the window cancels the tweens of its tabs", pending.cancelled == true)
	advance(0.5)
end

print(string.format("\n%d passed, %d failed", passed, failed))
