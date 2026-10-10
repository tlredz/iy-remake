-- hovername: shows the name of the player under the mouse. unhovername turns it off.

local function findPlayer(self, target: Instance?): Player?
	if not target then return nil end

	local model = target:FindFirstAncestorOfClass("Model")
	if not model then return nil end

	return self.players:GetPlayerFromCharacter(model)
end

local function stopHovername(self): boolean
	local garbage = self:collectGarbage("hovername")
	if not garbage then return false end

	if garbage.connection then
		garbage.connection:Disconnect()
	end
	if garbage.gui then
		garbage.gui:Destroy()
	end
	return true
end

local function createGui(self): (ScreenGui, TextLabel)
	local gui = Instance.new("ScreenGui")
	gui.Name = "HovernameGui"
	gui.ResetOnSpawn = false

	local hiddenParent = self.executorEnv.gethui and self.executorEnv.gethui()
	gui.Parent = hiddenParent or self.coreGui

	local label = Instance.new("TextLabel")
	label.Name = "Name"
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromOffset(200, 20)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 16
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 0
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Visible = false
	label.Parent = gui

	return gui, label
end

return {
	{
		action = "hovername",
		description = "Shows a players username when your mouse is hovered over them",
		run = function(self)
			stopHovername(self)

			local mouse = self.playerService:getMouse()
			local gui, label = createGui(self)

			local garbage = self:createGarbage("hovername")
			garbage.gui = gui
			garbage.connection = self:connect(self.runService.RenderStepped, function()
				local player = findPlayer(self, mouse.Target)

				if player then
					label.Text = player.Name
					label.Position = UDim2.fromOffset(mouse.X + 18, mouse.Y + 12)
					label.Visible = true
				else
					label.Visible = false
				end
			end)
		end
	},
	{
		action = "unhovername|nohovername",
		description = "Turns off hovername",
		run = function(self)
			stopHovername(self)
		end
	}
}
