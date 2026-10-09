return {
	{
		action = "deleteinvisparts|deleteinvisibleparts|dip",
		description = "Deletes invisible collidable parts",
		run = function()
			for _, object in workspace:GetDescendants() do
				if object:IsA("BasePart") and object.Transparency == 1 and object.CanCollide then
					object:Destroy()
				end
			end
		end
	},
	{
		action = "removeterrain|rterrain|noterrain",
		description = "Clears all the terrain",
		run = function()
			local terrain = workspace:FindFirstChildOfClass("Terrain")
			if terrain then
				terrain:Clear()
			end
		end
	}
}
