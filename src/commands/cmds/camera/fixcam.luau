return {
	action = "fixcam|restorecam",
	description = "Fixes camera",
	run = function(self)
		local playerService = self.playerService
		local localPlayer = self.localPlayer
		
		local humanoid = playerService:getHumanoid()
		
		if humanoid then
			self.signals.onCameraReset:Fire()
			
			local camera = playerService:getCamera()
			camera.CameraSubject = humanoid
			camera.CameraType = Enum.CameraType.Custom
			
			localPlayer.CameraMinZoomDistance = 0.5
			localPlayer.CameraMaxZoomDistance = 400
			localPlayer.CameraMode = Enum.CameraMode.Classic
			
			self:notify("camera has been reseted successfully")
		end
    end
}