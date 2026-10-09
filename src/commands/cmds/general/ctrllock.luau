local function setShiftKey(self, keyCode)
	local scripts = self.localPlayer.PlayerScripts
	local mouseLock = scripts.PlayerModule.CameraModule.MouseLockController
	local boundKeys = mouseLock:FindFirstChild("BoundKeys")

	if not boundKeys then
		boundKeys = Instance.new("StringValue", mouseLock)
		boundKeys.Name = "BoundKeys"
	end
	
	boundKeys.Value = keyCode
end

return {
	{
		action = "ctrllock",
		description = "Binds Shiftlock to LeftControl",
		run = function(self)
			setShiftKey(self, "LeftControl")
		end
	},
	{
		action = "unctrllock",
		description = "Re-binds Shiftlock to LeftShift",
		run = function(self)
			setShiftKey(self, "LeftShift")
		end
	}
}