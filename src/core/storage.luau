local localPlayer = require("../framework/services/localPlayer")
local datas = require("../storage")

local function registerSettings()
	local settingsData = datas.settings
	settingsData:register("clearOnEnter", true)
	settingsData:register("spaceAfterCorrection", true)
	settingsData:register("uiScale", 1.4)
	settingsData:save()
end

-- the time of this run, in seconds since 1970. It is asked of the engine each run. A date written as text in the code is the
-- same in every run: a build can work it out once and keep it as a constant
local function nowSeconds(): number
	return DateTime.now().UnixTimestamp
end

local function registerUserData()
	local userData = datas.user
	local usedPlaces = userData:register("usedPlaces", {})
	
	userData:register("totalUsedCommands", {})
	userData:register("usedAccounts", {})
	
	-- a date kept as text by an older version is not a number, so it is replaced by the time of this run
	userData:register("firstTimeExecuted", nowSeconds())
	userData:register("lastTimeExecuted", 0)
	userData:register("executionCount", 0)
	
	userData:add("usedAccounts", localPlayer.UserId)
	userData:increment("executionCount", 1)
	userData:setValue("lastTimeExecuted", nowSeconds())
	
	-- text keys, like the rest of the saved data: a numeric key can't be written as JSON, so the file would never save
	local gameKey = tostring(game.GameId)
	usedPlaces[gameKey] = (usedPlaces[gameKey] or 0) + 1
	
	userData:save()
end

registerSettings()
registerUserData()

return true