-- /src/commands/cmds/bypass/testbypass.luau

local objectDecoy = require("../../systems/objectDecoy")

return {
	{
		client = true,
		action = "testbypass",
		description = "Tests which hook method works in this executor (hookmetamethod, or getrawmetatable as fallback)",
		run = function(self)
			objectDecoy.runTest(self)
		end
	}
}
