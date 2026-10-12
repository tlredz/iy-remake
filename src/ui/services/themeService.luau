local themes = require("../themes")

local logger = require("../../utils/logger")
local tools = require("../../utils/tools")

local themeService = {
	objects = {},
	selectedTheme = nil
}

-- a theme can be used once it has its Colors and Font (ui/init falls back to the default theme without them)
function themeService:isUsable(theme): boolean
	return theme ~= nil and theme.Colors ~= nil and theme.Font ~= nil
end

-- every theme, sorted by name: { key, name, theme, usable }. key is the name that selectTheme takes
function themeService:getThemes()
	local list = {}

	for key, theme in themes do
		table.insert(list, {
			key = key,
			name = theme.DisplayName,
			theme = theme,
			usable = self:isUsable(theme),
		})
	end

	table.sort(list, function(a, b)
		return a.name < b.name
	end)

	return list
end

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

-- stops theming an object that is going away (a row rebuilt by a settings page)
function themeService:removeObject(object: Instance): (nil)
	self.objects[object] = nil
end

function themeService:init(config)
	logger:expect(config, {"table"}, "'themeService:init' #1")
	
	if config.theme ~= nil then
		self:selectTheme(config.theme)
	end
end

return themeService