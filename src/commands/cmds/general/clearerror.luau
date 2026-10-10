return {
	action = "clearerror",
	description = "Clears the annoying box and blur when a game kicks you",
	run = function(self)
		self.guiService:ClearError()
	end
}
