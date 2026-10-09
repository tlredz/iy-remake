return {
	action = "notifyping|ping",
	description = "Notify yourself your ping",
	run = function(self)
		local ping = self.localPlayer:GetNetworkPing()
		self:notify("Ping", `{math.round(ping * 1000)}ms`)
	end
}