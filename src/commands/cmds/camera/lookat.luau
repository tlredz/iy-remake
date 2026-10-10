local resolvePlayers = require("../../systems/resolvePlayers")

-- Roblox default zoom, used when the zoom was never changed by lookat
local DEFAULT_ZOOM = { max = 400, min = 0.5 }

return {
	action = "lookat",
	description = "Moves your camera view to a player",
	args = { kind = "player" },
	run = function(self, args)
		local target = resolvePlayers(args:nextValue())[1]
		local targetHead = target and target.Character and target.Character:FindFirstChild("Head")
		if not targetHead then
			self:notify("Lookat", "the player's character is not loaded")
			return
		end

		local player = self.localPlayer
		local camera = self.playerService:getCamera()

		-- Remember the zoom the player had, unless it is already the lookat zoom
		if player.CameraMaxZoomDistance ~= 0.5 then
			self.privateEnv.lookAtZoom = {
				max = player.CameraMaxZoomDistance,
				min = player.CameraMinZoomDistance
			}
		end
		local zoom = self.privateEnv.lookAtZoom or DEFAULT_ZOOM

		-- Zoom all the way in while the camera turns, then restore the zoom
		player.CameraMaxZoomDistance = 0.5
		player.CameraMinZoomDistance = 0.5
		task.wait()

		camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
		task.wait(0.1)

		player.CameraMaxZoomDistance = zoom.max
		player.CameraMinZoomDistance = zoom.min
	end
}
