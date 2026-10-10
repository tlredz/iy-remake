local argsManager = require("../../systems/argsManager")

local FLING_PHYSICAL_PROPERTY = PhysicalProperties.new(100, 0.3, 0.5)

local function createFlingTemplate()
	local bodyVelocity = Instance.new("BodyAngularVelocity")
	bodyVelocity.MaxTorque = Vector3.yAxis * math.huge
	bodyVelocity.P = math.huge
	return bodyVelocity
end

local function flingRun(self, args)
	if self:hasGarbage("fling") then
		self:notify("fling is already enabled\ndisable using 'unfling'")
		return
	end
	
	local humanoid = self.playerService:getHumanoid()
	if not (humanoid and humanoid.Health ~= 0) then return end
	
	local character = humanoid.Parent
	
	self:notify("fling now is activated")
	self:run("noclip")
	
	local garbage = self:createGarbage("fling")
	garbage.originalStates = {}
	
	for _, part in character:GetDescendants() do
		if not part:IsA("BasePart") then continue end
		
		garbage.originalStates[part] = {
			CustomPhysicalProperties = part.CustomPhysicalProperties,
			CanCollide = part.CanCollide,
			Massless = part.Massless
		}
		
		part.CustomPhysicalProperties = FLING_PHYSICAL_PROPERTY
		
		if part.Parent == character then
			part.CanCollide = false
			part.Massless = true
			part.Velocity = Vector3.zero
		end
	end
	
	local bodyVelocity = createFlingTemplate()
	
	garbage.flingVelocity = bodyVelocity
	garbage.flingConnection = humanoid.Died:Once(function()
		self:notify("player died: disabling fling...")
		self:run("unfling")
	end)
	
	bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
	
	while bodyVelocity and character and character.Parent do
		bodyVelocity.AngularVelocity = Vector3.yAxis * 99999
		task.wait(0.2)
		bodyVelocity.AngularVelocity = Vector3.one
		task.wait(0.1)
	end
end

local function unflingRun(self)
	local garbage = self:collectGarbage("fling")
	if not garbage then return end
	
	if garbage.flingVelocity then
		garbage.flingVelocity:Destroy()
	end
	
	if garbage.flingConnection then
		garbage.flingConnection:Disconnect()
	end
	
	for object, properties in garbage.originalStates do
		for property, value in properties do
			object[property] = value
		end
	end
	
	self:notify("fling disabled")
end

-- walkfling: flings you every frame without the spin (IY's walkfling).
-- IY resets its offset on every pass, so the offset is always +0.1 here too.
local WALKFLING_OFFSET = 0.1

local function isLive(character, root): boolean
	return character ~= nil and character.Parent ~= nil and root ~= nil and root.Parent ~= nil
end

local function walkflingRun(self)
	if self:hasGarbage("walkfling") then
		self:notify("walkfling is already enabled\ndisable using 'unwalkfling'")
		return
	end

	local garbage = self:createGarbage("walkfling")

	-- Only turn noclip on here if it was not already on, so unwalkfling leaves a manual noclip alone
	if not self:hasGarbage("noclip") then
		self:run("noclip")
		garbage.enabledNoclip = true
	end

	local runService = self.runService
	local function isActive(): boolean
		return self:getGarbage("walkfling") == garbage
	end

	garbage.thread = task.spawn(function()
		while isActive() do
			runService.Heartbeat:Wait()

			local character = self.playerService:getCharacter()
			local root = character and character:FindFirstChild("HumanoidRootPart")

			while isActive() and not isLive(character, root) do
				runService.Heartbeat:Wait()
				character = self.playerService:getCharacter()
				root = character and character:FindFirstChild("HumanoidRootPart")
			end

			if not isActive() then break end

			local velocity = root.AssemblyLinearVelocity
			root.AssemblyLinearVelocity = velocity * 10000 + Vector3.new(0, 10000, 0)

			runService.RenderStepped:Wait()
			if isLive(character, root) then
				root.AssemblyLinearVelocity = velocity
			end

			runService.Stepped:Wait()
			if isLive(character, root) then
				root.AssemblyLinearVelocity = velocity + Vector3.new(0, WALKFLING_OFFSET, 0)
			end
		end
	end)

	-- Same as IY: when you die, walkfling turns itself off
	local humanoid = self.playerService:getHumanoid()
	if humanoid then
		garbage.diedConnection = self:connect(humanoid.Died, function()
			self:run("unwalkfling")
		end)
	end
end

local function unwalkflingRun(self)
	local garbage = self:collectGarbage("walkfling")
	if not garbage then return end

	if garbage.diedConnection then
		garbage.diedConnection:Disconnect()
	end

	if garbage.enabledNoclip then
		self:run("unnoclip")
	end
end

local function flyflingRun(self, args)
	self:run("unvehiclefly")
	self:run("unwalkfling")

	local speed = args and args:nextValue()
	if speed then
		self.privateEnv.vehicleFlySpeed = speed
	end

	-- vehiclefly with no argument uses the speed we just stored
	self:run("vehiclefly", argsManager.new({}))
	walkflingRun(self)
end

local function unflyflingRun(self)
	self:run("unvehiclefly")
	self:run("unwalkfling")
	self:run("breakvelocity")
end

return {
	{
		action = "fling|forcefling",
		description = "Flings anyone you touch",
		run = flingRun
	},
	{
		action = "unfling",
		description = "Disables the fling command",
		run = unflingRun
	},
	{
		action = "flyfling",
		description = "Basically the invisfling command but not invisible",
		args = {
			kind = "number",
			name = "speed",
			optional = true
		},
		run = flyflingRun
	},
	{
		action = "unflyfling",
		description = "Disables the flyfling command",
		run = unflyflingRun
	},
	{
		action = "walkfling",
		description = "Basically fling but no spinning",
		run = walkflingRun
	},
	{
		action = "unwalkfling|nowalkfling",
		description = "Disables walkfling",
		run = unwalkflingRun
	},
	{
		action = "invisfling",
		description = "Enables invisible fling (the invis part is patched, try using the god command before using this)",
		run = function(self)
			self:run("invisible")
			-- fling loops until the character is gone, so it runs in its own thread
			task.spawn(function()
				self:run("fling")
			end)
		end
	},
	{
		action = "antifling",
		description = "Disables player collisions to prevent you from being flung",
		run = function(self)
			if self:hasGarbage("antifling") then return end

			local garbage = self:createGarbage("antifling")
			garbage.connection = self:connect(self.runService.Stepped, function()
				for _, player in self.players:GetPlayers() do
					if player ~= self.localPlayer and player.Character then
						for _, part in player.Character:GetDescendants() do
							if part:IsA("BasePart") then
								part.CanCollide = false
							end
						end
					end
				end
			end)
		end
	},
	{
		action = "unantifling",
		description = "Disables antifling",
		run = function(self)
			local garbage = self:collectGarbage("antifling")
			if garbage then
				garbage.connection:Disconnect()
			end
		end
	}
}
