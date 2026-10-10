-- /src/commands/cmds/general/hideiy.luau

local SHOW_KEYS = {
	[Enum.KeyCode.Semicolon] = true,
	[Enum.KeyCode.RightControl] = true,
}

local function clearListener(self)
	local garbage = self:collectGarbage("hideiy")
	if garbage and garbage.connection then
		garbage.connection:Disconnect()
	end
end

local function hideWindow(self)
	local interface = self.infiniteYield
	if not interface or not interface.mainFrame then
		self:notify("IY", "the main window is not created yet")
		return
	end

	if not interface.mainFrame.Visible then
		self:notify("IY", "already hidden")
		return
	end

	clearListener(self)
	interface:releaseCommandFocus()

	local garbage = self:registerGarbage("hideiy")
	interface.mainFrame.Visible = false

	garbage.connection = self:connect(self.robloxServices.UserInputService.InputBegan, function(input, processed)
		if processed or not SHOW_KEYS[input.KeyCode] then return end
		
		clearListener(self)
		interface:showCommandBar()
	end)

	self:notify("IY", "hidden. Press ; or tap the IY button to type a command")
end

local function showWindow(self)
	clearListener(self)

	local interface = self.infiniteYield
	if interface then
		interface:showWindow()
	end
end

return {
	{
		action = "hideiy|hideinterface",
		description = "Hides the main IY GUI",
		run = function(self)
			hideWindow(self)
		end
	},
	{
		action = "showiy|unhideiy|unhideinterface",
		description = "Shows IY again",
		run = function(self)
			showWindow(self)
		end
	}
}
