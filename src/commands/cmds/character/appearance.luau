-- Destroys every descendant of `container` that passes `predicate`
local function destroyWhere(container: Instance?, predicate: (Instance) -> boolean)
	if not container then return end
	
	for _, object in container:GetDescendants() do
		if predicate(object) then
			object:Destroy()
		end
	end
end

local function getCharacter(self)
	return self.localPlayer.Character
end

local function getAccessories(self)
	local humanoid = self.playerService:getHumanoid()
	return humanoid and humanoid:GetAccessories() or {}
end

local function isSpecialMesh(object)
	return object:IsA("SpecialMesh")
end

return {
	{
		action = "blockhead",
		description = "Removes the mesh from your head (makes it block-like)",
		run = function(self)
			local character = getCharacter(self)
			local head = character and character:FindFirstChild("Head")
			local mesh = head and head:FindFirstChildOfClass("SpecialMesh")
			if mesh then
				mesh:Destroy()
			end
		end
	},
	{
		action = "blockhats",
		description = "Removes the meshes from your accessories",
		run = function(self)
			for _, accessory in getAccessories(self) do
				destroyWhere(accessory, isSpecialMesh)
			end
		end
	},
	{
		action = "blocktool",
		description = "Removes the meshes from your equipped tools",
		run = function(self)
			local character = getCharacter(self)
			if not character then return end
			
			for _, child in character:GetChildren() do
				if child:IsA("Tool") or child:IsA("HopperBin") then
					destroyWhere(child, isSpecialMesh)
				end
			end
		end
	},
	{
		action = "nobgui|unbgui|nobillboardgui|unbillboardgui|noname|rohg",
		description = "Removes BillboardGuis and SurfaceGuis from your character",
		run = function(self)
			destroyWhere(getCharacter(self), function(object)
				return object:IsA("BillboardGui") or object:IsA("SurfaceGui")
			end)
		end
	},
	{
		action = "naked",
		description = "Removes your clothing and shirt graphics",
		run = function(self)
			destroyWhere(getCharacter(self), function(object)
				return object:IsA("Clothing") or object:IsA("ShirtGraphic")
			end)
		end
	},
	{
		action = "noface|removeface",
		description = "Removes your face decal",
		run = function(self)
			destroyWhere(getCharacter(self), function(object)
				return object:IsA("Decal") and object.Name == "face"
			end)
		end
	},
	{
		action = "deletehats|nohats|rhats",
		description = "Removes the welds that hold your accessories on",
		run = function(self)
			destroyWhere(getCharacter(self), function(object)
				return object:IsA("Weld") and object:FindFirstAncestorWhichIsA("Accessory") ~= nil
			end)
		end
	},
	{
		action = "drophats|drophat",
		description = "Drops your accessories into the workspace",
		run = function(self)
			for _, accessory in getAccessories(self) do
				accessory.Parent = workspace
			end
		end
	},
	{
		action = "clearcharappearance|clearchar|clrchar",
		description = "Clears your character appearance",
		run = function(self)
			self.localPlayer:ClearCharacterAppearance()
		end
	},
	{
		action = "split",
		description = "Splits your R15 character in half (removes the waist)",
		run = function(self)
			local character = getCharacter(self)
			local humanoid = self.playerService:getHumanoid()
			if not (character and humanoid) then return end
			
			if humanoid.RigType ~= Enum.HumanoidRigType.R15 then
				self:notify("R15 Required", "This command requires the R15 rig type")
				return
			end
			
			local upperTorso = character:FindFirstChild("UpperTorso")
			local waist = upperTorso and upperTorso:FindFirstChild("Waist")
			if waist then
				waist:Destroy()
			end
		end
	}
}
