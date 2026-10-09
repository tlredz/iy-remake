return {
	{
		client = true,
		action = "globalshadows|gshadows",
		description = "Enables global shadows",
		run = function(self)
			self.robloxServices.Lighting.GlobalShadows = true
		end
	},
	{
		client = true,
		action = "noglobalshadows|nogshadows",
		description = "Disables global shadows",
		run = function(self)
			self.robloxServices.Lighting.GlobalShadows = false
		end
	}
}
