return {
	action = "setfpscap|fpscap|maxfps",
	description = "limits your FPS",
	args = {
		kind = "number",
		options = {"30", "60", "120", "240"},
		min = 1,
		max = 10000
	},
	run = function(self, args)
		local cap = args:nextValue()
		self.executorEnv.setfpscap(cap)
	end
}