local freecam = require("../../systems/freecam")

return {
	action = "fixcam|restorecam",
	description = "Fixes camera",
	run = function(self)
		local playerService = self.playerService
		local localPlayer = self.localPlayer

		-- A running freecam would keep moving the camera, so it goes first
		freecam.stop(self)

		-- A running spectate would keep moving the camera back to its target
		if self:hasGarbage("view") then
			self:run("unview")
		end

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
