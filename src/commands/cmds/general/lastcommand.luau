local argsManager = require("../../systems/argsManager")

return {
	action = "lastcommand|lastcmd",
	description = "Executes the previous command used",
	run = function(self)
		local last = self.privateEnv.lastCommand
		if not last then
			self:notify("Last Command", "no command was used yet")
			return
		end

		self:run(last.name, argsManager.new(last.args), true)
	end
}
