-- src/ui/services/createService.luau

local services = require("../../framework/services")
local logger = require("../../utils/logger")

local specialProps = services.specialProps
local themeService = require("./themeService")

function specialProps.ThemeTag(object: Instance, value: any): (nil)
	if type(value) ~= "table" then
		logger:error("expected a 'table' when setting a theme tag")
		return
	end
	
	themeService:addObject(object, value)
end

return require("../../framework/services/createService")