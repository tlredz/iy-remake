local commandsList = require("../commands/list")
local signal = require("../utils/signal")
local logger = require("../utils/logger")

local usedCmdsData = require("../storage/datas").usedCmds
local robloxServices = require("../services/robloxServices")

local searchController = require("./searchController")
local argsManager = require("../systems/argsManager")

local MAX_TIMES_USED = 5
local DECRESE_PER_USE = 0.25

local commandsController = {
	garbages = {}
}

function commandsController:createGarbage(name: string): { [any]: any }
	logger:assert(self.garbages[name] == nil, "attempt to create a existing garbage")
	
	local garbage = {}
	self.garbages[name] = garbage
	return garbage
end

function commandsController:hasGarbage(name: string): boolean
	return self.garbages[name] ~= nil
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
	
	local newValue = math.clamp(currentValue + 1, 0, MAX_TIMES_USED)
	usedCmdsData:setValue(targetFlag, newValue)
	
	for currentFlag, value in usedCmdsData:getData() do
		if currentFlag == targetFlag then continue end
		
		local forceDecay = (newValue == MAX_TIMES_USED)
		
		if (forceDecay or value < newValue) and value > 0 then
			value -= DECRESE_PER_USE
			
			if value == 0 then value = nil end
			usedCmdsData:setValue(currentFlag, value)
		end
	end
	
	usedCmdsData:save()
end

function commandsController:run(cmdName: string, args: { any }): (nil)
	logger:expect(cmdName, {"string"}, "'commandsController:run' #1")
	logger:expect(args, {"table", "nil"}, "'commandsController:run' #2")
	
	local cmdData = commandsList.lookup[cmdName]
	logger:assert(cmdData, "invalid command")
	
	self:commandUsed(cmdData.name)
	
	if cmdData.run ~= nil then
		args = argsManager.new(args or {})
		cmdData.run(self, args)
		return
	end
	
	logger:warn(`missing command run func: {cmdData.name}`)
end

function commandsController:search(query: string, onlyBests: boolean): { string }
	local bestMatches = searchController:searchAtArray(commandsList.array, query, onlyBests)
	
	table.sort(bestMatches, function(cmd1, cmd2)
		local priority1 = usedCmdsData:getValue(cmd1) or 0
		local priority2 = usedCmdsData:getValue(cmd2) or 0
		
		return priority1 > priority2
	end)
	
	return bestMatches
end

function commandsController:init(config)
	logger:assert(config, "expected a config to init")
	
	local stringifier = require("../utils/stringifier")
	local notifier = require("../ui/notifier")
	
	-- functions
	function self:notify(msg)
		return notifier:notify(msg)
	end
	
	function self:stringify(value)
		return stringifier:stringify(value)
	end
	
	function self:unstringify(value)
		return stringifier:unstringify(value)
	end
	
	-- variables
	self.localPlayer = require("../services/localPlayer")
	
	-- modules
	self.infiniteYield = config.infiniteYield
	self.playerService = config.playerService
	self.fetchService = config.fetchService
	
	-- configs
	self.config = {
		links = require("../config/iy").links
	}
	
	-- storage
	self.datas = require("../storage/datas")
	
	-- roblox services
	self.robloxServices = robloxServices
	self.starterGui = robloxServices.StarterGui
	self.coreGui = robloxServices.CoreGui
	self.players = robloxServices.Players
	self.guiService = robloxServices.GuiService
end

return commandsController