local function applyFullbright(self)
	local lighting = self.robloxServices.Lighting
	lighting.Brightness = 2
	lighting.ClockTime = 14
	lighting.FogEnd = 100000
	lighting.GlobalShadows = false
	lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

local function stopLoop(self)
	local garbage = self:collectGarbage("loopfullbright")
	if garbage then
		garbage.connection:Disconnect()
	end
end

return {
	{
		action = "fullbright|fb",
		description = "Makes the map brighter / more visible (CLIENT)",
		run = function(self)
			applyFullbright(self)
		end
	},
	{
		action = "loopfullbright|loopfb",
		description = "Makes the map brighter / more visible but looped (CLIENT)",
		run = function(self)
			stopLoop(self)

			local garbage = self:createGarbage("loopfullbright")
			garbage.connection = self:connect(self.runService.RenderStepped, function()
				applyFullbright(self)
			end)
		end
	},
	{
		action = "unloopfullbright|unloopfb",
		description = "Unloops fullbright",
		run = function(self)
			stopLoop(self)
		end
	}
}
