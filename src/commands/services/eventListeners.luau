-- src/commands/services/eventListeners.luau
-- Sends the game's events to the event binds (commands/systems/eventBinds): a player joins or leaves, a character
-- spawns, takes damage or dies, a player is killed, and a chat message is sent. Starts once, when IY loads.
--
-- The connections of a player are dropped when the player leaves, and the connections of a character's humanoid are
-- replaced when the character changes, so they do not pile up.

local robloxServices = require("../../framework/services/rbxServices")
local connectionService = require("../../framework/services/connectionService")
local eventBinds = require("../systems/eventBinds")

local Players = robloxServices.Players
local TextChatService = robloxServices.TextChatService

local eventListeners = {}

local started = false
local legacyChat = false

-- player -> connections that last while the player is in the game
local playerConnections = {}
-- player -> connections of the humanoid of the current character
local characterConnections = {}

-- Adds a connection to the bucket of a player, so disconnectFor can drop it
local function connectFor(bucket, player: Player, signal, callback)
	local connection = connectionService:Connect(signal, callback)

	local list = bucket[player] or {}
	bucket[player] = list
	table.insert(list, connection)
end

local function disconnectFor(bucket, player: Player)
	local list = bucket[player]
	bucket[player] = nil

	for _, connection in list or {} do
		connectionService:disconnect(connection)
	end
end

-- Follows the health and the death of a character. The humanoid can come a moment after the character.
local function watchCharacter(player: Player, character: Model)
	disconnectFor(characterConnections, player)

	task.spawn(function()
		local humanoid = character:WaitForChild("Humanoid", 10)

		-- the character can change while the humanoid is loading
		if not humanoid or not humanoid:IsA("Humanoid") or player.Character ~= character then
			return
		end

		local lastHealth = humanoid.Health

		connectFor(characterConnections, player, humanoid.HealthChanged, function(health: number)
			if health < lastHealth then
				eventBinds.fire("OnDamage", player.Name, health)
			end

			lastHealth = health
		end)

		connectFor(characterConnections, player, humanoid.Died, function()
			eventBinds.fire("OnDied", player.Name)

			-- the creator tag says who dealt the last blow
			local creator = humanoid:FindFirstChild("creator")
			local killer = if creator and creator:IsA("ObjectValue") then creator.Value else nil

			if killer and killer:IsA("Player") then
				eventBinds.fire("OnKilled", player.Name, killer.Name)
			end
		end)
	end)
end

-- Follows a player: the spawn of the character, the chat when the game uses the legacy chat, and the character
-- the player already has
local function followPlayer(player: Player)
	connectFor(playerConnections, player, player.CharacterAdded, function(character: Model)
		eventBinds.fire("OnSpawn", player.Name)
		watchCharacter(player, character)
	end)

	if legacyChat then
		connectFor(playerConnections, player, player.Chatted, function(message: string)
			eventBinds.fire("OnChatted", player.Name, message)
		end)
	end

	if player.Character then
		watchCharacter(player, player.Character)
	end
end

local function onMessageReceived(message)
	local source = message.TextSource

	if not source or message.Status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
		return
	end

	local player = Players:GetPlayerByUserId(source.UserId)

	if player then
		eventBinds.fire("OnChatted", player.Name, message.Text)
	end
end

local function onPlayerRemoving(player: Player)
	eventBinds.fire("OnLeave", player.Name)

	disconnectFor(playerConnections, player)
	disconnectFor(characterConnections, player)
end

-- Connects the game's events, then runs the OnExecute binds. Only the first call does anything.
function eventListeners.start()
	if started then
		return
	end

	started = true
	legacyChat = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService

	connectionService:Connect(Players.PlayerAdded, function(player: Player)
		eventBinds.fire("OnJoin", player.Name)
		followPlayer(player)
	end)

	connectionService:Connect(Players.PlayerRemoving, onPlayerRemoving)

	if not legacyChat then
		connectionService:Connect(TextChatService.MessageReceived, onMessageReceived)
	end

	-- the players already here are followed too, but they did not join now, so OnJoin does not run for them
	for _, player in Players:GetPlayers() do
		followPlayer(player)
	end

	eventBinds.fire("OnExecute")
end

return eventListeners
