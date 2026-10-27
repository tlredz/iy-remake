return {
	action = "plugingoto|pgoto",
	description = "teleport your character to a player",
	args = {
		kind = "player",
		-- optional = true
	},
	run = function(self, args)
		local rootPart = self:getRootPart()

		-- checks if your character has a root part
		if not rootPart then return end

		-- the text of the argument, such as a name or a selector like nearest
		local targetText = args:nextValue()

		-- resolvePlayers returns a list, so the first match is the player to teleport to
		local targetPlayer = self:resolvePlayers(targetText)[1]

		if not (targetPlayer and targetPlayer.Character) then
			self:notify("Plugin Goto", "player not found or it's not alive")
			return
		end

		local targetCFrame = targetPlayer.Character:GetPivot()
		rootPart.CFrame = targetCFrame

		-- you can also use the player service to teleport your character
		-- self.playerService:teleportTo(targetCFrame)
	end,
}