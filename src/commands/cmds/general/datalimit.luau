return {
	action = "datalimit",
	description = "Set outgoing KBPS limit",
	args = { kind = "number", name = "KB per second" },
	run = function(self, args)
		local value = args:nextValue()
		self.networkClient:SetOutgoingKBPSLimit(value)
	end
}