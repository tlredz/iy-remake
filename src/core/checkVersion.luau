task.spawn(function()
	local fetchService = require("../services/fetchService")
	local iyConfig = require("../config/iy")
	local tools = require("../utils/tools")
	
	local versionToNumber = tools.versionToNumber
	local currentVersion = iyConfig.version
	
	local latestVersion = fetchService.fetch("/version.lua")
	if latestVersion == nil then return end
	
	local versionChunk = loadstring(latestVersion)
	if versionChunk == nil then return end
	
	latestVersion = versionChunk()
	
	if versionToNumber(latestVersion) > versionToNumber(currentVersion) then
		require("../ui/notifier"):notify(iyConfig.newVersionMessage)
	end
end)