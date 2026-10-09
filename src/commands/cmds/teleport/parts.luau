-- Moves the character to a CFrame, either instantly or with a tween.
-- Waits a little first (and un-seats the character) like the original IY.
local function travelTo(self, targetCFrame: CFrame, tween: boolean)
	local humanoid = self.playerService:getHumanoid()
	if humanoid and humanoid.SeatPart then
		humanoid.Sit = false
		task.wait(0.1)
	end
	
	task.wait(self.privateEnv.gotopartDelay or 0.1)
	
	local root = self.playerService:getRootPart()
	if not root then return end
	
	if tween then
		local info = TweenInfo.new(self.privateEnv.tweenSpeed or 1, Enum.EasingStyle.Linear)
		self.robloxServices.TweenService:Create(root, info, { CFrame = targetCFrame }):Play()
	else
		root.CFrame = targetCFrame
	end
end

-- config: action, description, kind, argName, className, field ("Name" or "ClassName"), cframeOf, tween
local function createGotoCommand(config)
	return {
		action = config.action,
		description = config.description,
		args = { kind = config.kind, name = config.argName },
		run = function(self, args)
			local query = (args:nextValue() or ""):lower()
			
			for _, object in workspace:GetDescendants() do
				if object:IsA(config.className) and object[config.field]:lower() == query then
					travelTo(self, config.cframeOf(object), config.tween)
				end
			end
		end
	}
end

-- config: action, description, kind, argName, className, field
local function createBringCommand(config)
	return {
		action = config.action,
		description = config.description,
		args = { kind = config.kind, name = config.argName },
		run = function(self, args)
			local query = (args:nextValue() or ""):lower()
			local root = self.playerService:getRootPart()
			if not root then return end
			
			for _, object in workspace:GetDescendants() do
				if object:IsA(config.className) and object[config.field]:lower() == query then
					object.CFrame = root.CFrame
				end
			end
		end
	}
end

local function partCFrame(object)
	return object.CFrame
end

local function modelCFrame(object)
	return object:GetPivot()
end

return {
	createGotoCommand({
		action = "gotopart|topart",
		description = "Teleports you to every part with the given name",
		kind = "string", argName = "part name",
		className = "BasePart", field = "Name", cframeOf = partCFrame, tween = false
	}),
	createGotoCommand({
		action = "tweengotopart|tgotopart|ttopart",
		description = "Tweens you to every part with the given name",
		kind = "string", argName = "part name",
		className = "BasePart", field = "Name", cframeOf = partCFrame, tween = true
	}),
	createGotoCommand({
		action = "gotopartclass|gpc",
		description = "Teleports you to every part with the given class name",
		kind = "className", argName = "class name",
		className = "BasePart", field = "ClassName", cframeOf = partCFrame, tween = false
	}),
	createGotoCommand({
		action = "tweengotopartclass|tgpc",
		description = "Tweens you to every part with the given class name",
		kind = "className", argName = "class name",
		className = "BasePart", field = "ClassName", cframeOf = partCFrame, tween = true
	}),
	createGotoCommand({
		action = "gotomodel|tomodel",
		description = "Teleports you to every model with the given name",
		kind = "string", argName = "model name",
		className = "Model", field = "Name", cframeOf = modelCFrame, tween = false
	}),
	createGotoCommand({
		action = "tweengotomodel|tgotomodel|ttomodel",
		description = "Tweens you to every model with the given name",
		kind = "string", argName = "model name",
		className = "Model", field = "Name", cframeOf = modelCFrame, tween = true
	}),
	createBringCommand({
		action = "bringpart",
		description = "Brings every part with the given name to you",
		kind = "string", argName = "part name",
		className = "BasePart", field = "Name"
	}),
	createBringCommand({
		action = "bringpartclass|bpc",
		description = "Brings every part with the given class name to you",
		kind = "className", argName = "class name",
		className = "BasePart", field = "ClassName"
	}),
	{
		action = "gotopartdelay",
		description = "Sets the delay before the goto part commands teleport (default is 0.1)",
		args = { kind = "number", name = "delay", optional = true },
		run = function(self, args)
			self.privateEnv.gotopartDelay = args:nextValue() or 0.1
		end
	}
}
