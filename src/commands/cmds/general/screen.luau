return {
	{
		action = "record|rec",
		description = "Starts Roblox recorder",
		run = function(self)
			self.coreGui:ToggleRecording()
		end
	},
	{
		action = "screenshot|scrnshot",
		description = "Takes a screenshot",
		run = function(self)
			self.coreGui:TakeScreenshot()
		end
	},
	{
		action = "togglefullscreen|togglefs",
		description = "Toggles fullscreen",
		run = function(self)
			self.guiService:ToggleFullscreen()
		end
	}
}