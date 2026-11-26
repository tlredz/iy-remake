-- /src/commands/cmds/recommended/testbypass.luau

local objectDecoy = require("../../systems/objectDecoy")

return {
	{
		action = "testbypass",
		description = "Tests which hook method works in this executor (hookmetamethod, or getrawmetatable as fallback)",
		run = function(self)
			objectDecoy.runTest(self)
		end
	}
}
