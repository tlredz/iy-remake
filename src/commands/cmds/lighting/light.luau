local resolvePlayers = require("../../systems/resolvePlayers")

-- Settings of the Lighting service as the game had them when this file loaded (same as IY)
local lighting = require("../../../framework/services/rbxServices").Lighting
local originalSettings = {
	ambient = lighting.Ambient,
	outdoorAmbient = lighting.OutdoorAmbient,
	brightness = lighting.Brightness,
	clockTime = lighting.ClockTime,
	fogEnd = lighting.FogEnd,
	fogStart = lighting.FogStart,
	globalShadows = lighting.GlobalShadows
}

return {
	{
		action = "restorelighting|rlighting",
		description = "Restores Lighting properties",
		run = function()
			lighting.Ambient = originalSettings.ambient
			lighting.OutdoorAmbient = originalSettings.outdoorAmbient
			lighting.Brightness = originalSettings.brightness
			lighting.ClockTime = originalSettings.clockTime
			lighting.FogEnd = originalSettings.fogEnd
			lighting.FogStart = originalSettings.fogStart
			lighting.GlobalShadows = originalSettings.globalShadows
		end
	},
	{
		action = "light",
		description = "Gives your player dynamic light (CLIENT)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "radius",
				optional = true
			}
		},
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			local radius = args:nextValue() or 30

			local root = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
			if not root then return end

			local light = Instance.new("PointLight")
			light.Range = radius
			light.Brightness = 5
			light.Parent = root

			local lights = self.privateEnv.dynamicLights or {}
			self.privateEnv.dynamicLights = lights
			table.insert(lights, light)
		end
	},
	{
		action = "nolight|unlight",
		description = "Removes dynamic light from your player",
		run = function(self)
			for _, light in self.privateEnv.dynamicLights or {} do
				light:Destroy()
			end
			self.privateEnv.dynamicLights = {}

			local character = self.playerService:getCharacter()
			if character then
				for _, object in character:GetDescendants() do
					if object:IsA("PointLight") then
						object:Destroy()
					end
				end
			end
		end
	}
}
