-- src/core/init.luau

local commandsController = require("../commands/controllers/commandsController")
local playerService = require("../framework/services/playerService")
local fetchService = require("../framework/services/fetchService")

local checkStubs = require("./checkStubs")

local interface = require("../ui")

local infiniteYield = {}

function infiniteYield:boot()
	require("./cleanup"):init()
	
	commandsController:init({
		infiniteYield = interface,
		playerService = playerService,
		fetchService = fetchService
	})
	
	checkStubs(commandsController)
	
	interface:init()
end

return infiniteYield