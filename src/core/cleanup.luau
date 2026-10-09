local privateEnv = require("../framework/environment/private")
local logger = require("../utils/logger")

local cleanup = {}

function cleanup:init()
    if privateEnv.screenGui then
        privateEnv.screenGui:Destroy()
        logger:log("destroyed old interface")
    end
    
    if privateEnv.connectionService then
        privateEnv.connectionService:cleanup()
        logger:log("cleaned old connections")
    end
    
    logger:log("finished cleanup!")
end

return cleanup