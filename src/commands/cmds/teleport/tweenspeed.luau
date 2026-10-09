return {
	action = "tweenspeed|tspeed",
	description = "Sets how fast all tween commands go (default is 1)",
	args = { kind = "number", name = "tween speed", optional = true },
	run = function(self, args)
		self.privateEnv.tweenSpeed = args:nextValue() or 1
	end
}
