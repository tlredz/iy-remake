local privateEnv = require("../config/privateEnv")
local logger = require("../utils/logger")

if privateEnv.screenGui then
	privateEnv.screenGui:Destroy()
	logger:log("destroyed old interface")
end

if privateEnv.connectionService then
	privateEnv.connectionService:cleanup()
	logger:log("cleaned old connections")
end

return true