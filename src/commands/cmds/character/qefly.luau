return {
	action = "qefly",
	description = "Enables or disables the Q and E hotkeys for fly",
	args = {
		kind = "boolean",
		optional = true
	},
	run = function(self, args)
		-- Enabled unless "false" is given, same as IY
		self.privateEnv.qeFly = args:nextValue() ~= false
	end
}
