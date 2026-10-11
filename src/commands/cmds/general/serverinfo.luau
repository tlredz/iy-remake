return {
	action = "serverinfo|info|sinfo",
	description = "Gives you info about the server",
	run = function(self)
		self.infiniteYield:createInfoMenu()
	end
}