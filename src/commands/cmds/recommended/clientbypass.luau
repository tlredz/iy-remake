-- /src/commands/cmds/recommended/clientbypass.luau

local objectDecoy = require("../../systems/objectDecoy")

return {
	{
		action = "clientbypass",
		description = "Hides the objects that fly, vfly and float create from the game's scripts",
		run = function(self)
			objectDecoy.enable(self)
		end
	},
	{
		action = "unclientbypass",
		description = "Turns the client bypass off, so the objects show their real values again",
		run = function(self)
			objectDecoy.disable(self)
		end
	}
}
