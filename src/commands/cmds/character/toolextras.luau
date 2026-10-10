-- Tool commands (IY's tools, grabtools, reach, usetools, ...)

local DEFAULT_REACH = 60

-- Copies every Tool and HopperBin inside `instance` (and everything under it) into the backpack
local function copyTools(instance: Instance, backpack: Instance)
	for _, child in instance:GetChildren() do
		if child:IsA("Tool") or child:IsA("HopperBin") then
			child:Clone().Parent = backpack
		end
		copyTools(child, backpack)
	end
end

local function setDroppable(container: Instance?)
	if not container then return end

	for _, child in container:GetChildren() do
		if child:IsA("Tool") then
			child.CanBeDropped = true
		end
	end
end

-- grabtools: equips any tool that lands in the workspace

local function tryGrab(self, child: Instance)
	local humanoid = self.playerService:getHumanoid()
	if humanoid and child:IsA("BackpackItem") and child:FindFirstChild("Handle") then
		humanoid:EquipTool(child)
	end
end

local function stopGrabTools(self)
	local garbage = self:collectGarbage("grabtools")
	if garbage and garbage.connection then
		garbage.connection:Disconnect()
	end
end

local function startGrabTools(self)
	stopGrabTools(self)

	local garbage = self:createGarbage("grabtools")

	for _, child in workspace:GetChildren() do
		tryGrab(self, child)
	end

	garbage.connection = self:connect(workspace.ChildAdded, function(child)
		tryGrab(self, child)
	end)
end

-- reach / boxreach: stretches the handle of your held tools.
-- Every change is saved per tool, so unreach puts back the original size and grip.

local function stopReach(self)
	local garbage = self:collectGarbage("reach")
	if not garbage then return end

	for _, record in garbage.records do
		local handle = record.handle

		local box = handle:FindFirstChild("SelectionBoxCreated")
		if box then
			box:Destroy()
		end

		handle.Size = record.size
		handle.Massless = record.massless
		record.tool.GripPos = record.gripPos
	end
end

local function startReach(self, handleSize: Vector3)
	stopReach(self)

	local character = self.playerService:getCharacter()
	local humanoid = self.playerService:getHumanoid()
	if not (character and humanoid) then
		self:notify("Reach", "your character is not loaded")
		return
	end

	local garbage = self:createGarbage("reach")
	garbage.records = {}

	for _, tool in character:GetDescendants() do
		if not tool:IsA("Tool") then continue end

		local handle = tool:FindFirstChild("Handle")
		if not (handle and handle:IsA("BasePart")) then continue end

		table.insert(garbage.records, {
			tool = tool,
			handle = handle,
			size = handle.Size,
			massless = handle.Massless,
			gripPos = tool.GripPos
		})

		local box = Instance.new("SelectionBox")
		box.Name = "SelectionBoxCreated"
		box.Adornee = handle
		box.Parent = handle

		handle.Massless = true
		handle.Size = handleSize
		tool.GripPos = Vector3.zero
	end

	-- Same as IY: the tools have to be equipped again to get the new hitbox
	humanoid:UnequipTools()
end

return {
	{
		action = "tools|gears",
		description = "Copies tools from ReplicatedStorage and Lighting",
		run = function(self)
			local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
			if not backpack then
				self:notify("Tools", "your backpack is not loaded")
				return
			end

			copyTools(self.robloxServices.Lighting, backpack)
			copyTools(self.robloxServices.ReplicatedStorage, backpack)

			self:notify("Tools", "Copied tools from ReplicatedStorage and Lighting")
		end
	},
	{
		action = "grabtools",
		description = "Automatically get tools that are dropped",
		run = function(self)
			startGrabTools(self)
			self:notify("Grabtools", "Picking up any dropped tools")
		end
	},
	{
		action = "ungrabtools|nograbtools",
		description = "Disables grabtools",
		run = function(self)
			stopGrabTools(self)
			self:notify("Grabtools", "Grabtools has been disabled")
		end
	},
	{
		action = "dupetools|clonetools",
		description = "Duplicates your inventory tools a set amount of times",
		args = {
			kind = "number"
		},
		run = function(self, args)
			local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
			if not backpack then
				self:notify("Dupetools", "your backpack is not loaded")
				return
			end

			-- capped: a huge number would freeze the client while the copies are made
			local times = math.clamp(math.floor(args:nextValue() or 1), 1, 100)
			local added = 0

			for _, item in backpack:GetChildren() do
				if item:IsA("Tool") or item:IsA("HopperBin") then
					for _ = 1, times do
						item:Clone().Parent = backpack
						added += 1
					end
				end
			end

			self:notify("Dupetools", `added {added} tool(s)`)
		end
	},
	{
		action = "droppabletools",
		description = "Makes your tools droppable",
		run = function(self)
			setDroppable(self.playerService:getCharacter())
			setDroppable(self.localPlayer:FindFirstChildOfClass("Backpack"))
		end
	},
	{
		action = "reach",
		description = "Increases the hitbox of your held tool",
		args = {
			kind = "number"
		},
		run = function(self, args)
			local length = args and args:nextValue() or DEFAULT_REACH
			startReach(self, Vector3.new(0.5, 0.5, length))
		end
	},
	{
		action = "boxreach",
		description = "Increases the hitbox of your held tool in a box shape",
		args = {
			kind = "number"
		},
		run = function(self, args)
			local size = args and args:nextValue() or DEFAULT_REACH
			startReach(self, Vector3.one * size)
		end
	},
	{
		action = "unreach|noreach|unboxreach",
		description = "Turns off reach",
		run = function(self)
			stopReach(self)
		end
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
		},
		run = function(self, args)
			local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
			local character = self.playerService:getCharacter()
			if not (backpack and character) then return end

			local amount = args:nextValue() or 1
			local delay = args:nextValue()

			for _, tool in backpack:GetChildren() do
				if not tool:IsA("Tool") then continue end

				tool.Parent = character
				task.spawn(function()
					for _ = 1, amount do
						tool:Activate()
						if delay then
							task.wait(delay)
						end
					end
					tool.Parent = backpack
				end)
			end
		end
	}
}
