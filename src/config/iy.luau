local tools = require("../utils/tools")
local gitCfg = require("./github")

return {
	isRemakeVersion = true,
	version = require("../../version"),
	
	displayName = "Infinite Yield RV",
	newVersionMessage = "You're using an old version of Infinite Yield RV",
	
	scale = {
		minScale = 0.8,
		maxScale = 2.0,
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
	},
	
	links = {
		discord = "https://discord.gg/78ZuWSq",
		github = `https://github.com/{gitCfg.owner}/{gitCfg.repository}`
	},
	
	privateFolder = "infiniteYield",
	assetsPath = "assets/%s.png"
}