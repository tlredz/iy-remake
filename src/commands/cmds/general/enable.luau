local coreGuiTypeNames = {
	["inventory"] = Enum.CoreGuiType.Backpack,
	["leaderboard"] = Enum.CoreGuiType.PlayerList,
	["emotes"] = Enum.CoreGuiType.EmotesMenu
}

for _, item in Enum.CoreGuiType:GetEnumItems() do
	coreGuiTypeNames[string.lower(item.Name)] = item
end

local function setCoreGui(self, name: string, enabled: boolean)
	if name == "reset" then
		self.starterGui:SetCore("ResetButtonCallback", enabled)
		return
	end
	
	local coreGuiType = coreGuiTypeNames[name]
	if coreGuiType then
		self.starterGui:SetCoreGuiEnabled(coreGuiType, enabled)
	end
end

return {
	{
		action = "enable",
		description = "Enables a CoreGui element (inventory, leaderboard, chat, reset, emotes...)",
		args = { kind = "string", name = "gui name" },
		run = function(self, args)
			setCoreGui(self, args:nextValue():lower(), true)
		end
	},
	{
		action = "disable",
		description = "Disables a CoreGui element (inventory, leaderboard, chat, reset, emotes...)",
		args = { kind = "string", name = "gui name" },
		run = function(self, args)
			setCoreGui(self, args:nextValue():lower(), false)
		end
	}
}
