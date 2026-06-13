return {
	action = "console",
	description = "Opens the Roblox console",
	run = function(self)
		self.starterGui:SetCore("DevConsoleVisible", true)
	end
}