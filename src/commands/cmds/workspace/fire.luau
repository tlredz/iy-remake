local function matchName(object, name)
	return name == ""
		or object.Name:lower() == name
		or (object.Parent ~= nil and object.Parent.Name:lower() == name)
end

local function getPromptPosition(prompt: ProximityPrompt): Vector3?
	local parent = prompt.Parent
	if parent == nil then
		return nil
	elseif parent:IsA("Attachment") then
		return parent.WorldPosition
	elseif parent:IsA("BasePart") then
		return parent.Position
	elseif parent:IsA("Model") then
		return parent:GetPivot().Position
	end
	return nil
end

local function getClosestPrompt(self)
	local root = self.playerService:getRootPart()
	if not root then
		return nil
	end
	
	local closestPrompt = nil
	local closestDistance = math.huge
	
	for _, descendant in workspace:GetDescendants() do
		if descendant:IsA("ProximityPrompt") and descendant.Enabled then
			local position = getPromptPosition(descendant)
			if not position then continue end
			
			local distance = (position - root.Position).Magnitude
			
			if distance < closestDistance then
				closestPrompt, closestDistance = descendant, distance
			end
		end
	end
	
	return closestPrompt
end

local function teleportToPrompt(self, prompt: ProximityPrompt)
	local root = self.playerService:getRootPart()
	local position = getPromptPosition(prompt)
	
	if root and position then
		root.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
	end
end

return {
	{
		action = "fireclickdetectors|firecd",
		description = "Uses all click detectors in a game or uses the optional name",
		args = {
			kind = "object",
			optional = true
		},
		run = function(self, args)
			local fireclickdetector = self:expectExploit("fireclickdetector")
			if not fireclickdetector then return end
			
			local name = (args:nextValue() or ""):lower()
			
			for _, descendant in workspace:GetDescendants() do
				if descendant:IsA("ClickDetector") and matchName(descendant, name) then
					fireclickdetector(descendant)
				end
			end
		end
	},
	{
		action = "fireproximityprompts|firepp",
		description = "Uses all proximity prompts in a game or uses the optional name",
		args = {
			kind = "object",
			optional = true
		},
		run = function(self, args)
			local fireproximityprompt = self:expectExploit("fireproximityprompt")
			if not fireproximityprompt then return end
			
			local name = (args:nextValue() or ""):lower()
			
			for _, descendant in workspace:GetDescendants() do
				if descendant:IsA("ProximityPrompt") and matchName(descendant, name) then
					fireproximityprompt(descendant)
				end
			end
		end
	},
	{
		action = "fireclosestprompt|fcp",
		description = "Uses the closest proximity prompt to your character",
		args = {
			optional = true,
			kind = "boolean",
			name = "teleport to prompt"
		},
		run = function(self, args)
			local fireproximityprompt = self:expectExploit("fireproximityprompt")
			if not fireproximityprompt then return end
			
			local closestPrompt = getClosestPrompt(self)
			if not closestPrompt then
				self:notify("Can't find any ProximityPrompt on workspace")
				return
			end
			
			if args:nextValue() then
				teleportToPrompt(self, closestPrompt)
				task.wait(0.25)
			end
			
			fireproximityprompt(closestPrompt)
			self:notify(`fired prompt: {closestPrompt:GetFullName()}`)
		end
	},
	{
		action = "firetouchinterests|touchinterests",
		description = "Uses all touchinterests in a game or uses the optional name",
		args = {
			kind = "object",
			optional = true
		},
		run = function(self, args)
			local firetouchinterest = self:expectExploit("firetouchinterest")
			if not firetouchinterest then return end

			local root = self.playerService:getRootPart()
			if not root then return end

			local name = (args:nextValue() or ""):lower()

			for _, descendant in workspace:GetDescendants() do
				if descendant:IsA("TouchTransmitter") and descendant.Parent:IsA("BasePart") and matchName(descendant.Parent, name) then
					firetouchinterest(descendant.Parent, root, 0)
					firetouchinterest(descendant.Parent, root, 1)
				end
			end
		end
	}
}