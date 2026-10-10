return {
	action = "clientantiteleport|antiteleport",
	description = "Prevents localscripts from teleporting you (CLIENT)",
	run = function(self)
		if self.privateEnv.clientAntiTeleport then
			self:notify("Client AntiTP", "already active")
			return
		end

		local hookmetamethod = self:expectExploit("hookmetamethod")
		local getnamecallmethod = self:expectExploit("getnamecallmethod")
		if not (hookmetamethod and getnamecallmethod) then return end

		local teleportService = self.teleportService
		local settings = self.storage.settings
		local checkcaller = self.executorEnv.checkcaller

		local oldIndex
		oldIndex = hookmetamethod(game, "__index", function(object, key)
			if object == teleportService and typeof(key) == "string" then
				if key:lower() == "teleport" then
					error("Expected ':' not '.' calling member function Teleport", 2)
				elseif key == "TeleportToPlaceInstance" then
					error("Expected ':' not '.' calling member function TeleportToPlaceInstance", 2)
				end
			end
			return oldIndex(object, key)
		end)

		local oldNamecall
		oldNamecall = hookmetamethod(game, "__namecall", function(object, ...)
			if object == teleportService and not checkcaller() then
				local method = getnamecallmethod()
				if method:lower() == "teleport" or method == "TeleportToPlaceInstance" then
					-- Only a rejoin of this same place gets through, and only with allowrejoin on (same as IY).
					-- Calls made by our own script (checkcaller) always get through, so 'rejoin' keeps working.
					local placeId = ...
					local allowed = settings:getValue("allowRejoin") == true and placeId == game.PlaceId
					if not allowed then return end
				end
			end
			return oldNamecall(object, ...)
		end)

		self.privateEnv.clientAntiTeleport = true
		self:notify("Client AntiTP", "Client anti teleport is now active (only effective on localscript teleport)")
	end
}
