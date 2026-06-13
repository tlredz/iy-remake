-- testing in terminal
if require("../config/isTerminal") then
	return require("../tests/commands")
end

-- import logger
local logger = require("../utils/logger")

-- check if is already loaded
if require("../config/isLoaded") then
	logger:fail("is already loaded")
	return nil
end

-- debug loading
logger:log("loading IY Remake...")
logger:log("is mobile:", require("../config/isMobile"))
logger:log("is testing:", require("../config/isTesting"))
logger:log("current version:", require("../config/iy").version)
logger:log("is remake version:", require("../config/iy").isRemakeVersion)

require("./cleanup") -- clear before creates a new UI
require("./storage") -- init the storage
-- require("./assets") -- load infinite yield assets
require("./checkVersion")
require("./init")

-- create interface
return require("../ui/iy")