-- src/core/init.luau

require("./cleanup"):init()

local commandsController = require("../commands/controllers/commandsController")
local playerService = require("../framework/services/playerService")
local fetchService = require("../framework/services/fetchService")

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
	
	-- checkStubs(commandsController)
	interface:awake() -- interface:init()
end

return infiniteYield