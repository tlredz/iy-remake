local logger = require("../utils/logger")
local tools = require("../utils/tools")

local iy = {}

function iy.checkVersion()
	local fetchService = require("../framework/services/fetchService")
	
	local versionToNumber = tools.versionToNumber
	local currentVersion = require("../version")
	
	local latestVersion = fetchService.fetch("/src/version.lua")
	if latestVersion == nil then return end
	
	local versionChunk = loadstring(latestVersion)
	if versionChunk == nil then return end
	
	latestVersion = versionChunk()
	
	if versionToNumber(latestVersion) > versionToNumber(currentVersion) then
		require("../ui/notifier"):notify(iyConfig.newVersionMessage)
	end
end

function iy:boot()
	logger:debug("cleaning before load")
	require("./cleanup"):init()
	
	local interface = require("../ui")
	interface:init()
	
	
end

return iy