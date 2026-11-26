return {
	{
		client = true,
		action = "record|rec",
		description = "Starts Roblox recorder",
		run = function(self)
			self.coreGui:ToggleRecording()
		end
	},
	{
		client = true,
		action = "screenshot|scrnshot",
		description = "Takes a screenshot",
		run = function(self)
			self.coreGui:TakeScreenshot()
		end
	},
	{
		client = true,
		action = "togglefullscreen|togglefs",
		description = "Toggles fullscreen",
		run = function(self)
			self.guiService:ToggleFullscreen()
		end
	}
}