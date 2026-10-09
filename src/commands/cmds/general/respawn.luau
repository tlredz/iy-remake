-- Swaps the character for a temporary model and back, which forces the respawn (same trick as IY)
local function respawn(self)
	local localPlayer = self.localPlayer
	local character = localPlayer.Character
	if not character then return end
	
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	end
	
	character:ClearAllChildren()
	
	local fakeCharacter = Instance.new("Model")
	fakeCharacter.Parent = workspace
	
	task.wait()
	localPlayer.Character = fakeCharacter
	task.wait()
	localPlayer.Character = character
	fakeCharacter:Destroy()
end

return {
	{
		action = "respawn",
		description = "Respawns your character in place (client side)",
		run = function(self)
			respawn(self)
		end
	},
	{
		action = "refresh|re",
		description = "Respawns your character and puts you back where you were",
		run = function(self)
			local root = self.playerService:getRootPart()
			if not root then return end
			
			local localPlayer = self.localPlayer
			local position = root.CFrame
			local cameraCFrame = workspace.CurrentCamera.CFrame
			
			respawn(self)
			
			task.spawn(function()
				local newCharacter = localPlayer.CharacterAdded:Wait()
				local newRoot = newCharacter:WaitForChild("HumanoidRootPart", 10)
				if not newRoot then return end
				
				newRoot.CFrame = position
				workspace.CurrentCamera.CFrame = cameraCFrame
			end)
		end
	},
	{
		action = "reset",
		description = "Resets your character",
		run = function(self)
			self.playerService:resetCharacter()
		end
	}
}
