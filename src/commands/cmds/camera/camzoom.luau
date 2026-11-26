return {
	{
		client = true,
		action = "maxzoom",
		description = "Maximum camera zoom",
		args = { kind = "number" },
		run = function(self, args)
			self.localPlayer.CameraMaxZoomDistance = args:nextValue()
		end
	},
	{
		client = true,
		action = "minzoom",
		description = "Minimum camera zoom",
		args = { kind = "number" },
		run = function(self, args)
			self.localPlayer.CameraMinZoomDistance = args:nextValue()
		end
	},
	{
		client = true,
		action = "camdistance",
		description = "Changes camera distance from your player",
		args = { kind = "number" },
		run = function(self, args)
			local distance = args:nextValue()
			local player = self.localPlayer
			local camMax = player.CameraMaxZoomDistance
			local camMin = player.CameraMinZoomDistance
			
			if camMax < distance then
				camMax = distance
			end
			
			player.CameraMaxZoomDistance = distance
			player.CameraMinZoomDistance = distance
			task.wait()
			player.CameraMaxZoomDistance = camMax
			player.CameraMinZoomDistance = camMin
		end
	}
}
