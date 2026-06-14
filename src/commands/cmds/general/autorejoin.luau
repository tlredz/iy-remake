return {
	action = "autorejoin|autorj",
	description = "Automatically rejoins the server if you get kicked/disconnected",
	run = function(self)
		if self.privateEnv.autoRejoinConn then
			self:notify("auto rejoin is already enabled")
			return
		end
		
		self.privateEnv.autoRejoinConn = self:connect(self.guiService.ErrorMessageChanged, function()
			self:run("rejoin")
		end)
	end
}