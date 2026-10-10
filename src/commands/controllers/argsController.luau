local playerService = require("../../framework/services/playerService")
local waypointsData = require("../../storage/data/waypoints")
local logger = require("../../utils/logger")
local tools = require("../../utils/tools")

--[[local commandProperties = require("../../framework/config/commandProperties")
local PROPERTIES_KEY = "$"]]

local argsController = {}

local function newWarn(message)
	return {
		success = false,
		message = message
	}
end

local function validateString(text)
	return {
		success = true,
		value = text,
		color = "string"
	}
end

local function validateBoolean(text)
	local booleans = {"true", "false", "yes", "no", "enabled", "disabled"}
	local found = table.find(booleans, text)
	
	return {
		success = found ~= nil,
		value = found and (found % 2) == 1,
		display = text,
		options = {"false", "true"},
		message = " - invalid boolean",
		color = "boolean"
	}
end

local validators = {
	["className"] = true,
	["player"] = true,
	["string"] = validateString,
	["text"] = validateString,
	["boolean"] = validateBoolean,
}

function validators.number(text, arg)
	local number = tonumber(text)
	local result = {
		value = number,
		success = false,
		display = `<b>{number}</b>`
	}
	
	if number == nil then
		result.message = " - invalid number"
		return result
	end
	
	if arg.clamp then
		arg.min, arg.max = arg.clamp[1], arg.clamp[2]
	end
	
	if arg.min and number < arg.min then
		result.message = ` - the <b>MIN</b> is <b>{arg.min}</b>`
		return result
	end
	
	if arg.max and number > arg.max then
		result.message = ` - the <b>MAX</b> is <b>{arg.max}</b>`
		return result
	end
	
	if arg.floor and math.floor(number) ~= number then
		result.message = ` - only floors`
		return result
	end
	
	if math.floor(number * 1e5) / 1e5 ~= number then
		result.message = ` - too big`
		return result
	end
	
	result.color = "number"
	result.success = true
	return result
end

function validators.waypoint(text)
	local waypoint = waypointsData:getValue(text)
	local waypoints = tools.unlookupify(waypointsData:getData())
	
	if #waypoints == 0 then
		return newWarn(" - no waypoints created")
	end
	
	return {
		success = waypoint ~= nil,
		options = waypoints,
		value = text,
		message = " - invalid waypoint"
	}
end

function validators.vector3(text)
	local split = text:split(",")
	
	if #split > 3 then
		return newWarn(" - too many args")
	end
	
	for key, str in split do
		if str == "" then str = "0" end
		local result = validators.number(str, {})
		if not result.success then return result end
		split[key] = result.value
	end
	
	if #split ~= 3 then
		return {
			success = false,
			comment = true,
			message = `: {({"X", "Y", "Z"})[#split + 1]}`
		}
	end
	
	local vector = Vector3.new(unpack(split))
	
	return {
		success = true,
		value = vector,
		display = `({vector})`,
		color = "others"
	}
end

function argsController:validate(argConfig, text)
	--[[if text:sub(1, #PROPERTIES_KEY) == PROPERTIES_KEY then
		return getDeep(text:sub(#PROPERTIES_KEY + 1, -1))
	end]]
	
	local validate = validators[argConfig.kind]
	
	if validate == true then
		return {
			success = true,
			value = text,
			display = text
		}
	end
	
	if type(validate) == "function" then
		return validate(text, argConfig)
	end
	
	return newWarn(` - missing parser {argConfig.kind}`)
end

return argsController