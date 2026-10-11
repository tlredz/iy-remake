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
				kind = "fly",
				platformStand = true,
				getSpeed = function()
					return self.privateEnv.flySpeed or DEFAULT_SPEED
				end
			})
		end
	},
	{
		action = "flyspeed|flysp",
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
		action = "togglefly",
		description = "Toggles fly",
		args = {
			kind = "number",
			name = "fly speed",
			optional = true
		},
		run = function(self, args)
			local garbage = self:getGarbage("fly")
			if garbage and garbage.kind == "fly" then
				self:run("unfly")
			else
				self:run("fly", args)
			end
		end
	},
	{
		action = "unfly|nofly",
		description = "Disables fly",
		run = function(self)
			flight.stop(self, "fly")
		end
	}
}
