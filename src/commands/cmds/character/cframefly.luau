local DEFAULT_SPEED = 50

-- Stops the cframe fly and gives the character back.
local function stopCFrameFly(self)
	local garbage = self:collectGarbage("cframefly")
	if not garbage then return end

	garbage.connection:Disconnect()
	garbage.humanoid.PlatformStand = false
	garbage.head.Anchored = false
end

-- Moves the head with CFrame every frame, which bypasses some anti cheats and works on mobile.
local function startCFrameFly(self)
	stopCFrameFly(self)

	local humanoid = self.playerService:getHumanoid()
	local character = self.playerService:getCharacter()
	local head = character and character:FindFirstChild("Head")
	if not (humanoid and head) then
		self:notify("cframefly", "your character is not loaded")
		return
	end

	humanoid.PlatformStand = true
	head.Anchored = true

	local garbage = self:createGarbage("cframefly")
	garbage.humanoid = humanoid
	garbage.head = head
	garbage.connection = self:connect(self.runService.Heartbeat, function(deltaTime)
		if not head:IsDescendantOf(workspace) then
			stopCFrameFly(self)
			return
		end

		local speed = self.privateEnv.cframeFlySpeed or DEFAULT_SPEED
		local moveDirection = humanoid.MoveDirection * (speed * deltaTime)

		local headCFrame = head.CFrame
		local cameraCFrame = workspace.CurrentCamera.CFrame
		local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
		cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)

		local cameraPosition = cameraCFrame.Position
		local headPosition = headCFrame.Position
		local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)

		head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
	end)
end

return {
	{
		action = "cframefly|cfly",
		description = "Makes you fly, bypassing some anti cheats (works on mobile)",
		args = {
			kind = "number",
			name = "speed",
			optional = true
		},
		run = function(self, args)
			local speed = args:nextValue()
			if speed then
				self.privateEnv.cframeFlySpeed = speed
			end
			startCFrameFly(self)
		end
	},
	{
		action = "cframeflyspeed|cflyspeed",
		description = "Sets cfly speed",
		args = {
			kind = "number"
		},
		run = function(self, args)
			self.privateEnv.cframeFlySpeed = args:nextValue() or DEFAULT_SPEED
		end
	},
	{
		action = "uncframefly|uncfly",
		description = "Disables cfly",
		run = function(self)
			stopCFrameFly(self)
		end
	}
}
