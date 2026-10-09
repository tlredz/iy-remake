local robloxServices = require("../framework/services/rbxServices")
local logger = require("./logger")

local httpService = robloxServices.HttpService
local jsonEncode = httpService.JSONEncode
local jsonDecode = httpService.JSONDecode

return {
	encode = function(raw, filePath)
		local success, content = pcall(jsonEncode, httpService, raw)
		
		if not success then
			logger:warn(`failed to encode json '{filePath or "unknown"}': {content}`)
			return nil
		end
		
		return content
	end,
	decode = function(content, filePath)
		local success, raw = pcall(jsonDecode, httpService, content)
		
		if not success then
			logger:warn(`failed to decode json '{filePath or "unknown"}': {raw}`)
			return nil
		end
		
		return raw
	end
}