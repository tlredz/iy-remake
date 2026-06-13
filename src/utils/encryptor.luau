local logger = require("./logger")

local encryptor = {}
encryptor.__index = encryptor

function encryptor:encrypt(text)
	logger:expect(text, {"string"}, "'encryptor:encrypt' #1")
	local seed = self.encryptKey
	local buffer = {}
	
	for index = 1, #text do
		seed = (seed * 16807) % 2147483647
		table.insert(buffer, string.format("%02X", (text:byte(index) + seed % 256) % 256))
	end
	
	return table.concat(buffer)
end

function encryptor:decrypt(text, keys)
	logger:expect(text, {"string"}, "'encryptor:decrypt' #1")
	local seed = self.encryptKey
	local result = {}
	
	for index = 1, #text, 2 do
		local byte = tonumber(text:sub(index, index + 1), 16)
		seed = (seed * 16807) % 2147483647
		result[#result + 1] = string.char((byte - seed % 256 + 256) % 256)
	end
	
	return table.concat(result)
end

function encryptor.new(encryptKey)
	logger:expect(encryptKey, {"number"}, "'encryptor.new' #1")
	
	return setmetatable({
		encryptKey = encryptKey
	}, encryptor)
end

return encryptor