--!strict
local executorEnv = require("../config/executorEnv")
local assetsPath = require("../config/iy").assetsPath

local fileSystem = require("../storage/fileSystem")
local fetchService = require("../services/fetchService")
local assets = require("../storage/assets")
local logger = require("../utils/logger")

local LOADED_ASSETS = {}
local LOADING_ASSETS = {}

local getcustomasset = executorEnv.getcustomasset

local assetsController = {}

function assetsController:newCustomAsset(assetName, assetPath)
	logger:assert(not LOADED_ASSETS[assetName], "asset is loaded")
	
	local customAssetId = fileSystem:getCustomAsset(assetPath)
	
	if customAssetId == nil then
		customAssetId = assets[assetName]
		LOADED_ASSETS[assetName] = customAssetId
		return customAssetId
	end
	
	logger:log(`new custom asset to '{assetPath}': '{customAssetId}'`)
	return customAssetId
end

function assetsController:get(assetName)
	if LOADED_ASSETS[assetName] then
		return LOADED_ASSETS[assetName]
	end
	
	if type(getcustomasset) ~= "function" then
		return assets[assetName]
	end
	
	local assetPath = assetsPath:format(assetName)
	logger:log(`loading asset: '{assetPath}'`)
	
	if fileSystem:exist(assetPath) then
		return self:newCustomAsset(assetName, assetPath)
	end
	
	local imageRaw = fetchService.fetch(assetPath)
	
	if imageRaw == nil then
		assetid = assets[assetName]
		LOADED_ASSETS[assetName] = assetid
		return assetid
	end
	
	fileSystem:writeFile(assetPath, imageRaw)
	logger:log(`created a file to asset: '{assetPath}'`)
	
	return self:newCustomAsset(assetName, assetPath)
end

function assetsController:loadImage(object, assetName)
	logger:assert(assets[assetName], "invalid asset name")
	
	local assetid = LOADED_ASSETS[assetName]
	if assetid ~= nil then object.Image = assetid return end
	
	object.Image = ""
	
	if LOADING_ASSETS[assetName] then
		table.insert(LOADING_ASSETS[assetName], object)
		return
	end
	
	LOADING_ASSETS[assetName] = {object}
	
	task.defer(function()
		local fetchedAssetId = self:get(assetName)
		if not fetchedAssetId then return end
		
		for _, object in LOADING_ASSETS[assetName] do
			object.Image = fetchedAssetId
		end
		
		LOADING_ASSETS[assetName] = nil
	end)
end

return assetsController