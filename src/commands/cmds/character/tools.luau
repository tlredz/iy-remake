local resolvePlayers = require("../../systems/resolvePlayers")

local function isTool(object)
	return object:IsA("Tool") or object:IsA("HopperBin")
end

local function destroyTools(container: Instance?)
	if not container then return end
	
	for _, object in container:GetDescendants() do
		if isTool(object) then
			object:Destroy()
		end
	end
end

return {
	{
		action = "notools|rtools|clrtools|removetools|deletetools|dtools",
		description = "Deletes every tool in your backpack and character",
		run = function(self)
			destroyTools(self.localPlayer:FindFirstChildOfClass("Backpack"))
			destroyTools(self.localPlayer.Character)
		end
	},
	{
		action = "deleteselectedtool|dst",
		description = "Deletes the tools you are currently holding",
		run = function(self)
			destroyTools(self.localPlayer.Character)
		end
	},
	{
		action = "equiptools",
		description = "Equips every tool in your backpack",
		run = function(self)
			local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
			local character = self.localPlayer.Character
			if not (backpack and character) then return end
			
			for _, tool in backpack:GetChildren() do
				if isTool(tool) then
					tool.Parent = character
				end
			end
		end
	},
	{
		action = "unequiptools",
		description = "Unequips all your tools",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if humanoid then
				humanoid:UnequipTools()
			end
		end
	},
	{
		action = "droptools|droptool",
		description = "Drops every tool from your backpack to the workspace",
		run = function(self)
			local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
			local character = self.localPlayer.Character
			if not (backpack and character) then return end
			
			for _, tool in backpack:GetChildren() do
				if isTool(tool) then
					tool.Parent = character
				end
			end
			
			task.wait()
			
			for _, tool in character:GetChildren() do
				if isTool(tool) then
					tool.Parent = workspace
				end
			end
		end
	},
	{
		action = "copytools",
		description = "Copies the tools from a player's backpack into yours",
		args = { kind = "player" },
		run = function(self, args)
			local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
			if not backpack then return end
			
			for _, player in resolvePlayers(args:nextValue()) do
				local otherBackpack = player:FindFirstChildOfClass("Backpack")
				if otherBackpack then
					for _, tool in otherBackpack:GetChildren() do
						if isTool(tool) then
							local copy = tool:Clone()
							copy.Parent = backpack
						end
					end
				end
			end
		end
	}
}
