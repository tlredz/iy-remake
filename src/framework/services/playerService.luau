local robloxServices = require("./rbxServices")
local localPlayer = require("./localPlayer")
local logger = require("../../utils/logger")

local teleportService = robloxServices.TeleportService
local tweenService = robloxServices.TweenService

local playerMouse = localPlayer:GetMouse()

local playerService = {}

-- The tween that is moving the character right now, if any. Only one tween runs at a time.
local activeTween: Tween? = nil

function playerService:getMouse()
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

-- Takes the character off its seat and waits a moment, so the seat does not drag it along.
-- Returns the humanoid as it is after the wait (the character may have changed while waiting).
function playerService:unseat(): Humanoid?
	local humanoid = self:getHumanoid()
	if not humanoid then return nil end

	if humanoid.SeatPart ~= nil then
		humanoid.Sit = false
		task.wait(0.1)
	end

	return self:getHumanoid()
end

-- Puts the root part at a CFrame right away: no un-seating and no waiting, so it is safe to call
-- every frame (loops). Returns false when there is no root part to move.
function playerService:setRootCFrame(cframe: CFrame): boolean
	local rootPart = self:getRootPart()
	if not rootPart then return false end

	rootPart.CFrame = cframe
	rootPart.AssemblyLinearVelocity = Vector3.zero
	return true
end

-- Instant teleport to a CFrame, or to a Vector3 (which gets no rotation). Un-seats the character first.
-- Returns true when the character was moved.
function playerService:teleportTo(target: CFrame | Vector3): boolean
	logger:expect(target, { "CFrame", "Vector3" }, "'playerService:teleportTo' #1")

	if typeof(target) == "Vector3" then
		target = CFrame.new(target)
	end

	self:unseat()
	return self:setRootCFrame(target)
end

-- Zeroes the velocity of every part of the character for `duration` seconds (default 1).
-- The loop runs in its own thread, so it returns right away.
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

-- While a tween runs, the Seated state is turned off, so touching a seat does not sit the
-- character and stop the tween. The previous value is kept and put back when the tween ends.
local seatedLock: { humanoid: Humanoid, wasEnabled: boolean }? = nil

local function releaseSeated()
	local lock = seatedLock
	seatedLock = nil

	if lock and lock.humanoid.Parent then
		lock.humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, lock.wasEnabled)
	end
end

local function lockSeated(humanoid: Humanoid)
	-- a tween that replaces another one keeps the value saved by the first
	if seatedLock and seatedLock.humanoid == humanoid then return end

	releaseSeated()
	seatedLock = {
		humanoid = humanoid,
		wasEnabled = humanoid:GetStateEnabled(Enum.HumanoidStateType.Seated)
	}
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end

-- Stops the tween that is running, if any. Returns true when a tween was stopped.
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

-- Studs per second, used when a tween does not give its own speed
local DEFAULT_TWEEN_SPEED = 100

-- Tween teleport. config.target is a CFrame or Vector3, config.speed is in studs per second
-- (default 100). The time is the distance to the target divided by the speed.
-- The Seated state is off while it runs and the velocity is broken at the end.
-- A new tween replaces the one that is running. Returns the tween, or nil when the character has no root part.
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

	-- Speed is at least 1 stud per second, so a tiny or negative speed still ends
	local distance = (target.Position - rootPart.Position).Magnitude
	local duration = distance / math.max(speed, 1)

	-- replaces the running tween without giving the Seated state back in between
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
		-- a tween that was replaced or cancelled has already been taken care of
		if activeTween ~= tween then return end

		activeTween = nil
		releaseSeated()
		self:breakVelocity()
	end)

	tween:Play()
	return tween
end

-- Streams the area around a character before teleporting there, when the game uses streaming.
-- Waits up to waitTime seconds (default 5) for its root part. The caller decides whether to call it.
function playerService:waitForStreamPlayerCharacter(character: Model, waitTime: number?): ()
	if not (character and workspace.StreamingEnabled) then return end

	local targetPosition = character:GetPivot().Position
	waitTime = waitTime or 5

	task.spawn(localPlayer.RequestStreamAroundAsync, localPlayer, targetPosition, waitTime)
	character:WaitForChild("HumanoidRootPart", waitTime)
end

return playerService
