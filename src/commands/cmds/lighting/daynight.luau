return {
	{
		client = true,
		action = "day",
		description = "Changes the time to day for the client",
		run = function(self)
			self.robloxServices.Lighting.ClockTime = 14
		end
	},
	{
		client = true,
		action = "night",
		description = "Changes the time to night for the client",
		run = function(self)
			self.robloxServices.Lighting.ClockTime = 0
		end
	}
}
