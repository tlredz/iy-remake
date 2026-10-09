local function setDensity(self, density: number)
	local character = self.localPlayer.Character
	if not character then return end
	
	for _, part in character:GetDescendants() do
		if part:IsA("BasePart") then
			part.CustomPhysicalProperties = PhysicalProperties.new(density, 0.3, 0.5)
		end
	end
end

return {
	{
		action = "strengthen",
		description = "Makes your body parts heavier (default is 100)",
		args = { kind = "number", name = "density", optional = true },
		run = function(self, args)
			setDensity(self, args:nextValue() or 100)
		end
	},
	{
		action = "weaken",
		description = "Makes your body parts lighter (default is 0)",
		args = { kind = "number", name = "density", optional = true },
		run = function(self, args)
			setDensity(self, -(args:nextValue() or 0))
		end
	},
	{
		action = "unweaken|unstrengthen",
		description = "Resets your body parts' density",
		run = function(self)
			setDensity(self, 0.7)
		end
	}
}
