return {
	{
		action = "gotocamera|gotocam|tocam",
		description = "Teleports you to the location of your camera",
		run = function(self)
			self.playerService:teleportTo(self.playerService:getCamera().CFrame)
		end
	},
	{
		action = "tweengotocamera|tweengotocam|tgotocamera|tgotocam",
		description = "Tweens you to the location of your camera",
		run = function(self)
			self.playerService:tweenTeleportTo({
				target = self.playerService:getCamera().CFrame,
				speed = self.privateEnv.tweenSpeed
			})
		end
	}
}
