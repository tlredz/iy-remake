local themeConfig = require("../config/theme")
local logger = require("../utils/logger")
local tools = require("../utils/tools")

local themes = require("../themes/list")

local defaultTheme = themeConfig.defaultTheme

local themeService = {
	objects = {},
	selectedTheme = nil
}

function themeService:selectTheme(themeName)
	logger:expect(themeName, {"string"}, "'themeService:selectTheme' #1")
	
	local theme = themes[themeName:lower()]
	
	if not theme then
		logger:error(`'{themeName}' isn't a valid theme`)
		return
	end
	
	if theme ~= self.selectedTheme then
		self.selectedTheme = theme
		self:updateObjects()
	end
	
	return self
end

function themeService:updateObject(object: Instance): (nil)
	-- print("updating object", object)
	self:updateObjectProperties(object, self.objects[object])
end

function themeService:updateObjectProperties(
	object: Instance,
	properties: { [string]: any }
): (nil)
	for property, value in properties do
		object[property] = tools.getDeep(self.selectedTheme, value)
	end
end

function themeService:updateObjects()
	for object, _ in self.objects do
		self:updateObject(object)
	end
end

function themeService:addObject(object: Instance, themeTag: { [string]: string? }): (nil)
	self.objects[object] = themeTag
	self:updateObject(object)
	-- print("new object", object)
end

return themeService:selectTheme(defaultTheme)