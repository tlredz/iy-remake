local resolvePlayers = require("../../systems/resolvePlayers")
local freecam = require("../../systems/freecam")

-- What the camera should follow for a player: the Humanoid when there is one, otherwise the character
local function getSubject(character: Model?)
	if not character then return nil end
	return character:FindFirstChildOfClass("Humanoid") or character
end

local function setSubject(self, subject)
	local camera = self.playerService:getCamera()
	if subject and camera.CameraSubject ~= subject then
		camera.CameraSubject = subject
	end
end

-- Back to your own character
local function restoreOwnSubject(self)
	local humanoid = self.playerService:getHumanoid()
	if humanoid then
		setSubject(self, humanoid)
	end
end

-- Stops spectating a player. Returns true if a spectate was running.
local function stopView(self): boolean
	local garbage = self:collectGarbage("view")
	if not garbage then return false end

	for _, connection in garbage.connections do
		connection:Disconnect()
	end
	return true
end

return {
	{
		action = "spectate|view",
		description = "View a player",
		args = { kind = "player" },
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			if not target then return end

			freecam.stop(self)
			stopView(self)

			local garbage = self:createGarbage("view")
			garbage.connections = {}

			local camera = self.playerService:getCamera()

			-- Puts the camera back on the target if the game or the character changes it
			local function follow()
				local subject = getSubject(target.Character)
				if subject then
					setSubject(self, subject)
				end
			end

			table.insert(garbage.connections, self:connect(camera:GetPropertyChangedSignal("CameraSubject"), follow))

			table.insert(garbage.connections, self:connect(target.CharacterAdded, function(character)
				character:WaitForChild("Humanoid", 10)
				follow()
			end))

			-- If the target leaves the game, go back to your own character
			table.insert(garbage.connections, self:connect(self.players.PlayerRemoving, function(player)
				if player == target then
					stopView(self)
					restoreOwnSubject(self)
				end
			end))

			follow()
			self:notify("Spectate", "Viewing " .. target.Name)
		end
	},
	{
		action = "viewpart|viewp",
		description = "View a part",
		args = {
			kind = "string",
			name = "part name"
		},
		run = function(self, args)
			local text = args:nextValue()
			if not text then return end

			freecam.stop(self)
			stopView(self)

			local wanted = string.lower(text)
			for _, object in workspace:GetDescendants() do
				if object:IsA("BasePart") and string.lower(object.Name) == wanted then
					setSubject(self, object)
					return
				end
			end

			self:notify("Spectate", "no part named " .. text)
		end
	},
	{
		action = "unspectate|unview",
		description = "Stops viewing player, or part.",
		run = function(self)
			freecam.stop(self)

			local wasViewing = stopView(self)
			restoreOwnSubject(self)

			if wasViewing then
				self:notify("Spectate", "View turned off")
			end
		end
	}
}
