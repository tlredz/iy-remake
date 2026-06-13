local themeService = require("../services/themeService")
local logger = require("../utils/logger")

local specialProperties = {}

function specialProperties.ThemeTag(object, value)
	if type(value) ~= "table" then
		logger:error("expected a 'table' when setting a theme tag")
		return
	end
	
	themeService:addObject(object, value)
end

return specialProperties