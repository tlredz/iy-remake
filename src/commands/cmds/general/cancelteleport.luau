return {
	action = "cancelteleport|canceltp",
	description = "Cancels teleports in progress",
	run = function(self)
		self.playerService:cancelTween()
		self.teleportService:TeleportCancel()
	end
}
