--!strict
-- src/framework/settings.luau
local settingsData = require("../storage/data/settings")

return {
	applicationName = "Infinite Yield RV",
	isRemakeVersion = true,
	version = require("../version"),
	newVersionMessage = "You're using an old version of Infinite Yield RV",
	
	theme = {
		defaultTheme = "dark",
		selectedTheme = settingsData:register("selectedTheme", "dark")
	},
	
	commands = {
		cmdsRank = {
			maxTimesUsed = 5,
			decreasePerUse = 0.25,
			increasePerUse = 1,
		}
	},
	
	notifications = {
		defaultTime = 10,
		defaultTitle = "Notification"
	},
	
	ui = {
		defaultTheme = "Dark",
		scale = {
			minScale = 0.8,
			maxScale = 2.0,
			current = settingsData:register("interface.uiScale", 1)
		},
		commands = {
			padding = 0,
			labelSize = 17,
			textSize = 14,
			placeholderText = ">_ command bar"
		},
		window = {
			windowSize = UDim2.fromOffset(250, 220),
			draggable = true
		}
	},
	
	links = require("./config/links"),
	storage = require("./config/storage"),
}