local logger = require("../../../utils/logger")

return {
	action = "debug",
	description = "Turns the debug logger on or off (default is on)",
	args = { kind = "boolean", name = "enabled", optional = true },
	run = function(self, args)
		local enabled = args:nextValue()
		if enabled == nil then
			enabled = true
		end
		
		if enabled then
			logger:enable()
		else
			logger:disable()
		end
		
		self:notify("debug", tostring(enabled))
	end
}
