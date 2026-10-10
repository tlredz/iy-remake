local copyArg = {
	kind = "boolean",
	name = "copy",
	optional = true
}

local function sendValue(self, value: string, copy: boolean?)
	if copy == false then
		self.executorEnv.setclipboard(value)
	else
		self:notify(value)
	end
end

return {
	{
		action = "jobid",
		description = "Copies the games JobId to your clipboard, or notify",
		args = copyArg,
		run = function(self, args)
			local value = `roblox://placeId={game.PlaceId}&gameInstanceId={game.JobId}`
			sendValue(self, value, args:nextValue())
		end
	},
	{
		action = "placeid",
		description = "Copies the current place id to your clipboard, or notify",
		args = copyArg,
		run = function(self, args)
			sendValue(self, tostring(game.PlaceId), args:nextValue())
		end
	},
	{
		action = "gameid",
		description = "Copies the current game id to your clipboard, or notify",
		args = copyArg,
		run = function(self, args)
			sendValue(self, tostring(game.GameId), args:nextValue())
		end
	}
}
