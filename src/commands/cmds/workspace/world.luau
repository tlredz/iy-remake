local DEFAULT_GRAVITY = workspace.Gravity
local DEFAULT_DESTROY_HEIGHT = -500

return {
	{
		action = "gravity|grav",
		description = "Sets the workspace gravity (no value resets it)",
		args = { kind = "number", name = "gravity", optional = true },
		run = function(self, args)
			workspace.Gravity = args:nextValue() or DEFAULT_GRAVITY
		end
	},
	{
		action = "destroyheight|dh",
		description = "Sets the height where fallen parts get destroyed (default is -500)",
		args = { kind = "number", name = "height", optional = true },
		run = function(self, args)
			workspace.FallenPartsDestroyHeight = args:nextValue() or DEFAULT_DESTROY_HEIGHT
		end
	}
}
