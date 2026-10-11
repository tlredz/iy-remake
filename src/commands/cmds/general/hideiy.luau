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

-- While the window is hidden, the show keys open the command bar. The listener stays on until showiy,
-- so the window can be hidden again after the command bar is used (interface:hideWindow)
local function listenForShowKeys(self, interface)
	clearListener(self)

	local garbage = self:registerGarbage("hideiy")
	garbage.connection = self:connect(self.robloxServices.UserInputService.InputBegan, function(input, processed)
		if processed or not SHOW_KEYS[input.KeyCode] then return end

		-- already shown (the command bar is open): the key is just typed
		if interface.mainFrame.Visible then return end

		interface:showCommandBar()
	end)
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

	interface:hideWindow()
	listenForShowKeys(self, interface)

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
