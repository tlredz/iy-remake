-- src/commands/systems/waypoints.luau
-- Waypoints: the positions saved for each game, and the markers that show them in the world.
--
-- They are saved in storage/data/waypoints as { [placeId] = { [name] = "x y z" } }, so each game keeps its own list.
-- The waypoint commands (cmds/waypoints) and the settings page (ui/components/settings/waypointsEditor) both use this
-- module, so a waypoint made in one shows up in the other at once.
--
-- This module never requires commandsController or list.luau (the bundler rejects require cycles). The markers are kept
-- in the same garbage table the commands use (privateEnv.iyGarbages), and what happens is returned for the caller to
-- tell the player: this module does not notify.

local waypointsData = require("../../storage/data/waypoints")
local privateEnv = require("../../framework/environment/private")
local playerService = require("../../framework/services/playerService")
local stringifier = require("../../utils/stringifier")

local SHOWN_GARBAGE = "showingWaypoints"

-- the same table commandsController keeps its garbage in
local garbages = privateEnv.iyGarbages or {}
privateEnv.iyGarbages = garbages

export type Waypoint = { name: string, position: Vector3 }

local waypoints = {}

local function placeKey(): string
	return tostring(game.PlaceId)
end

-- The live table of this game's waypoints (name -> "x y z"). With `create` it is made when missing, otherwise it can be nil.
local function getPlace(create: boolean?): { [string]: string }?
	if create then
		return waypointsData:register(placeKey(), {})
	end

	local place = waypointsData:getValue(placeKey())
	return if type(place) == "table" then place else nil
end

local function countEntries(place: any): number
	local count = 0

	if type(place) == "table" then
		for _ in place do
			count += 1
		end
	end

	return count
end

-- "x y z" as it is saved -> Vector3. Nil when the saved text is not three numbers
local function readPosition(coords: any): Vector3?
	if type(coords) ~= "string" then return nil end

	local success, position = pcall(stringifier.unstringify, stringifier, coords, "Vector3")
	if success and typeof(position) == "Vector3" then
		return position
	end

	return nil
end

-- Every valid waypoint of this game, sorted by name. A saved entry that can't be read is left out
function waypoints.list(): { Waypoint }
	local list = {}

	for name, coords in getPlace() or {} do
		local position = readPosition(coords)

		if position then
			table.insert(list, { name = name, position = position })
		end
	end

	table.sort(list, function(a, b)
		return a.name:lower() < b.name:lower()
	end)

	return list
end

-- Finds a waypoint of this game by name, ignoring case (like the argument validator does)
function waypoints.find(name: string): Waypoint?
	local lowered = name:lower()

	for _, waypoint in waypoints.list() do
		if waypoint.name:lower() == lowered then
			return waypoint
		end
	end

	return nil
end

-- How many waypoints this game has
function waypoints.count(): number
	return countEntries(getPlace())
end

-- How many waypoints there are in every game
function waypoints.countAll(): number
	local total = 0

	for _, place in waypointsData:getData() do
		total += countEntries(place)
	end

	return total
end

-- Saves a waypoint. Names ignore case, so "Home" replaces "home" instead of creating a second one that the
-- validator could not tell apart. Returns true when it replaced one that was there
function waypoints.save(name: string, position: Vector3): boolean
	local place = getPlace(true) :: { [string]: string }
	local lowered = name:lower()
	local replaced = false

	for storedName in place do
		if storedName:lower() == lowered then
			place[storedName] = nil
			replaced = true
		end
	end

	place[name] = stringifier:stringify(position) :: string
	waypointsData:save()

	return replaced
end

-- Deletes a waypoint of this game by name. Returns false when there was none
function waypoints.remove(name: string): boolean
	local place: any = getPlace()
	local lowered = name:lower()
	local removed = false

	if type(place) == "table" then
		for storedName in place do
			if storedName:lower() == lowered then
				place[storedName] = nil
				removed = true
			end
		end
	end

	if removed then
		waypointsData:save()
	end

	return removed
