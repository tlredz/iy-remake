return {
	action = "discord|support|help",
	description = "Invite to the Infinite Yield discord server.",
	run = function(self)
		self.executorEnv.setclipboard(self.config.links.infiniteYield)
	end
}