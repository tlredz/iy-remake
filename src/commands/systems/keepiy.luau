-- /src/commands/systems/keepiy.luau

local executorEnv = require("../../framework/environment/executor")
local connectionService = require("../../framework/services/connectionService")
local robloxServices = require("../../framework/services/rbxServices")
local fetchService = require("../../framework/services/fetchService")
local keepiyConfig = require("../../framework/config/commands/keepiy")
local settingsData = require("../../storage/data/settings")
local logger = require("../../utils/logger")

local keepiy = {}

local started = false
local queued = false

local function isEnabled()
	return settingsData:getValue(keepiyConfig.settingKey) == true
end

local function buildLoader()
	local url = fetchService.downloadUrl(keepiyConfig.bundleName)

	return table.concat({
		"local ok, source = pcall(readfile, \"" .. keepiyConfig.localBundlePath .. "\")",
		"if not ok or type(source) ~= \"string\" or source == \"\" then",
		"\tsource = game:HttpGet(\"" .. url .. "\")",
		"end",
		"loadstring(source)()",
	}, "\n")
end

local function onTeleport()
	if queued or not isEnabled() then return end

	local queueTeleport = executorEnv.queueteleport
	if queueTeleport == nil then return end

	queued = true

	local ok, err = pcall(queueTeleport, buildLoader())
	if not ok then
		queued = false
		logger:warn("keepiy: failed to queue the loader: " .. tostring(err))
	end
end

function keepiy.start()
	if started then return end
	started = true

	connectionService:Connect(robloxServices.Players.LocalPlayer.OnTeleport, onTeleport)
end

function keepiy.enable(cmd)
	if not cmd:expectExploit("queueteleport") then return end

	cmd.infiniteYield:setKeepIY(true)
	cmd:notify("Keepiy", "on: IY runs again after you teleport, and the interface stays open")
end

function keepiy.disable(cmd)
	cmd.infiniteYield:setKeepIY(false)
	cmd:notify("Keepiy", "off: IY will not run after the next teleport")
end

function keepiy.toggle(cmd)
	if isEnabled() then
		keepiy.disable(cmd)
	else
		keepiy.enable(cmd)
	end
end

return keepiy
