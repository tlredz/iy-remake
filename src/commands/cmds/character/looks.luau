local function isGui(object: Instance): boolean
	return object:IsA("BillboardGui") or object:IsA("SurfaceGui")
end

local function destroyNamedChildren(container: Instance, names: { string })
	for _, name in names do
		local child = container:FindFirstChild(name)
		if child then
			child:Destroy()
		end
	end
end

return {
	{
		action = "creeper",
		description = "Gives your character a creeper look (removes the face mesh, arms and accessories)",
		run = function(self)
			local character = self.localPlayer.Character
			local humanoid = self.playerService:getHumanoid()
			if not (character and humanoid) then return end
			
			local head = character:FindFirstChild("Head")
			local mesh = head and head:FindFirstChildOfClass("SpecialMesh")
			if mesh then
				mesh:Destroy()
			end
			
			if humanoid.RigType == Enum.HumanoidRigType.R15 then
				destroyNamedChildren(character, { "LeftUpperArm", "RightUpperArm" })
			else
				destroyNamedChildren(character, { "Left Arm", "Right Arm" })
			end
			
			humanoid:RemoveAccessories()
		end
	},
	{
		action = "chardelete|charremove|cd",
		description = "Deletes every part of your character with the given name",
		args = { kind = "string", name = "item name" },
		run = function(self, args)
			local character = self.localPlayer.Character
			local input = args:nextValue() or ""
			if not character then return end
			
			for _, object in character:GetDescendants() do
				if object.Name:lower() == input:lower() then
					object:Destroy()
				end
			end
			
			self:notify("Item(s) Deleted", `Deleted {input}`)
		end
	},
	{
		action = "chardeleteclass|charremoveclass|chardeleteclassname|charremoveclassname|cdc",
		description = "Deletes every part of your character with the given class name",
		args = { kind = "className", name = "class name" },
		run = function(self, args)
			local character = self.localPlayer.Character
			local input = args:nextValue() or ""
			if not character then return end
			
			for _, object in character:GetDescendants() do
				if object.ClassName:lower() == input:lower() then
					object:Destroy()
				end
			end
			
			self:notify("Item(s) Deleted", `Deleted items with ClassName {input}`)
		end
	},
	{
		action = "loopnobgui|loopunbgui|loopnobillboardgui|loopunbillboardgui|loopnoname|looprohg",
		description = "Removes BillboardGuis and SurfaceGuis from your character, including new ones",
		run = function(self)
			local character = self.localPlayer.Character
			if not character then return end
			
			local old = self:collectGarbage("nobgui")
			if old and old.connection then
				old.connection:Disconnect()
			end
			
			for _, object in character:GetDescendants() do
				if isGui(object) then
					object:Destroy()
				end
			end
			
			local garbage = self:createGarbage("nobgui")
			garbage.connection = self:connect(character.DescendantAdded, function(object)
				if isGui(object) then
					task.wait()
					object:Destroy()
				end
			end)
		end
	},
	{
		action = "unloopnobgui|unloopunbgui|unloopnobillboardgui|unloopunbillboardgui|unloopnoname|unlooprohg",
		description = "Stops removing BillboardGuis and SurfaceGuis from your character",
		run = function(self)
			local garbage = self:collectGarbage("nobgui")
			if garbage and garbage.connection then
				garbage.connection:Disconnect()
			end
		end
	}
}
