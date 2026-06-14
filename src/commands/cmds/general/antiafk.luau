return {
	action = "antiafk|antiidle",
	description = "Prevents the game from kicking you for being idle/afk",
	run = function(self)
		local getconnections = self.executorEnv.getconnections
		local privateEnv = self.privateEnv
		
		if privateEnv.enabledAntiAfk then
			self:notify("anti AFK is already enabled")
			return
		end
		
		privateEnv.enabledAntiAfk = true
		
		if not getconnections then
			self.localPlayer.Idled:Connect(function()
				self.virtualUser:CaptureController()
				self.virtualUser:ClickButton2(Vector2.new())
			end)
			return
		end
		
		for _, connection in getconnections(self.localPlayer.Idled) do
			local disconnect = connection.Disconnect or connection.Disable
			
			if disconnect then
				disconnect(connection)
			end
		end
		
		self:notify("anti AFK now is enabled enabled")
	end
}