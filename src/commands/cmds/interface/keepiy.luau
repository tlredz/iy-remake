-- /src/commands/cmds/interface/keepiy.luau

local keepiy = require("../../systems/keepiy")

return {
	{
		client = true,
		action = "keepiy",
		description = "Runs IY again after you teleport, and keeps the interface open",
		run = function(self)
			keepiy.enable(self)
		end
	},
	{
		client = true,
		action = "unkeepiy",
		description = "Turns keepiy off: IY stops running after you teleport",
		run = function(self)
			keepiy.disable(self)
		end
	},
	{
		client = true,
		action = "togglekeepiy",
		description = "Toggles keepiy",
		run = function(self)
			keepiy.toggle(self)
		end
	}
}