end

-- Deletes every waypoint of this game and returns how many there were
function waypoints.clearPlace(): number
	local count = waypoints.count()

	waypointsData:setValue(placeKey(), nil)
	waypointsData:save()

	return count
end

-- Deletes the waypoints of every game and returns how many there were
function waypoints.clearAll(): number
	local total = 0

	-- getData is a copy of the top level, so removing from the data while looping is safe
	for key, place in waypointsData:getData() do
		total += countEntries(place)
		waypointsData:setValue(key, nil)
	end

	waypointsData:save()

	return total
end

-- (10, 5, -20)
function waypoints.format(position: Vector3): string
	return `({math.round(position.X)}, {math.round(position.Y)}, {math.round(position.Z)})`
end

-- "10, 5, -20" and "10 5 -20" -> Vector3. Nil when the text is not three numbers
function waypoints.parsePosition(text: string): Vector3?
	local numbers = {}

	for piece in text:gmatch("[^%s,;]+") do
		local number = tonumber(piece)

		if number == nil or number ~= number or math.abs(number) == math.huge then
			return nil
		end

		table.insert(numbers, number)
	end

	if #numbers ~= 3 then
		return nil
	end

	return Vector3.new(numbers[1], numbers[2], numbers[3])
end

-- Goes to a waypoint. mode is "teleport" (right away), "tween" (a smooth trip at the tween speed) or "walk"
-- (the character walks there). Returns true when the character started to move, false when it has no body
function waypoints.go(waypoint: Waypoint, mode: string?, speed: number?): boolean
	if mode == "tween" then
		speed = if typeof(speed) == "number" then speed else nil
		
		local tween = playerService:tweenTeleportTo({
			target = CFrame.new(waypoint.position),
			speed = speed or privateEnv.tweenSpeed,
		})
		
		return tween ~= nil
	end
	
	if mode == "walk" then
		local humanoid = playerService:unseat()
		if not humanoid then return false end
		
		humanoid:MoveTo(waypoint.position)
		return true
	end
	
	return playerService:teleportTo(CFrame.new(waypoint.position))
end

-- the markers --------------------------------------------------------------------------------------------------------

function waypoints.isShown(): boolean
	return garbages[SHOWN_GARBAGE] ~= nil
end

-- Removes the markers from the world. Returns true when they were showing
function waypoints.hide(): boolean
	local markers = garbages[SHOWN_GARBAGE]
	if markers == nil then return false end

	garbages[SHOWN_GARBAGE] = nil

	for _, marker in markers do
		marker:Destroy()
	end

	return true
end

local function createMarker(waypoint: Waypoint): Part
	local part = Instance.new("Part")
	part.Size = Vector3.new(5, 5, 5)
	part.CFrame = CFrame.new(waypoint.position)
	part.Anchored = true
	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false
	part.Parent = workspace

	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = part
	box.AlwaysOnTop = true
	box.ZIndex = 10
	box.Size = part.Size
	box.Parent = part

	local billboard = Instance.new("BillboardGui")
	billboard.Adornee = part
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.fromOffset(160, 30)
	billboard.StudsOffset = Vector3.new(0, 4, 0)
	billboard.Parent = part

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Text = waypoint.name
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 0
	label.TextScaled = true
	label.Parent = billboard

	return part
end

-- Draws a marker for every waypoint of this game, replacing the ones that were showing. Returns how many were drawn
function waypoints.show(): number
	waypoints.hide()

	local markers = {}
	local list = waypoints.list()

	for _, waypoint in list do
		table.insert(markers, createMarker(waypoint))
	end

	garbages[SHOWN_GARBAGE] = markers
	return #list
end

-- Keeps the markers in sync after a change, but only while they are showing
function waypoints.refreshMarkers()
	if waypoints.isShown() then
		waypoints.show()
	end
end

return waypoints
