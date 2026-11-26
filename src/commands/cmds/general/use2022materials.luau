return {
	{
		client = true,
		action = "use2022materials|2022materials",
		description = "Enables 2022 material textures",
		run = function(self)
			self.rbxServices.MaterialService.Use2022Materials = true
		end
	},
	{
		client = true,
		action = "unuse2022materials|un2022materials",
		description = "Disables 2022 material textures",
		run = function(self)
			self.rbxServices.MaterialService.Use2022Materials = false
		end
	}
}