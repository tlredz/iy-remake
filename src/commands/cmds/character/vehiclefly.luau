local flight = require("../../systems/flight")

local DEFAULT_SPEED = 100

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
				kind = "vehiclefly",
				platformStand = false,
				getSpeed = function()
					return self.privateEnv.vehicleFlySpeed or DEFAULT_SPEED
				end
			})
		end
	},
	{
		action = "vehicleflyspeed|vflyspeed|vflysp",
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
		action = "togglevfly",
		description = "Toggles vehicle fly",
		args = {
			kind = "number",
			name = "vehicle fly speed",
			optional = true
		},
		run = function(self, args)
			local garbage = self:getGarbage("fly")
			if garbage and garbage.kind == "vehiclefly" then
				self:run("unvehiclefly")
			else
				self:run("vehiclefly", args)
			end
		end
	},
	{
		action = "unvehiclefly|unvfly|novehiclefly|novfly",
		description = "Disables vehicle fly",
		run = function(self)
			flight.stop(self, "fly")
		end
	}
}
