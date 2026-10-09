return {
	action = "serverinfo|info",
	description = "Gives you info about the server",
	run = function(self)
		self.infiniteYield:createInfoMenu()
	end
}