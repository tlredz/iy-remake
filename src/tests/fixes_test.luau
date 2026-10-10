
local passed, failed = 0, 0
local function check(name, cond)
	if cond then passed += 1; print("PASS  " .. name)
	else failed += 1; print("FAIL  " .. name) end
end
do

local logger = {
	expect = function() end,
	assert = function(value, message) if not value then error(message, 2) end end,
	warn = function() end,
}
local usage = {}
local commandsController = { privateEnv = {}, garbages = {} }
function commandsController:commandUsed(name) usage[name] = (usage[name] or 0) + 1 end
local commandsList = { lookup = {} }
local function addCmd(name, run) commandsList.lookup[name] = { name = name, run = run } end
addCmd("noclip", function(self) end)
addCmd("fling", function(self) self:run("noclip") end)
addCmd("lastcommand", function(self)
	local last = self.privateEnv.lastCommand
	self:run(last.name, nil, true)
end)
addCmd("boom", function() error("bad command") end)
addCmd("yielder", function(self) coroutine.yield("paused") end)
local runningThreads = {}
local function snapshotArgs(args)
	local values = {}
	if args and args.args then
		for index, arg in args.args do
			values[index] = { value = arg.value }
		end
	end
	return values
end

-- Threads that are running a command right now. A command that starts another one with self:run
-- is nested: the inner run must not change lastCommand, the saved arguments or the usage rank.
local runningThreads = setmetatable({}, { __mode = "k" })

-- Runs a command by name. `asUser` is set by 'lastcommand', which replays a command the person chose.
function commandsController:run(cmdName: string, args: unknown, asUser: boolean?): (nil)
	logger:expect(cmdName, {"string"}, "'commandsController:run' #1")
	logger:expect(args, {"table", "nil"}, "'commandsController:run' #2")

	local cmdData = commandsList.lookup[cmdName]
	logger:assert(cmdData, "invalid command")

	local thread = coroutine.running()
	local wasNested = runningThreads[thread] ~= nil
	local nested = wasNested and not asUser

	if not nested then
		self:commandUsed(cmdData.name)

		-- the arguments are kept per command, so '!command' can run it again with the same ones
		local snapshot = snapshotArgs(args)
		self.privateEnv.lastArgs = self.privateEnv.lastArgs or {}
		self.privateEnv.lastArgs[cmdData.name] = snapshot

		if cmdData.name ~= "lastcommand" then
			self.privateEnv.lastCommand = {
				name = cmdData.name,
				args = snapshot
			}
		end
	end

	if cmdData.run == nil then
		logger:warn(`missing command run func: {cmdData.name}`)
		return
	end

	runningThreads[thread] = true
	local ok, err = pcall(cmdData.run, self, args)
	if not wasNested then
		runningThreads[thread] = nil
	end

	if not ok then
		error(err, 0)
	end
end



commandsController:run("fling")
check("fling is the last command", commandsController.privateEnv.lastCommand.name == "fling")
check("noclip started inside fling is not counted", usage.noclip == nil)

commandsController:run("lastcommand")
check("lastcommand replays fling, not noclip", commandsController.privateEnv.lastCommand.name == "fling")
check("replayed fling is counted once more", usage.fling == 2)

local paused = coroutine.create(function() commandsController:run("yielder") end)
local _, tag = coroutine.resume(paused)
check("yielder pauses inside run", tag == "paused")
commandsController:run("noclip")
check("command typed while another one is paused is top level", commandsController.privateEnv.lastCommand.name == "noclip")
check("and it is counted", usage.noclip == 1)
coroutine.resume(paused)
check("paused command finishes", coroutine.status(paused) == "dead")

local okBoom, errBoom = pcall(function() commandsController:run("boom") end)
check("an error inside a command still reaches the caller", (not okBoom) and string.find(tostring(errBoom), "bad command") ~= nil)
commandsController:run("noclip")
check("after an error the next command is top level again", usage.noclip == 2 and commandsController.privateEnv.lastCommand.name == "noclip")
end

