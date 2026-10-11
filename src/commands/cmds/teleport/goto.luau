local resolvePlayers = require("../../systems/resolvePlayers")

-- Stops the loopgoto loop
local function stopLoopGoto(self)
	local garbage = self:collectGarbage("loopgoto")
	if garbage and garbage.id then
		self.loopService:remove(garbage.id)
	end
end

-- The first player in the list that has a character
local function findCharacter(players: { Player }): Model?
	for _, player in players do
		if player.Character then
			return player.Character
		end
	end
	return nil
end

-- A spot 3 studs in front of the character, facing it (where goto and tweengoto put you)
local function getSpotNear(character: Model): CFrame
	local pivot = character:GetPivot()
	local position = pivot.Position
	return CFrame.new(position + pivot.LookVector * 3, position)
end

return {
	{
		action = "goto|to",
		description = "Go to a player",
		args = { kind = "player" },
		run = function(self, args)
			local character = findCharacter(resolvePlayers(args:nextValue()))
			if not character then return end

			self.playerService:waitForStreamPlayerCharacter(character)
			self.playerService:teleportTo(getSpotNear(character))
		end
	},
	{
		action = "tweengoto|tgoto|tweento|tto",
		description = "Tween to a player (bypasses some anti cheats)",
		args = {
			{ kind = "player" },
			{
				kind = "number",
				name = "tween speed",
				optional = true
			}
		},
		run = function(self, args)
			local character = findCharacter(resolvePlayers(args:nextValue()))
			if not character then return end

			local speed = args:nextValue() or self.privateEnv.tweenSpeed
			self.playerService:tweenTeleportTo({
				target = getSpotNear(character),
				speed = speed
			})
		end
	},
	{
		action = "loopgoto",
		description = "Loop teleport to a player",
		args = {
			{ kind = "player" },
			{
				kind = "number",
				name = "distance",
				optional = true
			},
			{
				kind = "number",
				name = "delay",
				optional = true
			}
		},
		run = function(self, args)
			stopLoopGoto(self)

			local target = resolvePlayers(args:nextValue())[1]
			local distance = args:nextValue() or 3
			local delay = args:nextValue() or 0
			if not target then return end

			self.playerService:unseat()

			local garbage = self:createGarbage("loopgoto")
			garbage.id = self.loopService:add(function()
				if target.Parent == nil then
					stopLoopGoto(self)
					return
				end

				local character = target.Character
				if character then
					self.playerService:setRootCFrame(character:GetPivot() + Vector3.new(distance, 1, 0))
				end
			end, delay)
		end
	},
	{
		action = "unloopgoto|noloopgoto",
		description = "Stops teleporting you to a player",
		run = function(self)
			stopLoopGoto(self)
		end
	}
}
