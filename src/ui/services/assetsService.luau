-- src/ui/services/assetsService.luau
-- The images of the icons. An icon has a name (ui/themes/icons/interface), and its image comes from a file, in this order:
--   1. the legacy file of the icon (assets/legacy, the icons of the original IY), when the Use legacy icons box is on
--      and the icon has one (ui/themes/icons/legacy)
--   2. the new file of the icon (assets/remake)
-- Each file is looked for in three places, in this order:
--   a. the copy kept for this version (the IY folder, see storage/downloads)
--   b. the copy built into the code (ui/themes/icons/raw, made by build.bash), so no request is needed
--   c. the repo, asked for only when the copy built into the code does not have the file
-- A file that is found is kept for this version, and the executor turns it into an image (getcustomasset). When no file
-- gives one, the Roblox asset id of the icon table is used, or nothing when the icon has none yet.
-- The icons on screen are drawn again when the choice changes (refresh: the Use legacy icons box calls it).

local executorEnv = require("../../framework/environment/executor")
local frameworkSettings = require("../../framework/settings")
local settingsData = require("../../storage/data/settings")
local fileSystem = require("../../storage/fileSystem")
local downloads = require("../../storage/downloads")
local fetchService = require("../../framework/services/fetchService")
local base64 = require("../../utils/base64")
local logger = require("../../utils/logger")

local assets = require("../themes/icons/interface")
local legacyFiles = require("../themes/icons/legacy")
local builtFiles = require("../themes/icons/raw")

local IMAGE_PATH = frameworkSettings.storage.imagePath
local LEGACY_KEY = frameworkSettings.ui.legacyIconsKey

local assetsService = {}

-- every object that shows an icon -> the name of that icon. Weak keys: an object that is gone is forgotten
local shown = setmetatable({}, { __mode = "k" })
-- the image of each icon for each choice ("legacy|name" or "new|name"), once it is known
local images = {}
-- the choices being loaded right now, so each one is loaded once
local loading = {}

-- true when the legacy box is on and the icon has a legacy file
local function usesLegacy(iconName: string): boolean
	return settingsData:getValue(LEGACY_KEY) == true and legacyFiles[iconName] ~= nil
end

local function choiceOf(iconName: string, legacy: boolean): string
	return `{if legacy then "legacy" else "new"}|{iconName}`
end

-- the image of an icon from the Roblox asset id of the icon table: nothing when the icon has no id yet
local function fallbackImage(iconName: string): string
	local assetId = assets[iconName]

	if type(assetId) == "number" then
		return `rbxassetid://{assetId}`
	end

	return assetId or ""
end

-- the custom asset of a file (folder, name), or nil when no copy of it can be had
local function fileImage(folder: string, name: string): string?
	local fileName = `{folder}/{name}.png`
	local keptPath = downloads.path("assets", fileName)

	if downloads.has("assets", fileName) then
		return fileSystem:getCustomAsset(keptPath)
	end

	local built = builtFiles[folder]
	local bytes = if built then built[name] else nil

	if bytes ~= nil then
		bytes = base64.decode(bytes)
	else
		bytes = fetchService.fetch(IMAGE_PATH:format(folder, name))
	end

	if bytes == nil then
		return nil
	end

	downloads.write("assets", fileName, bytes)
	logger:log(`created a file to asset: '{keptPath}'`)

	return fileSystem:getCustomAsset(keptPath)
end

-- the image an icon gets for a choice: the first file that gives one, or the fallback
local function resolveImage(iconName: string, legacy: boolean): string
	if type(executorEnv.getcustomasset) ~= "function" then
		return fallbackImage(iconName)
	end

	if legacy then
		local image = fileImage("legacy", legacyFiles[iconName])
		if image then
			return image
		end
	end

	return fileImage("remake", iconName) or fallbackImage(iconName)
end

-- the image of an icon as it is now, or nil while it is being loaded (it is set on every object of the icon when ready)
local function imageFor(iconName: string): string?
	-- without getcustomasset there is no file to read: the icon is its Roblox asset id, at once
	if type(executorEnv.getcustomasset) ~= "function" then
		return fallbackImage(iconName)
	end

	local legacy = usesLegacy(iconName)
	local choice = choiceOf(iconName, legacy)

	local known = images[choice]
	if known ~= nil then
		return known
	end

	if loading[choice] then
		return nil
	end

	loading[choice] = true

	task.defer(function()
		images[choice] = resolveImage(iconName, legacy)
		loading[choice] = nil

		for object, name in shown do
			if choiceOf(name, usesLegacy(name)) == choice then
				object.Image = images[choice]
			end
		end
	end)

	return nil
end

-- sets the image of an icon on an object, and keeps the object so it is drawn again when the choice changes
function assetsService:loadImage(object: any, iconName: string)
	logger:assert(assets[iconName] ~= nil, `invalid asset name: {iconName}`)

	shown[object] = iconName
	object.Image = imageFor(iconName) or ""
end

-- draws every icon on screen again, for the choice in use now (the Use legacy icons box calls this)
function assetsService:refresh()
	for object, iconName in shown do
		object.Image = imageFor(iconName) or ""
	end
end

return assetsService
