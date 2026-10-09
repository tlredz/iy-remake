return {
	{
		action = "noroot|removeroot|rroot",
		description = "Removes your character's root part (client side)",
		run = function(self)
			local character = self.localPlayer.Character
			if not character then return end
			
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local root = humanoid and humanoid.RootPart
			
			character.Parent = nil
			if root then
				root:Destroy()
			end
			character.Parent = workspace
		end
	},
	{
		action = "replaceroot|replacerootpart",
		description = "Replaces your character's root part with a fresh copy",
		run = function(self)
			local character = self.localPlayer.Character
			local root = self.playerService:getRootPart()
			if not (character and root) then return end
			
			local oldParent = character.Parent
			local oldCFrame = root.CFrame
			
			character.Parent = game
			local newRoot = root:Clone()
			newRoot.Parent = character
			root:Destroy()
			newRoot.CFrame = oldCFrame
			character.Parent = oldParent
		end
	}
}
