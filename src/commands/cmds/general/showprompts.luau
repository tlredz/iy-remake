return {
	{
		action = "noprompts|nopurchaseprompts",
		description = "Prevents the game from showing you purchase/premium prompts",
		run = function(self)
			self.coreGui.PurchasePromptApp.Enabled = false
		end
	},
	{
		action = "showprompts|showpurchaseprompts",
		description = "Allows the game to show purchase/premium prompts again",
		run = function(self)
			self.coreGui.PurchasePromptApp.Enabled = true
		end
	}
}