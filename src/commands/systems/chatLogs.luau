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
local nameColor = require("../../utils/nameColor")

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

	addEntry("chat", {
		name = player.Name,
		message = message,
		color = nameColor.forPlayer(player, chatSender.isLegacy()),
	})
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
			addEntry("join", {
				name = player.Name,
				userId = player.UserId,
				color = nameColor.forPlayer(player, chatSender.isLegacy()),
			})
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
