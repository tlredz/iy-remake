-- The camera Popper is the part of the game's camera that pulls the camera in front of walls.
local function getPopper(player)
	local scripts = player:FindFirstChild("PlayerScripts")
	local playerModule = scripts and scripts:FindFirstChild("PlayerModule")
	local cameraModule = playerModule and playerModule:FindFirstChild("CameraModule")
	local zoomController = cameraModule and cameraModule:FindFirstChild("ZoomController")
	return zoomController and zoomController:FindFirstChild("Popper")
end

return {
	action = "noclipcam|nccam",
	description = "Allows camera to go through objects like walls",
	run = function(self)
		local getgc = self:expectExploit("getgc")
		local getconstants = self:expectExploit("getconstants")
		local setconstant = self:expectExploit("setconstant")
		local getfenv = self:expectExploit("getfenv")
		if not (getgc and getconstants and setconstant and getfenv) then return end

		local popper = getPopper(self.localPlayer)
		if not popper then
			self:notify("noclipcam", "camera popper not found")
			return
		end

		-- Swaps the 0.25 and 0 constants of the Popper. Running it again swaps them back.
		for _, value in getgc() do
			if type(value) == "function" and getfenv(value).script == popper then
				for index, constant in getconstants(value) do
					if tonumber(constant) == 0.25 then
						setconstant(value, index, 0)
					elseif tonumber(constant) == 0 then
						setconstant(value, index, 0.25)
					end
				end
			end
		end
	end
}
