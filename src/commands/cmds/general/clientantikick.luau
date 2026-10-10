return {
	action = "clientantikick|antikick",
	description = "Prevents localscripts from kicking you (CLIENT)",
	run = function(self)
		if self.privateEnv.clientAntiKick then
			self:notify("Client Antikick", "already active")
			return
		end

		local hookmetamethod = self:expectExploit("hookmetamethod")
		local getnamecallmethod = self:expectExploit("getnamecallmethod")
		if not (hookmetamethod and getnamecallmethod) then return end

		local localPlayer = self.localPlayer

		-- Same as IY: replaces the Kick method of the local player when the exploit allows it
		local hookfunction = self.executorEnv.hookfunction
		if hookfunction then
			pcall(hookfunction, localPlayer.Kick, function() end)
		end

		local oldIndex
		oldIndex = hookmetamethod(game, "__index", function(object, key)
			if object == localPlayer and typeof(key) == "string" and key:lower() == "kick" then
				error("Expected ':' not '.' calling member function Kick", 2)
			end
			return oldIndex(object, key)
		end)

		local oldNamecall
		oldNamecall = hookmetamethod(game, "__namecall", function(object, ...)
			if object == localPlayer and getnamecallmethod():lower() == "kick" then
				return
			end
			return oldNamecall(object, ...)
		end)

		self.privateEnv.clientAntiKick = true
		self:notify("Client Antikick", "Client anti kick is now active (only effective on localscript kick)")
	end
}
