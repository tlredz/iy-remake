-- Marks commands as tested. They show in the "deprecated" color (test only).
local function setTested(self, name: string, tested: boolean)
	local command = self:getCommandData(name)
	if not command then
		self:notify("Tested", name .. " is not a valid command")
		return
	end

	local testedCmds = require("../../../storage/data/testedCmds")
	testedCmds:setValue(command.name, if tested then true else nil)
	testedCmds:save()

	self:notify("Tested", command.name .. (tested and " marked as tested" or " is no longer marked"))
end

return {
	{
		action = "marktested|mtested",
		description = "Marks a command as tested (grey, test only)",
		args = { kind = "string", name = "command name" },
		run = function(self, args)
			setTested(self, args:nextValue(), true)
		end
	},
	{
		action = "unmarktested|unmtested",
		description = "Removes the tested mark from a command",
		args = { kind = "string", name = "command name" },
		run = function(self, args)
			setTested(self, args:nextValue(), false)
		end
	}
}
