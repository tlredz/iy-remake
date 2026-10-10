return {
	action = "fov",
	description = "Adjusts field of view (default is 70)",
	args = { kind = "number", default = 70 },
	run = function(self, args)
		local fov = math.clamp(math.abs(args:nextValue() or 70), 1, 120)
		workspace.CurrentCamera.FieldOfView = fov
	end
}
