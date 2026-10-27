--!strict
-- src/ui/services/assetsService.luau

local executorEnv = require("../../framework/environment/executor")
local frameworkSettings = require("../../framework/settings")

local assetsPath = frameworkSettings.storage.imagePath

local fileSystem = require("../../storage/fileSystem")
local downloads = require("../../storage/downloads")
local fetchService = require("../../framework/services/fetchService")
local logger = require("../../utils/logger")

local assets = require("../themes/icons/interface") 

local LOADED_ASSETS = {}
local LOADING_ASSETS = {}

local getcustomasset = executorEnv.getcustomasset

local assetsService = {}

function assetsService:newCustomAsset(assetName: string, assetPath: string): string
	logger:assert(not LOADED_ASSETS[assetName], "asset is already loaded")
	
	local customAssetId = fileSystem:getCustomAsset(assetPath)
	
	if customAssetId == nil then
		customAssetId = assets[assetName]
		LOADED_ASSETS[assetName] = customAssetId
		return customAssetId
	end
	
	logger:log(`new custom asset to '{assetPath}': '{customAssetId}'`)
	return customAssetId
end

function assetsService:get(assetName: string): string
	-- if true then print("ICON FOR TEST:", assetName) return "rbxassetid://" ..assets[assetName] end
	if LOADED_ASSETS[assetName] then
		return LOADED_ASSETS[assetName]
	end
	
	if type(getcustomasset) ~= "function" then
		return assets[assetName]
	end
	
	local fileName = `{assetName}.png`
	local keptPath = downloads.path("assets", fileName)
	logger:log(`loading asset: '{keptPath}'`)
	
	if downloads.has("assets", fileName) then
		return self:newCustomAsset(assetName, keptPath)
	end
	
	local imageRaw = fetchService.fetch(assetsPath:format(assetName))
	
	if imageRaw == nil then
		local assetid = assets[assetName]
		assetid = if type(assetid) == "number" then `rbxassetid://{assetid}` else assetid
		
		LOADED_ASSETS[assetName] = assetid
		return assetid
	end
	
	downloads.write("assets", fileName, imageRaw)
	logger:log(`created a file to asset: '{keptPath}'`)
	
	return self:newCustomAsset(assetName, keptPath)
end

function assetsService:loadImage(object: any, assetName: string)
	logger:assert(assets[assetName], `invalid asset name: {assetName}`)
	
	local assetid = LOADED_ASSETS[assetName]
	if assetid ~= nil then 
		object.Image = assetid 
		return 
	end
	
	object.Image = ""
	
	if LOADING_ASSETS[assetName] then
		table.insert(LOADING_ASSETS[assetName], object)
		return
	end
	
	LOADING_ASSETS[assetName] = {object}
	
	task.defer(function()
		local fetchedAssetId = self:get(assetName)
		if not fetchedAssetId then return end
		
		for _, targetObject in LOADING_ASSETS[assetName] do
			targetObject.Image = fetchedAssetId
		end
		
		LOADING_ASSETS[assetName] = nil
	end)
end

return assetsService