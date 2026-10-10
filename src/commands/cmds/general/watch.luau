-- rolewatch, staffwatch and findfriendgroups.
-- rolewatch and staffwatch look at the players already here and at everyone who joins after.

local robloxServices = require("../../../framework/services/rbxServices")
local Players = robloxServices.Players

local TITLE_ROLE = "Rolewatch"
local TITLE_STAFF = "Staffwatch"
local STAFF_WORDS = { "admin", "mod", "staff", "owner", "dev", "support", "manager" }

-- The role name of a player in a group, or nil when the request fails
local function roleOf(player: Player, groupId: number): string?
	local ok, role = pcall(function()
		return player:GetRoleInGroup(groupId)
	end)
	return if ok then role else nil
end

local function stopWatch(self, name: string): boolean
	local garbage = self:collectGarbage(name)
	if not garbage then return false end

	if garbage.connection then
		garbage.connection:Disconnect()
	end
	return true
end

-- rolewatch -----------------------------------------------------------------

local function checkRolePlayer(self, garbage, player: Player)
	if player == self.localPlayer then return end

	local role = roleOf(player, garbage.groupId)
	if not role or role:lower() ~= garbage.roleName then return end

	self:notify(TITLE_ROLE, `{player.Name} has the role '{role}'`)

	if self.privateEnv.rolewatchLeave then
		self.localPlayer:Kick("rolewatch: a watched player joined")
	end
end

-- staffwatch ----------------------------------------------------------------

local function isStaff(player: Player): boolean
	if game.CreatorType ~= Enum.CreatorType.Group then
		return player.UserId == game.CreatorId
	end

	local role = roleOf(player, game.CreatorId)
	if not role or role == "Guest" then return false end

	local lowered = role:lower()
	for _, word in STAFF_WORDS do
		if lowered:find(word, 1, true) then
			return true
		end
	end
	return false
end

return {
	{
		action = "rolewatch",
		description = "Notify if someone from a watched group joins the server",
		args = {
			{
				kind = "number",
				name = "group id"
			},
			{
				kind = "string",
				name = "role name"
			}
		},
		run = function(self, args)
			local groupId = args:nextValue()
			local roleName = args:nextValue()

			stopWatch(self, "rolewatch")

			local garbage = self:createGarbage("rolewatch")
			garbage.groupId = groupId
			garbage.roleName = roleName:lower()

			for _, player in Players:GetPlayers() do
				checkRolePlayer(self, garbage, player)
			end

			garbage.connection = self:connect(Players.PlayerAdded, function(player)
				checkRolePlayer(self, garbage, player)
			end)

			self:notify(TITLE_ROLE, `watching for the role '{roleName}' in group {groupId}`)
		end
	},
	{
		action = "rolewatchstop|unrolewatch",
		description = "Disable Rolewatch",
		run = function(self)
			if stopWatch(self, "rolewatch") then
				self:notify(TITLE_ROLE, "disabled")
			end
		end
	},
	{
		action = "rolewatchleave",
		description = "Toggle if you should leave the game if someone from a watched group joins the server",
		run = function(self)
			local leave = not self.privateEnv.rolewatchLeave
			self.privateEnv.rolewatchLeave = leave
			self:notify(TITLE_ROLE, if leave then "you will leave when a watched player joins" else "you will stay when a watched player joins")
		end
	},
	{
		action = "staffwatch",
		description = "Notify if a staff member of the game joins the server",
		run = function(self)
			stopWatch(self, "staffwatch")

			local garbage = self:createGarbage("staffwatch")

			local function check(player: Player)
				if player ~= self.localPlayer and isStaff(player) then
					self:notify(TITLE_STAFF, `staff member {player.Name} is in the server`)
				end
			end

			for _, player in Players:GetPlayers() do
				check(player)
			end

			garbage.connection = self:connect(Players.PlayerAdded, check)
			self:notify(TITLE_STAFF, "watching for staff")
		end
	},
	{
		action = "unstaffwatch",
		description = "Disable Staffwatch",
		run = function(self)
			if stopWatch(self, "staffwatch") then
				self:notify(TITLE_STAFF, "disabled")
			end
		end
	},
	{
		action = "findfriendgroups",
		description = "Notifies you if any players are friends with each other",
		run = function(self)
			local list = Players:GetPlayers()
			local pairsFound = {}

			for i = 1, #list do
				for j = i + 1, #list do
					local first, second = list[i], list[j]

					local ok, friends = pcall(function()
						return first:IsFriendsWith(second.UserId)
					end)

					if ok and friends then
						table.insert(pairsFound, `{first.Name} & {second.Name}`)
					end
				end
			end

			if #pairsFound == 0 then
				self:notify("Friend groups", "no friends were found between the players in this server")
			else
				self:notify("Friend groups", table.concat(pairsFound, ", "))
			end
		end
	}
}
