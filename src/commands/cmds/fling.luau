local FLING_PHYSICAL_PROPERTY = PhysicalProperties.new(100, 0.3, 0.5)

local function createFlingTemplate()
	local bodyVelocity = Instance.new("BodyAngularVelocity")
	bodyVelocity.MaxTorque = Vector3.yAxis * math.huge
	bodyVelocity.P = math.huge
	return bodyVelocity
end

return function(self, args)
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