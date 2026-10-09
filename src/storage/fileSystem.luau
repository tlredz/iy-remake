local executorEnv = require("../framework/environment/executor")

local encryptor = require("../utils/encryptor")
local logger = require("../utils/logger")
local json = require("../utils/json")

local storageConfig = require("../framework/config/storage")

local privateFolder = storageConfig.privateFolder
local encryptKey = storageConfig.encryptKey

encryptor = encryptor.new(encryptKey)

if privateFolder:sub(#privateFolder) == "/" then
	privateFolder = privateFolder:sub(1, -2)
end

local fileSystem = {}
fileSystem.__index = fileSystem

local function isfile(filePath: string): boolean
	local success, exist = pcall(executorEnv.isfile, filePath)
	
	if success and type(exist) == "boolean" then
		return exist
	end
	
	return false
end

local function isfolder(folderPath: string): boolean
	local success, exist = pcall(executorEnv.isfolder, folderPath)
	
	if success and type(exist) == "boolean" then
		return exist
	end
	
	return false
end

local function readfile(filePath: string): string
	if not isfile(filePath) then
		logger:log(`the file '{filePath}' don't exist, skipped!`)
		return ""
	end
	
	local success, content = pcall(executorEnv.readfile, filePath)
	
	if not success then
		logger:warn(`failed to read file '{filePath}':\n\t{content}`)
		content = nil
	end
	
	if type(content) ~= "string" then
		content = ""
	end
	
	return content
end

local function makefolder(folderPath: string): (nil)
	local split = folderPath:split("/")
	local paths = {}
	
	for _, name in split do
		table.insert(paths, name)
		
		local folderPath = table.concat(paths, "/")
		if isfolder(folderPath) then continue end
		
		local success, response = pcall(executorEnv.makefolder, folderPath)
		
		if not success then
			logger:warn(`failed to create a folder '{folderPath}':\n\t{response}`)
		end
	end
end

local function writefile(filePath: string, content: string): (nil)
	local success, response = pcall(executorEnv.writefile, filePath, content)
	
	if success then
		logger:log(`successfully writed the file '{filePath}'!`)
	else
		logger:warn(`failed to write file '{filePath}':\n\t{response}`)
	end
end

local function getcustomasset(assetPath)
	local success, result = pcall(executorEnv.getcustomasset, assetPath)
	
	if not (success and type(result) == "string") then
		logger:warn(`failed to get custom asset '{assetPath}':\n\t{result}`)
		return
	end
	
	return result
end

local function getFolderPath(filePath: string): string
	local split = string.split(filePath, "/")
	local fileName = table.remove(split)
	
	return table.concat(split, "/"), fileName
end

function fileSystem:getRealPath(filePath)
	if filePath:sub(1, 1) ~= "/" then
		filePath = "/" .. filePath
	end
	
	filePath = privateFolder .. filePath
	return filePath
end

function fileSystem:deep(path)
	local deep = self.object
	local split = path:split(".")
	local key = table.remove(split)
	
	for _, subKey in split do
		local subValue = deep[subKey]
		if type(subValue) ~= "table" then subValue = {} end
		deep[subKey] = subValue
		deep = subValue
	end
	
	return deep, key
end

function fileSystem:setValue(flag, value)
	local tab, key = self:deep(flag)
	tab[key] = value
end

function fileSystem:getValue(flag)
	local tab, key = self:deep(flag)
	return tab[key]
end

function fileSystem:hasValue(flag)
	return self:getValue(flag) ~= nil
end

function fileSystem:increment(flag, value)
	return self:setValue(flag, (self:getValue(flag) or 0) + value)
end

function fileSystem:exist(filePath)
	filePath = self:getRealPath(filePath)
	return isfile(filePath)
end

function fileSystem:writeFile(filePath, raw)
	if self.filePath ~= nil then
		filePath, raw = self.filePath, filePath
	else
		filePath = self:getRealPath(filePath)
	end
	
	writefile(filePath, raw)
end

function fileSystem:register(dataName, fallback)
    local value = self:getValue(dataName)
    
    if typeof(value) ~= typeof(fallback) then
        value = fallback
        self:setValue(dataName, value)
    end
    
    return value
end

function fileSystem:add(dataName, value)
    local data = self:getValue(dataName)
    logger:expect(data, {"table"}, "'userData:add' #1")
    
    if not table.find(data, value) then
        table.insert(data, value)
    end
end

function fileSystem:save()
	if self.isSaving then return end
	
	self.isSaving = true
	self.lastSave = tick()
	
	task.delay(1, function()
		local content = json.encode(self.object, self.filePath)
		
		if self.encryptData then
			content = encryptor:encrypt(content)
		end
		
		self.isSaving = false
		self:writeFile(content)
	end)
end

function fileSystem:getCustomAsset(assetPath)
	assetPath = self:getRealPath(assetPath)
	return getcustomasset(assetPath)
end

function fileSystem:getData()
	return table.clone(self.object)
end

function fileSystem.new(filePath, config)
	logger:expect(filePath, {"string"}, "'fileSystem.new' #1")
	logger:expect(config, {"table", "nil"}, "'fileSystem.new' #2")
	
	if filePath:sub(-5, -1) ~= ".json" then
		filePath ..= ".json"
	end
	
	local self = setmetatable({
		object = {},
		lastSave = 0,
		isSaving = false,
		
		encryptData = config and config.encrypt
	}, fileSystem)
	
	local filePath = self:getRealPath(filePath)
	local folderPath = getFolderPath(filePath)
	
	self.filePath = filePath
	self.folderPath = folderPath
	
	if #folderPath > 0 then
		makefolder(folderPath)
	end
	
	local content = readfile(filePath)
	
	if #content > 0 then
		if self.encryptData then
			content = encryptor:decrypt(content)
		end
		
		local decoded = json.decode(content)
		
		if type(decoded) ~= "table" then
			logger:warn(`the json content has been returned a unexpected value '{filePath}'`)
			return self
		end
		
		self.object = decoded
	end
	
	return self
end

return fileSystem