return {
	action = "breakloops|break",
	description = "Stops any cmd loops (100^1^cmd)",
	run = function(self)
		self.loopService:stop()
	end
}