do
	local function mkPlayer(name)
		return { Name = name, displayName = name, UserId = 1, AccountAge = 500, IsInGroup = function(self, id) return false end }
	end
	local me = mkPlayer("Me")
	me.IsFriendsWith = function(self, id) return false end
	RP = { list = { me, mkPlayer("Ann"), mkPlayer("Bob"), mkPlayer("group1"), mkPlayer("age20") } }
	RP_ME = me
	local Players = { GetPlayers = function(self) return table.clone(RP.list) end }
	local playerServiceMock = {}
	function playerServiceMock:getPlayersByName(query)
		local list = {}
		local subAt = #query
		query = query:lower()
		for _, player in Players:GetPlayers() do
			local name = string.lower(player.Name):sub(1, subAt)
			local displayName = string.lower(player.displayName):sub(1, subAt)
			if name == query or displayName == query then table.insert(list, player) end
		end
		return list
	end
	local function require(path)
		if path:find("rbxServices") then return { Players = Players } end
		if path:find("playerService") then return playerServiceMock end
		if path:find("localPlayer") then return me end
		error("unmapped require " .. path)
	end
	RP_MODULE = (function()
local robloxServices = require("../../framework/services/rbxServices")
local playerService = require("../../framework/services/playerService")
local localPlayer = require("../../framework/services/localPlayer")

-- Turns the text of a "player" argument into a list of Players.
-- Keywords: me, all, others, random, allies / team, enemies / nonteam, friends, nonfriends,
--           guests, bacons, alive, dead, nearest, farthest
-- Patterns: #amount, @username, %team name, age[number], rad[number], group[id]
-- Anything else is matched by name or display name prefix.

local function shuffle(list: { any })
	for index = #list, 2, -1 do
		local other = math.random(1, index)
		list[index], list[other] = list[other], list[index]
	end
	return list
end

local function getHumanoid(player: Player): Humanoid?
	local character = player.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function getRoot(player: Player): BasePart?
	local character = player.Character
	return character and character:FindFirstChild("HumanoidRootPart")
end

local function isAlive(player: Player): boolean
	local humanoid = getHumanoid(player)
	return humanoid ~= nil and humanoid.Health > 0
end

-- Distance from you to a player, or nil when either character is not loaded
local function distanceFromLocal(player: Player): number?
	local localRoot = getRoot(localPlayer)
	local root = getRoot(player)
	if not (localRoot and root) then return nil end

	return (root.Position - localRoot.Position).Magnitude
end

local function filter(players: { Player }, predicate: (Player) -> boolean): { Player }
	local list = {}
	for _, player in players do
		if predicate(player) then
			table.insert(list, player)
		end
	end
	return list
end

local function withoutLocal(players: { Player }): { Player }
	return filter(players, function(player)
		return player ~= localPlayer
	end)
end

local function isOnMyTeam(player: Player): boolean
	return localPlayer.Team ~= nil and player.Team == localPlayer.Team
end

local function hasBacon(player: Player): boolean
	local humanoid = getHumanoid(player)
	if not humanoid then return false end

	for _, accessory in humanoid:GetAccessories() do
		local name = accessory.Name:lower()
		if name:find("bacon", 1, true) or name:find("pal hair", 1, true) then
			return true
		end
	end
	return false
end

-- The nearest or farthest player, not counting you
local function byDistance(players: { Player }, farthest: boolean): { Player }
	local best = nil
	local bestDistance = nil

	for _, player in withoutLocal(players) do
		local distance = distanceFromLocal(player)
		if distance then
			local better = bestDistance == nil
				or (farthest and distance > bestDistance)
				or (not farthest and distance < bestDistance)

			if better then
				best, bestDistance = player, distance
			end
		end
	end

	if best then
		return { best }
	end
	return {}
end

local KEYWORDS = {
	me = function()
		return { localPlayer }
	end,
	all = function(players)
		return players
	end,
	others = function(players)
		return withoutLocal(players)
	end,
	random = function(players)
		if #players == 0 then return {} end
		return { players[math.random(1, #players)] }
	end,
	allies = function(players)
		return filter(players, isOnMyTeam)
	end,
	team = function(players)
		return filter(players, isOnMyTeam)
	end,
	enemies = function(players)
		return filter(withoutLocal(players), function(player)
			return not isOnMyTeam(player)
		end)
	end,
	nonteam = function(players)
		return filter(withoutLocal(players), function(player)
			return not isOnMyTeam(player)
		end)
	end,
	friends = function(players)
		return filter(withoutLocal(players), function(player)
			return localPlayer:IsFriendsWith(player.UserId)
		end)
	end,
	nonfriends = function(players)
		return filter(withoutLocal(players), function(player)
			return not localPlayer:IsFriendsWith(player.UserId)
		end)
	end,
	guests = function(players)
		return filter(players, function(player)
			return player.UserId <= 0
		end)
	end,
	bacons = function(players)
		return filter(players, hasBacon)
	end,
	alive = function(players)
		return filter(players, isAlive)
	end,
	dead = function(players)
		return filter(players, function(player)
			return not isAlive(player)
		end)
	end,
	nearest = function(players)
		return byDistance(players, false)
	end,
	farthest = function(players)
		return byDistance(players, true)
	end,
}

local PATTERNS = {
	{
		pattern = "^#(%d+)$",
		handler = function(players, captured)
			local list = shuffle(players)
			return table.move(list, 1, math.min(tonumber(captured), #list), 1, {})
		end,
	},
	{
		pattern = "^@(.+)$",
		handler = function(players, captured)
			-- username only, the display name is ignored
			return filter(players, function(player)
				return player.Name:lower():sub(1, #captured) == captured
			end)
		end,
	},
	{
		pattern = "^%%(.+)$",
		handler = function(players, captured)
			return filter(players, function(player)
				local team = player.Team
				return team ~= nil and team.Name:lower():sub(1, #captured) == captured
			end)
		end,
	},
	{
		pattern = "^age(%d+)$",
		handler = function(players, captured)
			local age = tonumber(captured)
			return filter(players, function(player)
				return player.AccountAge <= age
			end)
		end,
	},
	{
		pattern = "^rad(%d+)$",
		handler = function(players, captured)
			local radius = tonumber(captured)
			return filter(withoutLocal(players), function(player)
				local distance = distanceFromLocal(player)
				return distance ~= nil and distance <= radius
			end)
		end,
	},
	{
		pattern = "^group(%d+)$",
		handler = function(players, captured)
			local groupId = tonumber(captured)
			return filter(players, function(player)
				return player:IsInGroup(groupId)
			end)
		end,
	},
}

-- True when the text is a keyword or a pattern, not a player name
local function isSelector(text: string?): boolean
	local query = (text or "me"):lower()
	if KEYWORDS[query] then return true end

	for _, entry in PATTERNS do
		if query:match(entry.pattern) then return true end
	end
	return false
end

-- Trims spaces around a piece of text
local function trim(text: string): string
	return text:match("^%s*(.-)%s*$")
end

-- Resolves one selector or one name (no commas or operators)
local function resolveTerm(text: string, players: { Player }): { Player }
	local query = text:lower()

	local keyword = KEYWORDS[query]
	if keyword then
		return keyword(players)
	end

	for _, entry in PATTERNS do
		local captured = query:match(entry.pattern)
		if captured then
			return entry.handler(players, captured)
		end
	end

	return playerService:getPlayersByName(text)
end

-- The players of `first`, then the players of `second` that are not already there
local function union(first: { Player }, second: { Player }): { Player }
	local seen = {}
	local list = {}

	for _, player in first do
		if not seen[player] then
			seen[player] = true
			table.insert(list, player)
		end
	end

	for _, player in second do
		if not seen[player] then
			seen[player] = true
			table.insert(list, player)
		end
	end

	return list
end

-- The players of `first` that are not in `second`
local function difference(first: { Player }, second: { Player }): { Player }
	local remove = {}
	for _, player in second do
		remove[player] = true
	end

	return filter(first, function(player)
		return not remove[player]
	end)
end

-- Splits "a+b-c" into the terms with the operator in front of each one.
-- The first term always comes with "+", since nothing is before it.
local function splitOperators(text: string)
	local items = {}
	local op = "+"
	local buffer = {}

	for index = 1, #text do
		local char = text:sub(index, index)

		if char == "+" or char == "-" then
			table.insert(items, { op = op, term = trim(table.concat(buffer)) })
			buffer = {}
			op = char
		else
			table.insert(buffer, char)
		end
	end

	table.insert(items, { op = op, term = trim(table.concat(buffer)) })
	return items
end

-- Resolves "a+b-c" from left to right: start with the first term, then add (+) or take away (-) the rest.
-- "-friends" starts from everyone, so it means everyone except your friends.
local function resolveChain(text: string, players: { Player }): { Player }
	local items = splitOperators(text)
	local first = items[1]
	local result = {}

	if first.term ~= "" then
		result = resolveTerm(first.term, players)
	elseif items[2] and items[2].op == "-" then
		result = table.clone(players)
	end

	for index = 2, #items do
		local item = items[index]
		local matches = {}

		if item.term ~= "" then
			matches = resolveTerm(item.term, players)
		end

		if item.op == "+" then
			result = union(result, matches)
		else
			result = difference(result, matches)
		end
	end

	return result
end

-- The comma-separated parts of an argument, trimmed and without empty ones: "noob, bob" -> "noob", "bob"
local function parts(text: string): { string }
	local list = {}

	for part in text:gmatch("[^,]+") do
		local value = trim(part)

		if value ~= "" then
			table.insert(list, value)
		end
	end

	return list
end

-- True when the text has commas or operators, so it is a list of expressions and not one name
local function hasOperators(text: string?): boolean
	return text ~= nil and text:find("[,+%-]") ~= nil
end

-- The players an argument refers to. A plain name or selector is tried first, so a display name
-- with a "-" in it still works; otherwise the text is read as comma-separated expressions.
local function resolvePlayers(text: string?): { Player }
	local input = text or "me"
	local players = robloxServices.Players:GetPlayers()
	local whole = resolveTerm(trim(input), players)

	if #whole > 0 then
		return whole
	end

	if not hasOperators(input) then
		-- a selector that matches nobody can still be a player name (group1, age20, rad5...)
		return playerService:getPlayersByName(trim(input))
	end

	local result = {}

	for _, part in parts(input) do
		result = union(result, resolveChain(part, players))
	end

	return result
end

-- Callable like before (resolvePlayers(text)), and also exposes the helpers used by the validator
return setmetatable({
	isSelector = isSelector,
	hasOperators = hasOperators,
	parts = parts,
}, {
	__call = function(_, text: string?)
		return resolvePlayers(text)
	end,
})

	end)()
	local function rp(text) return RP_MODULE(text) end
	check("resolvePlayers: a name", #rp("Bob") == 1 and rp("Bob")[1].Name == "Bob")
	check("resolvePlayers: all", #rp("all") == 5)
	check("resolvePlayers: me", rp("me")[1] == me)
	check("resolvePlayers: a comma list", #rp("Ann,Bob") == 2)
	check("resolvePlayers: #2 gives two", #rp("#2") == 2)
	check("resolvePlayers: nobody gives none", #rp("nobody") == 0)
	check("resolvePlayers: a player named group1 is found", #rp("group1") == 1 and rp("group1")[1].Name == "group1")
	check("resolvePlayers: a player named age20 is found", #rp("age20") == 1 and rp("age20")[1].Name == "age20")
	check("resolvePlayers: group2 with no such player is empty", #rp("group2") == 0)
end

do
	Color3 = { fromRGB = function(r, g, b) return { r, g, b } end }
	local PLAYERS_SERVICE = { GetPlayers = function(self) return table.clone(RP.list) end, LocalPlayer = RP_ME }
	local function require(path)
		if path:find("espManager") then return { new = function() return {} end } end
		if path:find("resolvePlayers") then return RP_MODULE end
		if path:find("rbxServices") then return { Players = PLAYERS_SERVICE, CoreGui = {} } end
		if path:find("private") then return {} end
		error("unmapped require " .. path)
	end
	local entries = (function()
-- ESP commands: esp, espteam, chams, partesp and locate. The drawing is done by systems/espManager.luau.
-- One manager per name: esp and espteam share "esp", chams uses "chams", partesp uses "partesp",
-- locate uses "locate:<player name>" (one per player).
-- esp and chams don't run together (same rule as IY).

local EspManager = require("../../systems/espManager")
local resolvePlayers = require("../../systems/resolvePlayers")
local robloxServices = require("../../../framework/services/rbxServices")
local privateEnv = require("../../../framework/environment/private")

local Players = robloxServices.Players

local DEFAULT_TRANSPARENCY = 0.3
local GREEN = Color3.fromRGB(0, 255, 0)
local RED = Color3.fromRGB(255, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)
local PART_GREEN = Color3.fromRGB(50, 205, 50)

-- Every character except yours
local function characters()
	local list = {}
	local me = Players.LocalPlayer

	for _, player in Players:GetPlayers() do
		if player ~= me and player.Character then
			table.insert(list, player.Character)
		end
	end

	return list
end

local function playerColor(character)
	local player = Players:GetPlayerFromCharacter(character)
	if player then
		return player.TeamColor.Color
	end
	return WHITE
end

local function teamColor(character)
	local player = Players:GetPlayerFromCharacter(character)
	if player and player.TeamColor == Players.LocalPlayer.TeamColor then
		return GREEN
	end
	return RED
end

local function constantColor(color)
	return function()
		return color
	end
end

-- The table is read on every update, so adding or removing a name takes effect without restarting
local function namedParts(names)
	return function()
		local list = {}

		for _, object in workspace:GetDescendants() do
			if object:IsA("BasePart") and names[object.Name:lower()] then
				table.insert(list, object)
			end
		end

		return list
	end
end

-- Label text of esp and locate, the same as IY: name, health and studs
local function espText(character, meters, studs)
	local player = Players:GetPlayerFromCharacter(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	local health = 0
	if humanoid then
		health = math.floor(humanoid.Health * 10 + 0.5) / 10
	end

	return ("Name: %s | Health: %g | Studs: %d"):format(
		player and player.Name or character.Name,
		health,
		studs
	)
end

local function stopManager(self, name)
	local garbage = self:collectGarbage(name)

	if garbage and garbage.manager then
		garbage.manager:destroy()
	end
end

local function startManager(self, name, options)
	stopManager(self, name)

	options.tag = name
	local manager = EspManager.new(options)

	local garbage = self:createGarbage(name)
	garbage.manager = manager
	manager:start()
end

local function startEsp(self, color)
	if self:hasGarbage("chams") then
		self:notify("ESP", "Disable chams (nochams) before using esp")
		return
	end

	startManager(self, "esp", {
		source = characters,
		color = color,
		-- text = espText,
		showBoxes = true,
		showText = true,
	})
end

-- locate: a single player, same look as IY (name, health and studs in the label)
local LOCATE_PREFIX = "locate:"

local function locateName(player)
	return LOCATE_PREFIX .. player.Name
end

-- Reads player.Character on every update, so a respawn is followed automatically
local function startLocate(self, player)
	startManager(self, locateName(player), {
		source = function()
			local character = player.Character
			if character then
				return { character }
			end
			return {}
		end,
		color = playerColor,
		-- text = espText,
		showBoxes = true,
		showText = true,
	})
end

return {
	{
		action = "esp",
		description = "View all players and their status",
		run = function(self)
			startEsp(self, playerColor)
		end
	},
	{
		action = "espteam",
		description = "ESP but teammates are green and bad guys are red",
		run = function(self)
			startEsp(self, teamColor)
		end
	},
	{
		action = "noesp|unesp|unespteam",
		description = "Removes ESP",
		run = function(self)
			stopManager(self, "esp")
		end
	},
	{
		action = "esptransparency",
		description = "Changes the transparency of ESP related commands",
		args = { kind = "number" },
		run = function(self, args)
			local value = args:nextValue()
			privateEnv.espTransparency = math.clamp(value or DEFAULT_TRANSPARENCY, 0, 1)
		end
	},
	{
		action = "partesp",
		description = "Highlights a part",
		args = {
			kind = "string",
			name = "part name"
		},
		run = function(self, args)
			local name = args:nextValue()
			if not name then
				self:notify("partesp", "Write the name of a part")
				return
			end

			local names = privateEnv.partEspNames or {}
			privateEnv.partEspNames = names
			names[name:lower()] = true

			if not self:hasGarbage("partesp") then
				startManager(self, "partesp", {
					source = namedParts(names),
					color = constantColor(PART_GREEN),
					showBoxes = true,
					showText = false,
					interval = 1,
				})
			end
		end
	},
	{
		action = "unpartesp|nopartesp",
		description = "removes partesp",
		args = {
			kind = "string",
			name = "part name"
		},
		run = function(self, args)
			local names = privateEnv.partEspNames or {}
			privateEnv.partEspNames = names

			local name = args:nextValue()
			if name then
				names[name:lower()] = nil
			else
				table.clear(names)
			end

			if next(names) == nil then
				stopManager(self, "partesp")
			end
		end
	},
	{
		action = "chams",
		description = "ESP but without text in the way",
		run = function(self)
			if self:hasGarbage("esp") then
				self:notify("Chams", "Disable ESP (noesp) before using chams")
				return
			end

			startManager(self, "chams", {
				source = characters,
				color = playerColor,
				showBoxes = true,
				showText = false,
			})
		end
	},
	{
		action = "nochams|unchams",
		description = "Removes chams",
		run = function(self)
			stopManager(self, "chams")
		end
	},
	{
		action = "locate",
		description = "View a single player and their status",
		args = { kind = "player" },
		run = function(self, args)
			local text = args:nextValue()
			if not text then
				return
			end

			for _, player in resolvePlayers(text) do
				if player ~= Players.LocalPlayer then
					startLocate(self, player)
				end
			end
		end
	},
	{
		action = "unlocate|nolocate",
		description = "Removes locate",
		args = { kind = "player" },
		run = function(self, args)
			local text = args:nextValue()

			if not text then
				-- no argument: stop every locate
				local names = {}
				for name in pairs(self.garbages) do
					if name:sub(1, #LOCATE_PREFIX) == LOCATE_PREFIX then
						table.insert(names, name)
					end
				end

				for _, name in names do
					stopManager(self, name)
				end
				return
			end

			-- players that are still in the game, by selector or by name
			local names = {}
			for _, player in resolvePlayers(text) do
				table.insert(names, locateName(player))
			end

			-- a player who already left is not in the game anymore, so also match the stored locates by name
			if not resolvePlayers.isSelector(text) then
				local wanted = text:lower()
				for name in pairs(self.garbages) do
					if name:sub(1, #LOCATE_PREFIX) == LOCATE_PREFIX then
						local playerName = name:sub(#LOCATE_PREFIX + 1):lower()
						if playerName:sub(1, #wanted) == wanted then
							table.insert(names, name)
						end
					end
				end
			end

			for _, name in names do
				stopManager(self, name)
			end
		end
	}
}

	end)()
	local unlocate
	for _, entry in entries do
		if entry.action == "unlocate|nolocate" then unlocate = entry end
	end
	local destroyed = {}
	local selfObj = { garbages = {} }
	function selfObj:collectGarbage(name)
		local g = self.garbages[name]; self.garbages[name] = nil; return g
	end
	function selfObj:createGarbage(name)
		if self.garbages[name] == nil then self.garbages[name] = {}; return self.garbages[name] end
	end
	function selfObj:hasGarbage(name) return self.garbages[name] ~= nil end
	function selfObj:notify() end
	local function addLocate(name)
		selfObj.garbages["locate:" .. name] = { manager = { destroy = function() table.insert(destroyed, name) end } }
	end
	local function argOf(value) return { nextValue = function() return value end } end

	RP.list = { RP_ME, RP.list[2] }      -- Bob has left the game, Ann is still here
	addLocate("Bob"); addLocate("Ann")
	selfObj.garbages.esp = { manager = { destroy = function() table.insert(destroyed, "esp") end } }
	unlocate.run(selfObj, argOf("bob"))
	check("unlocate bob stops the locate of a player who left", selfObj.garbages["locate:Bob"] == nil and table.find(destroyed, "Bob") ~= nil)
	check("unlocate bob leaves Ann's locate alone", selfObj.garbages["locate:Ann"] ~= nil)
	unlocate.run(selfObj, argOf("ann"))
	check("unlocate ann stops Ann's locate", selfObj.garbages["locate:Ann"] == nil)
	check("unlocate never touches esp", selfObj.garbages.esp ~= nil and table.find(destroyed, "esp") == nil)
	addLocate("Ann"); addLocate("Bob")
	unlocate.run(selfObj, argOf(nil))
	check("unlocate with no argument stops every locate", selfObj.garbages["locate:Ann"] == nil and selfObj.garbages["locate:Bob"] == nil and selfObj.garbages.esp ~= nil)
end

do
	local TP = { label = "TeleportService" }
	local CURRENT_METHOD, CHECKCALLER = "", false
	local hooks = {}
	local function hookmetamethod(obj, mm, fn)
		hooks[mm] = fn
		return function(...) return "ORIG", ... end
	end
	local function getnamecallmethod() return CURRENT_METHOD end
	game = { PlaceId = 123 }
	local store = {}
	local settings = {
		getValue = function(self, key) return store[key] end,
		setValue = function(self, key, value) store[key] = value end,
	}
	local selfObj = {
		privateEnv = {},
		teleportService = TP,
		storage = { settings = settings },
		executorEnv = { checkcaller = function() return CHECKCALLER end },
		expectExploit = function(self, name)
			if name == "hookmetamethod" then return hookmetamethod end
			return getnamecallmethod
		end,
		notify = function() end,
	}
	local mod = (function()
return {
	action = "clientantiteleport|antiteleport",
	description = "Prevents localscripts from teleporting you (CLIENT)",
	run = function(self)
		if self.privateEnv.clientAntiTeleport then
			self:notify("Client AntiTP", "already active")
			return
		end

		local hookmetamethod = self:expectExploit("hookmetamethod")
		local getnamecallmethod = self:expectExploit("getnamecallmethod")
		if not (hookmetamethod and getnamecallmethod) then return end

		local teleportService = self.teleportService
		local settings = self.storage.settings
		local checkcaller = self.executorEnv.checkcaller

		local oldIndex
		oldIndex = hookmetamethod(game, "__index", function(object, key)
			if object == teleportService and typeof(key) == "string" then
				if key:lower() == "teleport" then
					error("Expected ':' not '.' calling member function Teleport", 2)
				elseif key == "TeleportToPlaceInstance" then
					error("Expected ':' not '.' calling member function TeleportToPlaceInstance", 2)
				end
			end
			return oldIndex(object, key)
		end)

		local oldNamecall
		oldNamecall = hookmetamethod(game, "__namecall", function(object, ...)
			if object == teleportService and not checkcaller() then
				local method = getnamecallmethod()
				if method:lower() == "teleport" or method == "TeleportToPlaceInstance" then
					-- Only a rejoin of this same place gets through, and only with allowrejoin on (same as IY).
					-- Calls made by our own script (checkcaller) always get through, so 'rejoin' keeps working.
					local placeId = ...
					local allowed = settings:getValue("allowRejoin") == true and placeId == game.PlaceId
					if not allowed then return end
				end
			end
			return oldNamecall(object, ...)
		end)

		self.privateEnv.clientAntiTeleport = true
		self:notify("Client AntiTP", "Client anti teleport is now active (only effective on localscript teleport)")
	end
}

	end)()
	mod.run(selfObj)
	local namecall = hooks["__namecall"]
	local function call(object, method, ...)
		CURRENT_METHOD = method
		return table.pack(namecall(object, ...))
	end
	store.allowRejoin = nil; CHECKCALLER = false
	local r = call(TP, "TeleportToPlaceInstance", 123, "job", "p")
	check("antiteleport blocks a teleport from a script (no allowrejoin)", r.n == 0)
	store.allowRejoin = true
	r = call(TP, "TeleportToPlaceInstance", 123, "job", "p")
	check("allowrejoin lets a rejoin of the same place through", r[1] == "ORIG")
	r = call(TP, "TeleportToPlaceInstance", 999, "job", "p")
	check("allowrejoin still blocks a teleport to another place", r.n == 0)
	store.allowRejoin = nil; CHECKCALLER = true
	r = call(TP, "TeleportToPlaceInstance", 123, "job", "p")
	check("our own rejoin (checkcaller) is never blocked", r[1] == "ORIG")
	CHECKCALLER = false
	r = call(TP, "GetPlayers")
	check("other methods of the teleport service are not touched", r[1] == "ORIG")
end

do
	local store, notes = {}, {}
	local selfObj = {
		storage = { settings = {
			getValue = function(self, k) return store[k] end,
			setValue = function(self, k, v) store[k] = v end,
		} },
		notify = function(self, title, message) table.insert(notes, message) end,
	}
	local function argOf(v) return { nextValue = function() return v end } end
	local mod = (function()
return {
	client = true,
	action = "allowrejoin|allowrj",
	description = "Changes if antiteleport allows you to rejoin or not",
	args = { kind = "boolean", name = "allow", optional = true },
	run = function(self, args)
		local allow = args:nextValue()

		-- no argument toggles it, like IY
		if allow == nil then
			allow = not self.storage.settings:getValue("allowRejoin")
		end

		self.storage.settings:setValue("allowRejoin", allow)
		self:notify("Client AntiTP", `Scripts now {allow and "may" or "may not"} make you rejoin the server`)
	end
}

	end)()
	local ok1 = pcall(mod.run, selfObj, argOf(true))
	check("allowrejoin true runs and stores true", ok1 and store.allowRejoin == true)
	check("allowrejoin reports that rejoin is allowed", ok1 and notes[#notes] ~= nil and string.find(notes[#notes], "may make you rejoin") ~= nil)
	pcall(mod.run, selfObj, argOf(nil))
	check("allowrejoin with no argument toggles it", store.allowRejoin == false)
	pcall(mod.run, selfObj, argOf(false))
	check("allowrejoin false stores false", store.allowRejoin == false)
end

do
	Enum = { CreatorType = { User = "User", Group = "Group" } }
	game = { CreatorId = 555, CreatorType = "Group" }
	local notes = {}
	local selfObj = {
		groupService = { GetGroupInfoAsync = function(self, id) return { Owner = { Id = 777 } } end },
		notify = function(self, title, message) table.insert(notes, message) end,
		executorEnv = { setclipboard = function() end },
		localPlayer = { UserId = 0 },
	}
	local mod = (function()
-- The creator of the game. For a group game that is the owner of the group.
local function getOwnerId(self)
	local creatorId = game.CreatorId

	if game.CreatorType ~= Enum.CreatorType.User then
		creatorId = self.groupService:GetGroupInfoAsync(creatorId).Owner.Id
	end

	return creatorId
end

return {
	{
		action = "creatorid",
		description = "Notify, or copies the creators ID to your clipboard",
		args = { kind = "boolean", name = "copy", optional = true },
		run = function(self, args)
			local ownerId = tostring(getOwnerId(self))

			if args:nextValue() then
				self.executorEnv.setclipboard(ownerId)
			end

			self:notify("Creator Id", `the OwnerId is '{ownerId}'`)
		end
	},
	{
		client = true,
		action = "setcreatorid|setascreator",
		description = "Sets your userid to the creators ID",
		run = function(self, args)
			local ownerId = getOwnerId(self)
			self.localPlayer.UserId = ownerId
			self:notify("Set ID", `Set UserId to '{ownerId}'`)
		end
	}
}

	end)()
	local nothing = { nextValue = function() return nil end }
	local ok = pcall(mod[1].run, selfObj, nothing)
	check("creatorid works in a group game", ok and notes[#notes] ~= nil and string.find(notes[#notes], "777") ~= nil)
	local ok2 = pcall(mod[2].run, selfObj, nothing)
	check("setcreatorid works in a group game", ok2 and selfObj.localPlayer.UserId == 777)
	game.CreatorType = "User"
	ok = pcall(mod[1].run, selfObj, nothing)
	check("creatorid in a user game gives the user id", ok and string.find(notes[#notes], "555") ~= nil)
end

do
	local clock, calls = 0, 0
	FAKE_CLOCK = function() calls += 1; clock += 0.001; return clock end
	task = { wait = function(t) coroutine.yield("wait", t) end }
	local cap = 60
	local co = coroutine.create(function()
local os_clock = FAKE_CLOCK
			local task_wait = task.wait
			
			local timer = os_clock() + (1 / cap)
			
			while true do
				task_wait(math.max(timer - os_clock(), 0))
				timer = os_clock() + (1 / cap)
			end
	end)
	local ok, tag = coroutine.resume(co)
	check("setfpscap fallback yields quickly instead of spinning (" .. calls .. " clock reads)", tag == "wait" and calls < 10)
end
print(string.format("\n%s: %d passed, %d failed", "new", passed, failed))
