-- Player info commands. The join date is asked from the Roblox users API.
-- Without an http request function, the date is estimated from the account age.

local resolvePlayers = require("../systems/resolvePlayers")
local chatSender = require("../systems/chatSender")

local DAY = 86400
local USERS_API = "https://users.roblox.com/v1/users/"

-- "2011-07-04" for the player's join date, with "~" when it is only an estimate
local function joinDate(self, player: Player): string
	local request = self.executorEnv.httprequest

	if request then
		local ok, created = pcall(function()
			local response = request({ Url = USERS_API .. tostring(player.UserId), Method = "GET" })
			return self.robloxServices.HttpService:JSONDecode(response.Body).created
		end)

		if ok and type(created) == "string" then
			return created:sub(1, 10)
		end
	end

	return "~" .. os.date("!%Y-%m-%d", os.time() - player.AccountAge * DAY)
end

-- Sends a chat message, or notifies the reason it could not be sent
local function chat(self, message: string)
	local sent, reason = chatSender.send(message)
	if not sent then
		self:notify("Chat", `could not send the message: {reason}`)
	end
end

return {
	{
		action = "inspect|examine",
		description = "Opens InspectMenu for a certain player",
		args = { kind = "player" },
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			if not target then return end

			self.guiService:InspectPlayerFromUserId(target.UserId)
		end
	},
	{
		action = "age|playerage",
		description = "Tells you the age of a player",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self:notify("Account age", `{player.Name}'s account is {player.AccountAge} day(s) old`)
			end
		end
	},
	{
		action = "chatage",
		description = "Chats the age of a player",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				chat(self, `{player.Name}'s account is {player.AccountAge} day(s) old`)
			end
		end
	},
	{
		action = "joindate|jd",
		description = "Tells you the date the player joined Roblox",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self:notify("Join date", `{player.Name} joined Roblox on {joinDate(self, player)}`)
			end
		end
	},
	{
		action = "chatjoindate|cjd",
		description = "Chats the date the player joined Roblox",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				chat(self, `{player.Name} joined Roblox on {joinDate(self, player)}`)
			end
		end
	},
	{
		action = "copyname|copyuser",
		description = "Copies a players full username to your clipboard",
		args = { kind = "player" },
		run = function(self, args)
			local setclipboard = self:expectExploit("setclipboard")
			if not setclipboard then return end

			local target = resolvePlayers(args:nextValue())[1]
			if not target then return end

			setclipboard(target.Name)
			self:notify("Copy name", `copied {target.Name}`)
		end
	},
	{
		action = "userid|id",
		description = "Notifies a players user ID",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self:notify("User ID", `{player.Name}: {player.UserId}`)
			end
		end
	}
}
