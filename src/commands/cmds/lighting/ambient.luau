return {
	client = true,
	action = "ambient",
	description = "Changes ambient",
	args = { kind = "color3" },
	run = function(self, args)
		local color = args:nextValue()
		local lighting = self.robloxServices.Lighting
		
		lighting.Ambient = color
		lighting.OutdoorAmbient = color
	end
}
