local specialProperties = require("../systems/specialProperties")
local logger = require("../utils/logger")

local createService = {}

function createService.setProperties(object, properties)
	for property, value in properties do
		if specialProperties[property] then
			specialProperties[property](object, value)
			continue
		end
		
		-- print(property, value)
		if type(property) == "number" and typeof(value) == "Instance" then
			value.Parent = object
			continue
		end
		
		object[property] = value
	end
	return object
end

function createService.setup(object, ...)
	for _, value in {...} do
		local valueType = typeof(value)
		
		if valueType == "table" then
			createService.setProperties(object, value)
		else
			local property = if valueType == "string" then "Name" else "Parent"
			object[property] = value
		end
	end
	return object
end

function createService.new(className, ...)
	local object = Instance.new(className)
	return createService.setup(object, ...)
end

return createService