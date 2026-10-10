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
