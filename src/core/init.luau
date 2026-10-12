-- src/core/init.luau

require("./cleanup"):init()

local commandsController = require("../commands/controllers/commandsController")
local keepiy = require("../commands/systems/keepiy")
local playerService = require("../framework/services/playerService")
local fetchService = require("../framework/services/fetchService")
local eventListeners = require("../commands/services/eventListeners")

-- local checkStubs = require("./checkStubs")

local interface = require("../ui")

local infiniteYield = {}

function infiniteYield:boot()
	self.boot = nil
	
	commandsController:init({
		infiniteYield = interface,
		playerService = playerService,
		fetchService = fetchService
	})
	
	keepiy.start()
	
	-- checkStubs(commandsController)
	interface:awake() -- interface:init()

	-- the game events run the event binds (OnExecute runs right away, after the interface is up)
	eventListeners.start()
end

return infiniteYield