local themes = require("../themes")
local themeConfig = require("../../framework/config/ui/themes")
local settingsData = require("../../storage/data/settings")

local logger = require("../../utils/logger")
local tools = require("../../utils/tools")

-- The theme in use is a copy of the theme with the primary color the user picked for it (framework/config/ui/themes).
-- Each theme keeps its own pick, saved as themePrimary.<theme name>, so changing one theme does not change the others.
local themeService = {
	objects = {},
	selectedTheme = nil, -- the theme in use, with its primary color applied
	selectedKey = nil,   -- the name of the theme in use, as selectTheme takes it
}

local PRIMARY_PREFIX = "themePrimary."

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

-- the primary color options (framework/config/ui/themes), in the order they are shown
function themeService:getPrimaryOptions()
	return themeConfig.options
end

local function findOption(key: string)
	for _, option in themeConfig.options do
		if option.key == key then
			return option
		end
	end

	return nil
end

-- the option picked for a theme, or the default one when none was picked (or the saved one is gone)
function themeService:getPrimaryKey(themeName: string): string
	local saved = settingsData:getValue(PRIMARY_PREFIX .. themeName:lower())

	if type(saved) == "string" and findOption(saved) then
		return saved
	end

	return themeConfig.defaultKey
end

-- the color an option shows for a theme: the theme's own primary for the default option, its color otherwise
function themeService:getPrimaryColor(theme, primaryKey: string): Color3
	local option = findOption(primaryKey)

	if option and option.color then
		return option.color
	end

	return theme.Colors.Primary
end

-- a copy of the theme with the primary color of the option. The theme itself is never changed
local function withPrimary(theme, primaryKey: string)
	local option = findOption(primaryKey)

	if not option or option.color == nil then
		return theme
	end

	local colors = table.clone(theme.Colors)
	colors.Primary = option.color
	colors.OnPrimary = option.color:Lerp(Color3.new(0, 0, 0), themeConfig.darken)

	local copy = table.clone(theme)
	copy.Colors = colors

	return copy
end

function themeService:selectTheme(themeName)
	logger:expect(themeName, {"string"}, "'themeService:selectTheme' #1")

	local key = themeName:lower()
	local theme = themes[key]

	if not theme then
		logger:error(`'{themeName}' isn't a valid theme`)
		return
	end

	self.selectedKey = key
	self.selectedTheme = if self:isUsable(theme) then withPrimary(theme, self:getPrimaryKey(key)) else theme
	self:updateObjects()

	return self
end

-- keeps the primary color picked for a theme. When that theme is the one in use, it is applied at once
function themeService:setPrimary(themeName: string, primaryKey: string)
	local key = themeName:lower()

	settingsData:setValue(PRIMARY_PREFIX .. key, primaryKey)
	settingsData:save()

	if self.selectedKey == key then
		self:selectTheme(key)
	end
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

-- a saved primary color that is not offered any more (pink and yellow were removed) goes back to the default, so the
-- saved setting and the picker show the same thing
function themeService:resetRemovedPrimaries()
	local changed = false

	for themeName in themes do
		local saved = settingsData:getValue(PRIMARY_PREFIX .. themeName)

		if saved ~= nil and not (type(saved) == "string" and findOption(saved)) then
			settingsData:setValue(PRIMARY_PREFIX .. themeName, themeConfig.defaultKey)
			changed = true
		end
	end

	if changed then
		settingsData:save()
	end
end

function themeService:init(config)
	logger:expect(config, {"table"}, "'themeService:init' #1")

	self:resetRemovedPrimaries()

	if config.theme ~= nil then
		self:selectTheme(config.theme)
	end
end

return themeService
