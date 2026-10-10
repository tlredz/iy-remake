return {
	{
		action = "god",
		description = "Makes your character difficult to kill in most games",
		run = function(self)
			local localPlayer = self.localPlayer
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
			if not humanoid then return end

			local camera = workspace.CurrentCamera
			local cameraCFrame = camera.CFrame

			-- Same trick as IY: swap the Humanoid for a copy that cannot enter the death states
			local newHumanoid = humanoid:Clone()
			newHumanoid.Parent = character

			localPlayer.Character = nil
			newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			newHumanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			newHumanoid.BreakJointsOnDeath = true
			humanoid:Destroy()
			localPlayer.Character = character

			camera.CameraSubject = newHumanoid
			task.wait()
			camera.CFrame = cameraCFrame
			newHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

			-- Restarts the Animate script so the animations use the new Humanoid
			local animate = character:FindFirstChild("Animate")
			if animate then
				animate.Disabled = true
				task.wait()
				animate.Disabled = false
			end

			newHumanoid.Health = newHumanoid.MaxHealth
		end
	}
}
