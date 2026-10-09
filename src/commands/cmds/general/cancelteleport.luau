return {
	action = "cancelteleport|canceltp",
	description = "Cancels teleports in progress",
	run = function(self)
		self.teleportService:TeleportCancel()
	end
}