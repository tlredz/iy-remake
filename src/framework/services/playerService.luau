local robloxServices = require("./rbxServices")
local localPlayer = require("./localPlayer")
local logger = require("../../utils/logger")

local teleportService = robloxServices.TeleportService
local tweenService = robloxServices.TweenService

local playerMouse = localPlayer:GetMouse()

local playerService = {}

local activeTween: Tween? = nil
local DEFAULT_TWEEN_SPEED: number = 100
local seatedLock: { humanoid: Humanoid, wasEnabled: boolean }? = nil

function playerService:getMouse(): PlayerMouse
	return playerMouse
end

function playerService:isMouseInGuiObject(guiObject: GuiObject): boolean
	local guiPosition = guiObject.AbsolutePosition
	local guiSize = guiObject.AbsoluteSize

	return playerMouse.X >= guiPosition.X
		and playerMouse.X < guiPosition.X + guiSize.X
		and playerMouse.Y >= guiPosition.Y
		and playerMouse.Y < guiPosition.Y + guiSize.Y
end

function playerService:teleportToJobId(jobId, placeId)
	placeId = placeId or game.PlaceId
	teleportService:TeleportToPlaceInstance(placeId, jobId, localPlayer)
end

function playerService:isAlive(character: Model?): boolean
	local humanoid = if character
		then character:FindFirstChildOfClass("Humanoid")
		else self:getHumanoid()

	return humanoid ~= nil and humanoid.Health > 0
end

function playerService:getCharacter()
	return localPlayer.Character
end

function playerService:getHumanoid()
	local character = self:getCharacter()
	return character and character:FindFirstChildOfClass("Humanoid")
end

function playerService:getRootPart()
	local humanoid = self:getHumanoid()
	return humanoid and humanoid.RootPart
end

function playerService:resetCharacter()
	local character = self:getCharacter()
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	else
		character:BreakJoints()
	end
end

function playerService:getPlayersByName(query: string): { Player }
	local list = {}

	local subAt = #query
	query = query:lower()

	for _, player in robloxServices.Players:GetPlayers() do
		local name = string.lower(player.Name):sub(1, subAt)
		local displayName = string.lower(player.displayName):sub(1, subAt)

		if name == query or displayName == query then
			table.insert(list, player)
		end
	end

	return list
end

function playerService:getCamera()
	return workspace.CurrentCamera
end

function playerService:unseat(): Humanoid?
	local humanoid = self:getHumanoid()
	if not humanoid then return nil end

	if humanoid.SeatPart ~= nil then
		humanoid.Sit = false
		task.wait(0.1)
	end

	return self:getHumanoid()
end

function playerService:setRootCFrame(cframe: CFrame): boolean
	local rootPart = self:getRootPart()
	if not rootPart then return false end

	rootPart.CFrame = cframe
	rootPart.AssemblyLinearVelocity = Vector3.zero
	return true
end

function playerService:teleportTo(target: CFrame | Vector3): boolean
	logger:expect(target, { "CFrame", "Vector3" }, "'playerService:teleportTo' #1")

	if typeof(target) == "Vector3" then
		target = CFrame.new(target)
	end

	self:unseat()
	return self:setRootCFrame(target)
end

function playerService:breakVelocity(duration: number?)
	local character = self:getCharacter()
	if not character then return end

	local endsAt = os.clock() + (duration or 1)
	task.spawn(function()
		while os.clock() < endsAt and character.Parent do
			for _, part in character:GetDescendants() do
				if part:IsA("BasePart") then
					part.AssemblyLinearVelocity = Vector3.zero
					part.AssemblyAngularVelocity = Vector3.zero
				end
			end
			task.wait()
		end
	end)
end

local function releaseSeated()
	local lock = seatedLock
	seatedLock = nil

	if lock and lock.humanoid.Parent then
		lock.humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, lock.wasEnabled)
	end
end

local function lockSeated(humanoid: Humanoid)
	if seatedLock and seatedLock.humanoid == humanoid then return end

	releaseSeated()
	seatedLock = {
		humanoid = humanoid,
		wasEnabled = humanoid:GetStateEnabled(Enum.HumanoidStateType.Seated)
	}
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end

function playerService:cancelTween(): boolean
	local tween = activeTween
	activeTween = nil

	releaseSeated()

	if tween then
		tween:Cancel()
		return true
	end

	return false
end

function playerService:tweenTeleportTo(config: { target: CFrame | Vector3, speed: number? }): Tween?
	logger:expect(config, { "table" }, "'playerService:tweenTeleportTo' #1")

	local target = config.target
	local speed = config.speed or DEFAULT_TWEEN_SPEED

	logger:expect(target, { "CFrame", "Vector3" }, "'playerService:tweenTeleportTo' config.target")
	logger:expect(speed, { "number" }, "'playerService:tweenTeleportTo' config.speed")

	if typeof(target) == "Vector3" then
		target = CFrame.new(target)
	end

	self:unseat()

	local rootPart = self:getRootPart()
	if not rootPart then return nil end

	local distance = (target.Position - rootPart.Position).Magnitude
	local duration = distance / math.max(speed, 1)

	local previous = activeTween
	activeTween = nil
	if previous then
		previous:Cancel()
	end

	local humanoid = self:getHumanoid()
	if humanoid then
		lockSeated(humanoid)
	end

	local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
	local tween = tweenService:Create(rootPart, info, {
		CFrame = target
	})

	activeTween = tween
	tween.Completed:Once(function()
		if activeTween ~= tween then return end
		
		activeTween = nil
		releaseSeated()
		self:breakVelocity()
	end)

	tween:Play()
	return tween
end

function playerService:waitForStreamPlayerCharacter(character: Model, waitTime: number?): ()
	if not (character and workspace.StreamingEnabled) then return end

	local targetPosition = character:GetPivot().Position
	waitTime = waitTime or 5

	task.spawn(localPlayer.RequestStreamAroundAsync, localPlayer, targetPosition, waitTime)
	character:WaitForChild("HumanoidRootPart", waitTime)
end

return playerService
