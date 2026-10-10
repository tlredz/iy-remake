local flight = require("../../systems/flight")

local DEFAULT_SPEED = 20

return {
	{
		action = "vehiclefly|vfly",
		description = "Makes you fly in a vehicle",
		args = {
			kind = "number",
			name = "vehicle fly speed",
			optional = true
		},
		run = function(self, args)
			local speed = args:nextValue()
			if speed then
				self.privateEnv.vehicleFlySpeed = speed
			end

			-- Same as IY: no PlatformStand, so the seat is not disturbed
			flight.start(self, {
				garbageName = "fly",
				platformStand = false,
				getSpeed = function()
					return self.privateEnv.vehicleFlySpeed or DEFAULT_SPEED
				end
			})
		end
	},
	{
		action = "vehicleflyspeed|vflyspeed",
		description = "Set vehicle fly speed",
		args = {
			kind = "number",
			name = "vehicle fly speed"
		},
		run = function(self, args)
			self.privateEnv.vehicleFlySpeed = args:nextValue() or DEFAULT_SPEED
		end
	},
	{
		action = "unvehiclefly|unvfly",
		description = "Disables vehicle fly",
		run = function(self)
			flight.stop(self, "fly")
		end
	}
}
