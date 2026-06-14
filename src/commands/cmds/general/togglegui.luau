local coreGuiTypeNames = {
	["inventory"] = Enum.CoreGuiType.Backpack,
	["leaderboard"] = Enum.CoreGuiType.PlayerList,
	["emotes"] = Enum.CoreGuiType.EmotesMenu
}

for _, item in Enum.CoreGuiType:GetEnumItems() do
	coreGuiTypeNames[string.lower(item.Name)] = item
end

return {
	action = "togglecoregui|togglegui|tcgui",
	description = "Toggles visibility of coregui items",
	args = {
		{
			kind = "string",
			options = "inventory|playerlist|chat|reset|emotes|all", -- unlookupify(OPTIONS),
			name = "gui name"
		},
		{
			kind = "boolean",
			name = "enabled"
		}
	},
	run = function(self, args)
		local input = args:nextValue()
		local enabled = args:nextValue()
		
		if input == "reset" then
			self.starterGui:SetCore("ResetButtonCallback", enabled)
			return
		end
		
		local coreGuiType = coreGuiTypeNames[input]
		
		if coreGuiType then
			self.starterGui:SetCoreGuiEnabled(coreGuiType, enabled)
		end
	end
}