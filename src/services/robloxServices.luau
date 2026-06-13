local robloxServices = {}

local executorEnv = require("../config/executorEnv")
local logger = require("../utils/logger")

function robloxServices:__index(serviceName)
	logger:expect(serviceName, {"string"}, "[index] serviceName")
	
	local service = game:GetService(serviceName)
	local clone = executorEnv.cloneref(service)
	
	rawset(self, serviceName, clone)
	return clone
end

return setmetatable({}, robloxServices)