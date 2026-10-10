local flight = require("../../systems/flight")

local DEFAULT_SPEED = 20

return {
	{
		action = "fly",
		description = "Makes you fly",
		args = {
			kind = "number",
			name = "fly speed",
			optional = true
		},
		run = function(self, args)
			local speed = args:nextValue()
			if speed then
				self.privateEnv.flySpeed = speed
			end

			flight.start(self, {
				garbageName = "fly",
				platformStand = true,
				getSpeed = function()
					return self.privateEnv.flySpeed or DEFAULT_SPEED
				end
			})
		end
	},
	{
		action = "flyspeed",
		description = "Set fly speed (default is 20)",
		args = {
			kind = "number",
			name = "fly speed"
		},
		run = function(self, args)
			self.privateEnv.flySpeed = args:nextValue() or DEFAULT_SPEED
		end
	},
	{
		action = "unfly",
		description = "Disables fly",
		run = function(self)
			flight.stop(self, "fly")
		end
	}
}
