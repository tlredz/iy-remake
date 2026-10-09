local loggerConfigs = require("../framework/config/logger")
local logText = loggerConfigs.logText

local logger = {}

function logger:isEnabled()
	return loggerConfigs.isEnabled
end

function logger:enable()
	loggerConfigs.isEnabled = true
end

function logger:disable()
	loggerConfigs.isEnabled = false
end

function logger:log(message, ...)
	if not self:isEnabled() then return end
	print(logText:format(tostring(message)), ...)
end

function logger:debug(message, ...)
	if not self:isEnabled() then return end
	print(logText:format(tostring(message)), ...)
end

function logger:warn(message)
	if not self:isEnabled() then return end
	(warn or print)(logText:format(tostring(message)))
end

function logger:error(message, level)
	error(logText:format(tostring(message)), level)
end

function logger:fail(message)
	self:error("failed to load: " .. message)
end

function logger:assert(value, message)
	if not value then
		self:error(message)
		return
	end
	return value 
end

function logger:expect(value, expected, message)
	if not table.find(expected, typeof(value)) then
		self:error((message or "") .. ` expected '{table.concat(expected, ", ")}'. got '{typeof(value)}'.`)
	end
end

return logger