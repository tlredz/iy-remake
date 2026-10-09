-- Keeps deleting backpack tools whose name matches, every frame.
-- Each name gets its own connection stored in the "removespecifictool" garbage.

local function getFilter(self)
	local garbage = self:registerGarbage("removespecifictool")
	garbage.connections = garbage.connections or {}
	return garbage
end

return {
	{
		action = "removespecifictool",
		description = "Keeps removing tools with the given name from your backpack",
		args = { kind = "string", name = "tool name" },
		run = function(self, args)
			local toolName = (args:nextValue() or ""):lower()
			local filter = getFilter(self)
			if filter.connections[toolName] then return end
			
			filter.connections[toolName] = self:connect(self.runService.RenderStepped, function()
				local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
				if not backpack then return end
				
				for _, tool in backpack:GetChildren() do
					if tool.Name:lower() == toolName then
						tool:Destroy()
					end
				end
			end)
		end
	},
	{
		action = "unremovespecifictool",
		description = "Stops removing tools with the given name",
		args = { kind = "string", name = "tool name" },
		run = function(self, args)
			local toolName = (args:nextValue() or ""):lower()
			local garbage = self:getGarbage("removespecifictool")
			local connection = garbage and garbage.connections and garbage.connections[toolName]
			
			if connection then
				connection:Disconnect()
				garbage.connections[toolName] = nil
			end
		end
	},
	{
		action = "clearremovespecifictool",
		description = "Stops removing every tool that is being filtered",
		run = function(self)
			local garbage = self:collectGarbage("removespecifictool")
			if not (garbage and garbage.connections) then return end
			
			for _, connection in garbage.connections do
				connection:Disconnect()
			end
		end
	}
}
