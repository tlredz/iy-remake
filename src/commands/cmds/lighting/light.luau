local privateEnv = require("../../../framework/environment/private")
local resolvePlayers = require("../../systems/resolvePlayers")

-- Settings of the Lighting service as the game had them when this file loaded (same as IY)
local lighting = require("../../../framework/services/rbxServices").Lighting

local lightProps = {"Ambient", "OutdoorAmbient", "Brightness", "ClockTime", "FogEnd", "FogStart", "GlobalShadows"}
local originalSettings = {}

local function restoreLighting()
	for property, value in originalSettings do
		lighting[property] = value
	end
end

local function storeOriginalLighting()
	if privateEnv.originalLighting then
		originalSettings = privateEnv.originalLighting
		return
	end
	
	for _, property in lightProps do
		originalSettings[property] = lighting[property]
	end
	
	privateEnv.originalLighting = originalSettings
end

storeOriginalLighting()

return {
	{
		action = "restorelighting|rlighting",
		description = "Restores Lighting properties",
		run = restoreLighting
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
			local players = resolvePlayers(args:nextValue())
			local radius = args:nextValue() or 10
			
			for _, target in players do
				local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
				if not root then return end
				
				local light = Instance.new("PointLight")
				light.Range = radius
				light.Brightness = 5
				light.Parent = root
				
				table.insert(self:registerGarbage("dynamicLights"), light)
			end
		end
	},
	{
		action = "nolight|unlight",
		description = "Removes dynamic light from your player",
		run = function(self)
			for _, light in self:collectGarbage("dynamicLights") or {} do
				light:Destroy()
			end
			
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
