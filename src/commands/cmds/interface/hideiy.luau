-- /src/commands/cmds/interface/hideiy.luau
-- hideiy hides the window, showiy shows it again. The window does the work (ui/init: hideWindow, showWindow): the prefix
-- key that brings a hidden window back is listened to there, so the Hide IY box of Settings > Interface does the same

local keyboardService = require("../../../framework/services/keyboardService")

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

	local prefixName = keyboardService:getBindingName("prefix")
	self:notify("IY", `hidden. Press {prefixName} or tap the IY button to type a command`)
end

local function showWindow(self)
	local interface = self.infiniteYield
	if interface then
		interface:showWindow()
	end
end

return {
	{
		client = true,
		action = "hideiy|hideinterface",
		description = "Hides the main IY GUI",
		run = function(self)
			hideWindow(self)
		end
	},
	{
		client = true,
		action = "showiy|unhideiy|unhideinterface",
		description = "Shows IY again",
		run = function(self)
			showWindow(self)
		end
	},
}
