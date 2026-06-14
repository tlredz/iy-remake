local localPlayer = require("../services/localPlayer")
local datas = require("../storage/datas")

local function registerSettings()
	local settingsData = datas.settings
	settingsData:register("clearOnEnter", true)
	settingsData:register("spaceAfterCorrection", true)
	settingsData:register("uiScale", 1)
	settingsData:save()
end

local function registerUserData()
	local userData = datas.user
	local usedPlaces = userData:register("usedPlaces", {})
	
	userData:register("totalUsedCommands", {})
	userData:register("usedAccounts", {})
	
	userData:register("firstTimeExecuted", os.date("%Y-%m-%d %H:%M:%S"))
	userData:register("lastTimeExecuted", "")
	userData:register("executionCount", 0)
	
	userData:add("usedAccounts", localPlayer.UserId)
	userData:increment("executionCount", 1)
	userData:setValue("lastTimeExecuted", os.date("%Y-%m-%d %H:%M:%S"))
	
	usedPlaces[game.GameId] = (usedPlaces[game.GameId] or 0) + 1
	
	userData:save()
end

registerSettings()
registerUserData()

return true