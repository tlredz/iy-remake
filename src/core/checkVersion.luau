-- /src/core/checkVersion.luau
-- checks and notifies the user if it's an old version. 

local tools = require("../utils/tools")
local fetchService = require("../framework/services/fetchService")
local frameworkSettings = require("../framework/settings")

local function checkVersion()
	local versionToNumber = tools.versionToNumber
	local currentVersion = require("../version")
	
	local latestVersion = fetchService.fetch("/src/version.luau")
	if latestVersion == nil then return end
	
	local versionChunk = loadstring(latestVersion)
	if versionChunk == nil then return end
	
	latestVersion = versionChunk()
	
	if versionToNumber(latestVersion) > versionToNumber(currentVersion) then
		require("../ui/notifier"):notify(frameworkSettings.newVersionMessage)
	end
end

return checkVersion
