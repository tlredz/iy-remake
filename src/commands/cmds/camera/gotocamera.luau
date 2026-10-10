return {
	{
		action = "gotocamera|gotocam",
		description = "Teleports you to the location of your camera",
		run = function(self)
			local root = self.playerService:getRootPart()
			if root then
				root.CFrame = workspace.CurrentCamera.CFrame
			end
		end
	},
	{
		action = "tweengotocam|tgotocam",
		description = "Tweens you to the location of your camera",
		run = function(self)
			local root = self.playerService:getRootPart()
			if not root then return end

			local info = TweenInfo.new(self.privateEnv.tweenSpeed or 1, Enum.EasingStyle.Linear)
			self.robloxServices.TweenService:Create(root, info, { CFrame = workspace.CurrentCamera.CFrame }):Play()
		end
	}
}
