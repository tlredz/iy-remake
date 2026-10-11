return {
	action = "setfpscap|fpscap|maxfps",
	description = "limits your FPS",
	args = {
		kind = "number",
		min = 1,
		max = 10000
	},
	run = function(self, args)
		local cap = args:nextValue()
		self.executorEnv.setfpscap(cap)
	end
}