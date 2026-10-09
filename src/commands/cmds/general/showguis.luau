local function unbind(self, tag)
	local garbage = self:collectGarbage(tag)
	if not garbage then return end
	
	for object, originalValue in garbage do
		object.Visible = originalValue
	end
	
	local binded = self:registerGarbage("bindedHideGuis")
	binded[tag] = nil
end

local function bind(self, tag, value)
	local binded = self:registerGarbage("bindedHideGuis")
	
	for key, _ in binded do
		unbind(self, key)
	end
	
	binded[tag] = true
	
	local garbage = self:createGarbage(tag)
	local playerGui = self.localPlayer.PlayerGui
	
	for _, object in playerGui:GetDescendants() do
		if object:IsA("GuiObject") and object.Visible ~= value then
			local original = object.Visible
			object.Visible = value
			garbage[object] = original
		end
	end
end

return {
	{
		action = "showguis",
		description = "Shows any invisible GUIs",
		run = function(self)
			bind(self, "visibleGuiObjects", true)
		end
	},
	{
		action = "unshowguis",
		description = "Undoes showguis",
		run = function(self)
			unbind(self, "visibleGuiObjects")
		end
	},
	{
		action = "hideguis",
		description = "Hides any GUIs in PlayerGui",
		run = function(self)
			bind(self, "invisibleGuiObjects", false)
		end
	},
	{
		action = "unhideguis",
		description = "Undoes hideguis",
		run = function(self)
			unbind(self, "invisibleGuiObjects")
		end
	}
}