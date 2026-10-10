-- pathfindwalkto follows a player and pathfindwalktowaypoint walks to a waypoint, both with PathfindingService.
-- Starting one of them replaces the one already running.

local resolvePlayers = require("../../systems/resolvePlayers")
local robloxServices = require("../../../framework/services/rbxServices")

local PathfindingService = robloxServices.PathfindingService

local REPATH_DELAY = 0.5 -- how often a followed player's path is computed again
local WAYPOINT_TIMEOUT = 3 -- seconds before a waypoint is skipped if the character never gets there

-- Moving to the spot we are already on cancels the walk in progress
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

-- Walks from the root to `goal`, waypoint by waypoint. Falls back to a straight MoveTo when there is no path.
local function walkTo(self, garbage, goal: Vector3)
	local humanoid = self.playerService:getHumanoid()
	local root = self.playerService:getRootPart()
	if not (humanoid and root) then return end

	local path = PathfindingService:CreatePath()
	local computed = pcall(function()
		path:ComputeAsync(root.Position, goal)
	end)

	if not computed or path.Status ~= Enum.PathStatus.Success then
		humanoid:MoveTo(goal)
		task.wait(REPATH_DELAY)
		return
	end

	for _, waypoint in path:GetWaypoints() do
		if not (garbage.running and humanoid.Parent) then return end

		if waypoint.Action == Enum.PathWaypointAction.Jump then
			humanoid.Jump = true
		end

		local finished = false
		local connection = humanoid.MoveToFinished:Connect(function()
			finished = true
		end)

		humanoid:MoveTo(waypoint.Position)

		local waited = 0
		while garbage.running and not finished and waited < WAYPOINT_TIMEOUT do
			task.wait(0.1)
			waited += 0.1
		end

		connection:Disconnect()
	end
end

-- getGoal returns the position to walk to, or nil when there is nothing left to walk to.
-- A follow keeps going until it is stopped, a waypoint walk ends after one path.
local function startPathfind(self, follow: boolean, getGoal: () -> Vector3?)
	stopPathfind(self)

	local garbage = self:createGarbage("pathfind")
	garbage.running = true

	task.spawn(function()
		while garbage.running do
			local goal = getGoal()
			if not goal then break end

			walkTo(self, garbage, goal)

			if not follow then break end
			task.wait(REPATH_DELAY)
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
