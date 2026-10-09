local function createLimitCommand(action: string, description: string, className: string)
	return {
		action = action,
		description = description,
		run = function()
			for _, object in workspace:GetDescendants() do
				if object:IsA(className) then
					object.MaxActivationDistance = math.huge
				end
			end
		end
	}
end

return {
	createLimitCommand(
		"noclickdetectorlimits|nocdlimits|removecdlimits",
		"Removes the activation distance limit of ClickDetectors",
		"ClickDetector"
	),
	createLimitCommand(
		"noproximitypromptlimits|nopplimits|removepplimits",
		"Removes the activation distance limit of ProximityPrompts",
		"ProximityPrompt"
	),
	{
		action = "instantproximityprompts|instantpp",
		description = "Fires proximity prompts as soon as they are held (needs fireproximityprompt)",
		run = function(self)
			local fireproximityprompt = self.executorEnv.fireproximityprompt
			
			if not fireproximityprompt then
				self:notify("Incompatible Exploit", "Your exploit does not support this command (missing fireproximityprompt)")
				return
			end
			
			if self:hasGarbage("instantpp") then
				self:notify("instant proximity prompts is already enabled")
				return
			end
			
			local garbage = self:createGarbage("instantpp")
			garbage.connection = self:connect(self.proximityPromptService.PromptButtonHoldBegan, function(prompt)
				fireproximityprompt(prompt)
			end)
		end
	},
	{
		action = "uninstantproximityprompts|uninstantpp",
		description = "Disables instant proximity prompts",
		run = function(self)
			local garbage = self:collectGarbage("instantpp")
			if garbage and garbage.connection then
				garbage.connection:Disconnect()
			end
		end
	}
}
