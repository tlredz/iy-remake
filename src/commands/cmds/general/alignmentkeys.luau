local MOVE_KEYS = {
	[Enum.KeyCode.Comma] = -1,
	[Enum.KeyCode.Period] = 1,
}

return {
	{
		action = "alignmentkeys",
		description = "Enables the left and right alignment keys (comma and period)",
		run = function(self)
			local garbage = self:createGarbage("alignmentkeys")
			if not garbage then return end
			
			garbage.akConn = self:connect(self.userInputService.InputBegan, function(inp, processed)
				if processed then return end
				
				local direction = MOVE_KEYS[inp.KeyCode]
				if not direction then return end
				
				local camera = self.playerService:getCamera()
				if not camera then return end
				
				camera:PanUnits(direction)
			end)
			
			garbage.akEmotes = self.starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)
			self.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
		end
	},
	{
		action = "unalignmentkeys|noalignmentkeys",
		description = "Disables the alignment keys",
		run = function(self)
			local garbage = self:collectGarbage("alignmentkeys")
			if not garbage then return end
			
			if garbage.akEmotes ~= nil then
				self.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, garbage.akEmotes)
			end
			
			garbage.akConn:Disconnect()
		end
	}
}