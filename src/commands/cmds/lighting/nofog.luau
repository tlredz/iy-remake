return {
	client = true,
	action = "nofog",
	description = "Removes fog",
	run = function(self)
		local lighting = self.robloxServices.Lighting
		lighting.FogEnd = 100000
		
		for _, object in lighting:GetDescendants() do
			if object:IsA("Atmosphere") then
				object:Destroy()
			end
		end
	end
}
