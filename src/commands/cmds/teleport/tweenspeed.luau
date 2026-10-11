return {
	action = "tweenspeed|tspeed",
	description = "Sets how fast the tween commands move you, in studs per second (default is 100)",
	args = { kind = "number", name = "tween speed", optional = true },
	run = function(self, args)
		-- No value resets it to the playerService default
		self.privateEnv.tweenSpeed = args:nextValue()
	end
}
