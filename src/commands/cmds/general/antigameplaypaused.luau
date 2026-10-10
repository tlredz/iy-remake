local NETWORK_PAUSE_NAME = "CoreScripts/NetworkPause"

local function stopAntiPause(self)
	local garbage = self:collectGarbage("antigameplaypaused")
	if garbage then
		garbage.connection:Disconnect()
	end
end

return {
	{
		action = "antigameplaypaused",
		description = "Clears the annoying box shown when a game is loading assets due to network lag",
		run = function(self)
			stopAntiPause(self)

			local robloxGui = self.coreGui:FindFirstChild("RobloxGui")
			if not robloxGui then
				self:notify("Anti Pause", "RobloxGui was not found")
				return
			end

			local garbage = self:createGarbage("antigameplaypaused")
			garbage.connection = self:connect(robloxGui.ChildAdded, function(child)
				if child.Name == NETWORK_PAUSE_NAME then
					child:Destroy()
				end
			end)

			local existing = robloxGui:FindFirstChild(NETWORK_PAUSE_NAME)
			if existing then
				existing:Destroy()
			end
		end
	},
	{
		action = "unantigameplaypaused",
		description = "Disables antigameplaypaused",
		run = function(self)
			stopAntiPause(self)
		end
	}
}
