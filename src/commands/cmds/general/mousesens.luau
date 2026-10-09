return {
	action = "mousesensitivity|ms",
	description = "Sets your mouse delta sensitivity",
	args = { kind = "number", name = "sensitivity" },
	run = function(self, args)
		self.robloxServices.UserInputService.MouseDeltaSensitivity = args:nextValue()
	end
}
