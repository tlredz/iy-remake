local executorEnv = require("../environment/executor")

if require("./isTesting") then
	return false
end

if LOADED_IY or executorEnv.LOADED_IY then
	return true
end

executorEnv.LOADED_IY = true

return false