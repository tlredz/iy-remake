local resolvePlayers = require("../../systems/resolvePlayers")

local function stopOrbit(self)
	local garbage = self:collectGarbage("orbit")
	if not garbage then return end

	for _, connection in garbage.connections do
		connection:Disconnect()
	end
end

return {
	{
		action = "orbit",
		description = "Makes your character orbit around a player with an optional speed and an optional distance",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "speed",
				optional = true
			},
			{
				kind = "number",
				name = "distance",
				optional = true
			}
		},
		run = function(self, args)
			stopOrbit(self)

			local target = resolvePlayers(args:nextValue())[1]
			local speed = args:nextValue() or 0.2
			local distance = args:nextValue() or 6

			local humanoid = self.playerService:getHumanoid()
			if not (target and humanoid) then return end

			local garbage = self:createGarbage("orbit")
			garbage.connections = {}

			local rotation = 0

			local function getTargetRoot()
				return target.Character and target.Character:FindFirstChild("HumanoidRootPart")
			end

			table.insert(garbage.connections, self:connect(self.runService.Heartbeat, function()
				local root = self.playerService:getRootPart()
				local targetRoot = getTargetRoot()
				if not (root and targetRoot) then return end

				rotation += speed
				root.CFrame = CFrame.new(targetRoot.Position) * CFrame.Angles(0, math.rad(rotation), 0) * CFrame.new(distance, 0, 0)
			end))

			-- Keeps the character facing the target while it orbits
			table.insert(garbage.connections, self:connect(self.runService.RenderStepped, function()
				local root = self.playerService:getRootPart()
				local targetRoot = getTargetRoot()
				if root and targetRoot then
					root.CFrame = CFrame.new(root.Position, targetRoot.Position)
				end
			end))

			table.insert(garbage.connections, self:connect(humanoid.Died, function()
				stopOrbit(self)
			end))

			table.insert(garbage.connections, self:connect(humanoid.Seated, function(active)
				if active then
					stopOrbit(self)
				end
			end))

			self:notify("Orbit", "Started orbiting " .. target.Name)
		end
	},
	{
		action = "unorbit",
		description = "Disables orbit",
		run = function(self)
			if not self:hasGarbage("orbit") then return end

			stopOrbit(self)
			self:notify("Orbit", "Stopped orbiting player")
		end
	}
}
