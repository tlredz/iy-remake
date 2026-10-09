-- The destroy height the game started with (same idea as OrgDestroyHeight in IY)
local ORIGINAL_DESTROY_HEIGHT = workspace.FallenPartsDestroyHeight

return {
	{
		action = "antivoid",
		description = "Pushes you back up when you fall below the destroy height",
		run = function(self)
			if self:hasGarbage("antivoid") then
				self:notify("antivoid is already enabled")
				return
			end
			
			local garbage = self:createGarbage("antivoid")
			garbage.connection = self:connect(self.runService.Stepped, function()
				local root = self.playerService:getRootPart()
				if root and root.Position.Y <= ORIGINAL_DESTROY_HEIGHT + 25 then
					root.AssemblyLinearVelocity += Vector3.new(0, 250, 0)
				end
			end)
			
			self:notify("antivoid", "Enabled")
		end
	},
	{
		action = "unantivoid|noantivoid",
		description = "Disables antivoid",
		run = function(self)
			local garbage = self:collectGarbage("antivoid")
			if garbage and garbage.connection then
				garbage.connection:Disconnect()
				self:notify("antivoid", "Disabled")
			end
		end
	}
}
