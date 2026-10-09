return {
	cliemt = true,
	action = "allowrejoin|allowrj",
	description = "Changes if antiteleport allows you to rejoin or not",
	args = { kind = "boolean" },
	run = function(self, argsargs)
		self.storage.settings:setValue("allowRejoin", args:nextValue())
	end
}