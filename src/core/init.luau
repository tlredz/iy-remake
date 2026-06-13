local commandsController = require("../controllers/commandsController")
local playerService = require("../services/playerService")
local fetchService = require("../services/fetchService")

local logger = require("../utils/logger")
local infiniteYield = require("../ui/iy")

local payload = {
	infiniteYield = infiniteYield,
	playerService = playerService,
	fetchService = fetchService
}

logger:log("initializing commands controller")
commandsController:init(payload)

logger:log("creating IY interface")
infiniteYield:create()

return infiniteYield