local scaleConfig = require("../../../framework/settings").ui.scale

return {
	action = "guiscale|uiscale",
	description = "Changes the size of the gui. [number] accepts decimals and whole numbers.",
	args = {
		kind = "number",
		clamp = {scaleConfig.minScale, scaleConfig.maxScale}
	},
	run = function(self, args)
		local scale = args:nextValue()
		self.infiniteYield:setScale(scale)
	end
}