return {
	{
		action = "tools",
		description = "Copies tools from ReplicatedStorage and Lighting"
	},
	{
		action = "grabtools",
		description = "Automatically get tools that are dropped"
	},
	{
		action = "ungrabtools|nograbtools",
		description = "Disables grabtools"
	},
	{
		action = "dupetools|clonetools",
		description = "Duplicates your inventory tools a set amount of times",
		args = {
			kind = "number"
		}
	},
	{
		action = "droppabletools",
		description = "Makes your tools droppable"
	},
	{
		action = "reach",
		description = "Increases the hitbox of your held tool",
		args = {
			kind = "number"
		}
	},
	{
		action = "boxreach",
		description = "Increases the hitbox of your held tool in a box shape",
		args = {
			kind = "number"
		}
	},
	{
		action = "unreach|noreach",
		description = "Turns off reach"
	},
	{
		action = "grippos",
		description = "Changes your current tools grip position",
		args = {
			kind = "vector3"
		},
		run = function(self, args)
			local character = self.localPlayer.Character
			local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
			if not (character and backpack) then return end
			
			local gripPos = args:nextValue()
			for _, tool in character:GetChildren() do
				if tool:IsA("Tool") then
					tool.Parent = backpack
					tool.GripPos = gripPos
					tool.Parent = character
				end
			end
		end
	},
	{
		action = "usetools",
		description = "Activates all tools in your backpack at the same time",
		args = {
			{
				kind = "number",
				name = "tools amount",
				optional = true
			},
			{
				kind = "number",
				name = "equip delay",
				optional = true
			}
		}
	}
}
