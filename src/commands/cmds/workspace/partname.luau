-- partname: click a part to see its name and full path.
-- There is no separate 'off' command, so running partname again turns it off.

return {
	{
		action = "partname|partpath",
		description = "Allows you to click a part to see its path & name",
		run = function(self)
			local previous = self:collectGarbage("partname")
			local wasOn = previous ~= nil and previous.connection ~= nil and previous.connection.Connected

			if previous and previous.connection then
				previous.connection:Disconnect()
			end

			if wasOn then
				self:notify("Partname", "disabled")
				return
			end

			local mouse = self.playerService:getMouse()
			local garbage = self:createGarbage("partname")

			garbage.connection = self:connect(mouse.Button1Down, function()
				local target = mouse.Target
				if not target then return end

				self:notify(target.Name, target:GetFullName())
			end)

			self:notify("Partname", "click a part to see its path")
		end
	}
}
