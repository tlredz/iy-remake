-- /src/commands/cmds/teleport/pathfind.luau

local resolvePlayers = require("../../systems/resolvePlayers")
local robloxServices = require("../../../framework/services/rbxServices")

local PathfindingService = robloxServices.PathfindingService

local REPATH_DISTANCE = 5
local REPATH_INTERVAL = 2
local IDLE_CHECK = 0.2
local WAYPOINT_CHECK = 0.1
local WAYPOINT_TIMEOUT = 3

type Point = { position: Vector3, jump: boolean }

type Route = {
	goal: Vector3,
	points: { Point },
	index: number,
	computedAt: number,
}

local function cancelMovement(self)
	local root = self.playerService:getRootPart()
	local humanoid = self.playerService:getHumanoid()
	if root and humanoid then
		humanoid:MoveTo(root.Position)
	end
end

local function stopPathfind(self): boolean
	local garbage = self:collectGarbage("pathfind")
	if not garbage then return false end
	
	garbage.running = false
	cancelMovement(self)
	return true
end

local function computePoints(root: BasePart, goal: Vector3): { Point }
	local path = PathfindingService:CreatePath()
	local computed = pcall(function()
		path:ComputeAsync(root.Position, goal)
	end)
	
	if not computed or path.Status ~= Enum.PathStatus.Success then
		return { { position = goal, jump = false } }
	end
	
	local points = {}
	for _, waypoint in path:GetWaypoints() do
		table.insert(points, {
			position = waypoint.Position,
			jump = waypoint.Action == Enum.PathWaypointAction.Jump,
		})
	end
	
	if #points > 1 and (points[1].position - root.Position).Magnitude < 2 then
		table.remove(points, 1)
	end
	
	if #points == 0 then
		return { { position = goal, jump = false } }
	end
	
	return points
end

local function targetMoved(route: Route?, target: Vector3): boolean
	return route == nil or (target - route.goal).Magnitude > REPATH_DISTANCE
end

local function walkToPoint(humanoid: Humanoid, root: BasePart, point: Point, shouldStop: () -> boolean): boolean
	local finished = false
	local connection = humanoid.MoveToFinished:Connect(function()
		finished = true
	end)

	if point.jump then
		humanoid.Jump = true
	end

	humanoid:MoveTo(point.position)

	local waited = 0
	local stopped = false

	while not finished and waited < WAYPOINT_TIMEOUT and humanoid.Parent do
		if shouldStop() then
			stopped = true
			break
		end
		
		local flatDistance = Vector3.new(
			root.Position.X - point.position.X,
			0,
			root.Position.Z - point.position.Z
		).Magnitude
		
		local heightDifference = math.abs(root.Position.Y - point.position.Y)

		if flatDistance < 3 and heightDifference < 4 then
			break
		end
		
		task.wait(WAYPOINT_CHECK)
		waited += WAYPOINT_CHECK
	end

	connection:Disconnect()
	return not stopped
end

local function startPathfind(self, follow: boolean, getGoal: () -> Vector3?)
	stopPathfind(self)
	
	local garbage = self:createGarbage("pathfind")
	garbage.running = true
	
	task.spawn(function()
		local route: Route? = nil
		
		while garbage.running do
			local goal = getGoal()
			if not goal then break end
			
			local humanoid = self.playerService:getHumanoid()
			local root = self.playerService:getRootPart()
			
			if not (humanoid and root) then
				route = nil
				task.wait(IDLE_CHECK)
				continue
			end
			
			local finished = route ~= nil and route.index > #route.points
			local expired = follow and route ~= nil and not finished and os.clock() - route.computedAt > REPATH_INTERVAL
			
			if targetMoved(route, goal) or expired then
				local points = computePoints(root, goal)
				if not garbage.running then break end
				
				route = {
					goal = goal,
					points = points,
					index = 1,
					computedAt = os.clock(),
				}
			elseif finished then
				if not follow then break end
				
				task.wait(IDLE_CHECK)
			else
				local current = route :: Route
				local walked = walkToPoint(humanoid, root, current.points[current.index], function()
					if not garbage.running then return true end
					
					local now = getGoal()
					return now == nil or (follow and targetMoved(current, now))
				end)
				
				if walked then
					current.index += 1
				end
			end
		end
		
		if self:getGarbage("pathfind") == garbage then
			self:collectGarbage("pathfind")
		end
	end)
end

return {
	{
		action = "pathfindwalkto|pathfindfollow",
		description = "Follow a player using pathfinding",
		args = {
			kind = "player"
		},
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			if not target then
				self:notify("Pathfind", "player not found")
				return
			end
			
			startPathfind(self, true, function()
				local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
				return root and root.Position
			end)
		end
	},
	{
		action = "pathfindwalktowaypoint|pathfindwalktowp|pftowp",
		description = "Walk to a waypoint using pathfinding",
		args = {
			kind = "waypoint"
		},
		run = function(self, args)
			local name = args:nextValue()
			local places = self.storage.waypoints:getValue(tostring(game.PlaceId))
			local coords = type(places) == "table" and name and places[name]
			
			if not coords then
				self:notify("Pathfind", `there is no waypoint named '{name}'`)
				return
			end
			
			local position = self:unstringify(coords, "Vector3")
			startPathfind(self, false, function()
				return position
			end)
		end
	},
	{
		action = "unpathfind|nopathfind|pathfindstop",
		description = "Stops pathfindwalkto and pathfindwalktowaypoint",
		run = function(self)
			if stopPathfind(self) then
				self:notify("Pathfind", "stopped")
			else
				self:notify("Pathfind", "nothing is walking right now")
			end
		end
	}
}
