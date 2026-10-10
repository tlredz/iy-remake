return {
	action = "enableshiftlock|enablesl",
	description = "Enables the shift lock option",
	run = function(self)
		local player = self.localPlayer
		player.DevEnableMouseLock = true

		-- Keeps it on, in case the game turns it off
		if self:hasGarbage("shiftlock") then return end

		local garbage = self:createGarbage("shiftlock")
		garbage.connection = self:connect(player:GetPropertyChangedSignal("DevEnableMouseLock"), function()
			player.DevEnableMouseLock = true
		end)

		self:notify("Shiftlock", "Shift lock should now be available")
	end
}
