local executorEnv = require("./executorEnv")

local envTag = "IY-REMAKE-PRIVATEENV"

local privateEnv = executorEnv[envTag] or {}
executorEnv[envTag] = privateEnv

return privateEnv