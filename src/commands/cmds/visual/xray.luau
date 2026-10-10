-- Sets the transparency of the parts that are not characters. Same as IY: 0.5 when enabled, 0 when not.
local function applyXray(self)
	local enabled = self.privateEnv.xrayEnabled == true

	for _, object in workspace:GetDescendants() do
		if object:IsA("BasePart") then
			local parent = object.Parent
			local grandParent = parent and parent.Parent
			local isCharacter = (parent and parent:FindFirstChildWhichIsA("Humanoid"))
				or (grandParent and grandParent:FindFirstChildWhichIsA("Humanoid"))

			if not isCharacter then
				object.LocalTransparencyModifier = enabled and 0.5 or 0
			end
		end
	end
end

local function stopLoop(self)
	local garbage = self:collectGarbage("loopxray")
	if garbage then
		garbage.connection:Disconnect()
	end
end

return {
	{
		action = "xray",
		description = "Makes all parts in workspace transparent",
		run = function(self)
			self.privateEnv.xrayEnabled = true
			applyXray(self)
		end
	},
	{
		action = "unxray|noxray",
		description = "Restores transparency to all parts in workspace",
		run = function(self)
			self.privateEnv.xrayEnabled = false
			applyXray(self)
		end
	},
	{
		action = "loopxray",
		description = "Makes all parts in workspace transparent but looped",
		run = function(self)
			stopLoop(self)

			local garbage = self:createGarbage("loopxray")
			garbage.connection = self:connect(self.runService.RenderStepped, function()
				self.privateEnv.xrayEnabled = true
				applyXray(self)
			end)
		end
	},
	{
		action = "unloopxray",
		description = "Unloops xray",
		run = function(self)
			stopLoop(self)
			self.privateEnv.xrayEnabled = false
			applyXray(self)
		end
	},
	{
		action = "togglexray",
		description = "Toggles xray",
		run = function(self)
			self.privateEnv.xrayEnabled = not self.privateEnv.xrayEnabled
			applyXray(self)
		end
	}
}
