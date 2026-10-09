return {
	client = true,
	action = "brightness",
	description = "Changes the brightness lighting property",
	args = { kind = "number" },
	run = function(self, args)
		self.robloxServices.Lighting.Brightness = args:nextValue()
	end
}
