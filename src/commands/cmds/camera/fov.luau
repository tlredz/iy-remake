return {
	action = "fov",
	description = "Adjusts field of view (default is 70)",
	args = { kind = "number", default = 70 },
	run = function(self, args)
		local fov = math.abs(args:nextValue())
		workspace.CurrentCamera.FieldOfView = fov
	end
}