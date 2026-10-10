local privateEnv = require("../../framework/environment/private")
local executorEnv = require("../../framework/environment/executor")

local commandsList = require("../list")
local signal = require("../../utils/signal")
local logger = require("../../utils/logger")

local usedCmdsData = require("../../storage").usedCmds
local robloxServices = require("../../framework/services/rbxServices")
local frameworkSettings = require("../../framework/settings")

local searchController = require("./searchController")
local customAliases = require("../systems/customAliases")
local pluginsSystem = require("../systems/plugins")

local rankConfig = frameworkSettings.commands.cmdsRank
local MAX_TIMES_USED = rankConfig.maxTimesUsed
local DECREASE_PER_USE = rankConfig.decreasePerUse
local INCREASE_PER_USE = rankConfig.increasePerUse

local garbages = privateEnv.iyGarbages or {}
privateEnv.iyGarbages = garbages

local commandsController = {
	garbages = garbages
}

function commandsController:registerGarbage(name: string): { [any]: any }
	return self:getGarbage(name) or self:createGarbage(name)
end

function commandsController:createGarbage(name: string): { [any]: any }?
	if self.garbages[name] == nil then
		local garbage = {}
		self.garbages[name] = garbage
		return garbage
	end
end

-- Command data by any alias (case-insensitive), or nil when the command does not exist
function commandsController:getCommandData(name: string)
	return commandsList.lookup[name:lower()]
end

function commandsController:hasGarbage(name: string): boolean
	return self.garbages[name] ~= nil
end

function commandsController:getGarbage(name: string): boolean
	return self.garbages[name]
end

function commandsController:collectGarbage(name: string): { [any]: any }
	local garbage = self.garbages[name]
	
	if garbage ~= nil then
		self.garbages[name] = nil
		return garbage
	end
end

function commandsController:commandUsed(targetFlag)
	local currentValue = usedCmdsData:getValue(targetFlag) or 0
	
	local newValue = math.clamp(currentValue + INCREASE_PER_USE, 0, MAX_TIMES_USED)
	usedCmdsData:setValue(targetFlag, newValue)
	
	for currentFlag, value in usedCmdsData:getData() do
		if currentFlag == targetFlag then continue end
		
		local forceDecay = (newValue == MAX_TIMES_USED)
		
		if (forceDecay or value < newValue) and value > 0 then
			value -= DECREASE_PER_USE
			
			if value == 0 then value = nil end
			usedCmdsData:setValue(currentFlag, value)
		end
	end
	
	usedCmdsData:save()
end

-- Keeps the values of the arguments, so 'lastcommand' can run the same command again
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

-- The arguments a command last ran with, or nil when it has not run yet
function commandsController:getLastArgs(name: string)
	local stored = self.privateEnv.lastArgs
	return stored and stored[name]
end

local function getUsage(alias: string): number
	local command = commandsList.lookup[alias:lower()]
	if command == nil then return 0 end
	
	-- usage is stored by command name, not by alias
	return usedCmdsData:getValue(command.name) or 0
end

function commandsController:search(query: string, onlyBests: boolean): { string }
	local matches = searchController:searchAtArray(commandsList.array, query, onlyBests)
	local lowerQuery = query:lower()
	local ranked = {}
	
	for index, alias in matches do
		table.insert(ranked, {
			alias = alias,
			index = index,
			isPrefix = alias:lower():sub(1, #lowerQuery) == lowerQuery,
			usage = getUsage(alias),
		})
	end
	
	table.sort(ranked, function(a, b)
		if a.isPrefix ~= b.isPrefix then return a.isPrefix end
		if a.usage ~= b.usage then return a.usage > b.usage end
		return a.index < b.index
	end)
	
	local bestMatches = {}
	for position, entry in ranked do
		bestMatches[position] = entry.alias
	end
	
	return bestMatches
end

function commandsController:init(config)
	logger:assert(config, "'commandsController:init' #1 expected a config to init")
	
	local connectionService = require("../../framework/services/connectionService")
	local stringifier = require("../../utils/stringifier")
	local notifier = require("../../ui/notifier")
	
	-- functions
	function self:notify(...)
		return notifier:notify(...)
	end
	
	function self:stringify(...)
		return stringifier:stringify(...)
	end
	
	function self:unstringify(...)
		return stringifier:unstringify(...)
	end
	
	function self:connect(...)
		return connectionService:Connect(...)
	end
	
	function self:expectExploit(name)
		local value = executorEnv[name]
		if value ~= nil then return value end
		
		self:notify("Incompatible Exploit", `Your exploit does not support this command (missing {name})`)
	end
	
	function self:getRoot()
		local root = self.playerService:getRootPart()
		if root then return root end
		
		self:notify("Character", "your character is not loaded")
	end
	
	-- variables
	self.localPlayer = require("../../framework/services/localPlayer")
	self.executorEnv = executorEnv
	self.privateEnv = privateEnv
	
	-- modules
	self.infiniteYield = config.infiniteYield
	self.playerService = config.playerService
	self.fetchService = config.fetchService
	
	-- signals
	self.signals = {
		onCameraReset = signal.new()
	}
	
	-- configs
	self.config = {
		links = frameworkSettings.links
	}
	
	-- rbxSettings
	self.userSettings = UserSettings()
	self.gameSettings = settings()
	
	self.userGameSettings = self.userSettings:GetService("UserGameSettings")
	self.gameNetworkSettings = self.gameSettings:GetService("NetworkSettings")
	
	-- commands services
	self.loopService = require("../services/loopService")
	
	-- storage
	self.storage = require("../../storage")
	
	-- roblox services
	self.robloxServices = robloxServices
	self.rbxServices = robloxServices
	
	self.teleportService = robloxServices.TeleportService
	self.groupService = robloxServices.GroupService
	self.runService = robloxServices.RunService
	self.starterGui = robloxServices.StarterGui
	self.coreGui = robloxServices.CoreGui
	self.players = robloxServices.Players
	self.guiService = robloxServices.GuiService
	self.networkClient = robloxServices.NetworkClient
	self.proximityPromptService = robloxServices.ProximityPromptService
	self.commandsList = commandsList
	
	-- custom aliases from 'addalias' (the alias commands reach the list through self.commandsList)
	customAliases.restore(commandsList)
	
	-- installed plugins; a plugin that fails stays installed and is logged
	for name, reason in pluginsSystem.restore(commandsList) do
		logger:warn(`plugin '{name}' could not be loaded: {reason}`)
	end
end

return commandsController