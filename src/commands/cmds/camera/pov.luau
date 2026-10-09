return {
	{
		action = "firstp",
		description = "Forces camera to go into first person",
		run = function(self)
			self.localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
		end
	},
	{
		action = "thirdp",
		description = "Allows camera to go into third person",
		run = function(self)
			self.localPlayer.CameraMode = Enum.CameraMode.Classic
		end
	}
}
