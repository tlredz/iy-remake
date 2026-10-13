-- /src/commands/cmds/character/autofling.luau

local DEFAULT_RADIUS = 5
local MIN_RADIUS = 1
local CHECK_COOLDOWN = 0.1
local LINGER = 1

local function someoneWithin(self, position: Vector3, radius: number): boolean
	for _, player in self.players:GetPlayers() do
		if player == self.localPlayer then continue end
		
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		
		if root and humanoid and humanoid.Health > 0 and (root.Position - position).Magnitude <= radius then
			return true
		end
	end
	
	return false
end

local function runFlingCommand(self, name: string)
	local command = self.commandsList.lookup[name]
	if command and command.run then
		command.run(self)
	end
end

local function flingOn(self, garbage)
	if self:hasGarbage("fling") then return end

	runFlingCommand(self, "fling")

	local flingGarbage = self:getGarbage("fling")
	if flingGarbage then
		garbage.flingGarbage = flingGarbage
	end
end

local function flingOff(self, garbage)
	local flingGarbage = garbage.flingGarbage
	garbage.flingGarbage = nil

	if flingGarbage and self:getGarbage("fling") == flingGarbage then
		runFlingCommand(self, "unfling")
	end
end

local function clearTouches(garbage)
	for _, connection in garbage.touchConnections do
		connection:Disconnect()
	end
	table.clear(garbage.touchConnections)
end

local function watchTouches(self, garbage, character: Model)
	clearTouches(garbage)
	
	local function onTouched(hit: BasePart)
		local model = hit:FindFirstAncestorOfClass("Model")
		if not model or model == character then return end
		
		local player = self.players:GetPlayerFromCharacter(model)
		if not player or player == self.localPlayer then return end
		
		garbage.lastContact = os.clock()
		flingOn(self, garbage)
	end
	
	local function watchPart(part: Instance)
		if part:IsA("BasePart") then
			table.insert(garbage.touchConnections, self:connect(part.Touched, onTouched))
		end
	end
	
	for _, part in character:GetDescendants() do
		watchPart(part)
	end
	
	table.insert(garbage.touchConnections, self:connect(character.DescendantAdded, watchPart))
end

local function check(self, garbage)
	if self:getGarbage("autofling") ~= garbage then return end
	
	local root = self.playerService:getRootPart()
	if root and someoneWithin(self, root.Position, garbage.radius) then
		garbage.lastContact = os.clock()
	end
	
	if os.clock() - garbage.lastContact <= LINGER then
		flingOn(self, garbage)
	else
		flingOff(self, garbage)
	end
end

local function startAutoFling(self, radius: number)
	local garbage = self:createGarbage("autofling")
	garbage.radius = radius
	garbage.lastContact = -math.huge
	garbage.connections = {}
	garbage.touchConnections = {}
	
	garbage.loopId = self.loopService:add(function()
		check(self, garbage)
	end, CHECK_COOLDOWN)
	
	table.insert(garbage.connections, self:connect(self.localPlayer.CharacterAdded, function(character: Model)
		watchTouches(self, garbage, character)
	end))
	
	local character = self.playerService:getCharacter()
	if character then
		watchTouches(self, garbage, character)
	end
end

local function stopAutoFling(self): boolean
	local garbage = self:collectGarbage("autofling")
	if not garbage then return false end
	
	self.loopService:remove(garbage.loopId)
	
	for _, connection in garbage.connections do
		connection:Disconnect()
	end
	clearTouches(garbage)
	
	flingOff(self, garbage)
	return true
end

return {
	{
		action = "autofling|guardfling|touchfling",
		description = "Turns fling on by itself when someone comes near you (default 10 studs) or touches you",
		args = {
			kind = "number",
			name = "distance",
			optional = true
		},
		run = function(self, args)
			local radius = math.max(args:nextValue() or DEFAULT_RADIUS, MIN_RADIUS)
			
			local garbage = self:getGarbage("autofling")
			if garbage then
				garbage.radius = radius
				self:notify("autofling", `radius is now {radius} studs`)
				return
			end
			
			startAutoFling(self, radius)
			self:notify("autofling enabled", `fling turns on when someone is within {radius} studs or touches you`)
		end
	},
	{
		action = "unautofling|noautofling|untouchfling",
		description = "Disables autofling",
		run = function(self)
			if stopAutoFling(self) then
				self:notify("autofling disabled")
			end
		end
	},
	{
		action = "toggleautofling|toggletouchfling",
		description = "Toggles autofling",
		run = function(self)
			self:run(if self:hasGarbage("autofling") then "unautofling" else "autofling")
		end
	}
}
