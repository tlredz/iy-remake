return {
	{
		action = "norender",
		description = "Disable 3d Rendering to decrease the amount of CPU the client uses",
		run = function(self)
			self.runService:Set3dRenderingEnabled(false)
		end
	},
	{
		action = "render",
		description = "Enable 3d Rendering",
		run = function(self)
			self.runService:Set3dRenderingEnabled(true)
		end
	}
}