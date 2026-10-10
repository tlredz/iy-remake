-- serverhop teleports you to another public server of this game.
-- The server list comes from the Roblox servers API, so the executor needs an http request function.

local MAX_PAGES = 3

local function fetchPage(request, placeId: number, cursor: string?)
	local url = `https://games.roblox.com/v1/games/{placeId}/servers/Public?sortOrder=Asc&limit=100`
	if cursor then
		url = url .. "&cursor=" .. cursor
	end

	local response = request({ Url = url, Method = "GET" })
	return game:GetService("HttpService"):JSONDecode(response.Body)
end

return {
	{
		action = "serverhop|shop",
		description = "Teleports you to a different server",
		run = function(self)
			local request = self:expectExploit("httprequest")
			if not request then return end

			self:notify("Serverhop", "looking for a server with free space...")

			task.spawn(function()
				local found = {}
				local cursor = nil

				for _ = 1, MAX_PAGES do
					local ok, page = pcall(fetchPage, request, game.PlaceId, cursor)
					if not ok or type(page) ~= "table" then break end

					for _, server in page.data or {} do
						if server.id ~= game.JobId and server.playing < server.maxPlayers then
							table.insert(found, server.id)
						end
					end

					cursor = page.nextPageCursor
					if not cursor then break end
				end

				if #found == 0 then
					self:notify("Serverhop", "no other server with free space was found")
					return
				end

				self.playerService:teleportToJobId(found[math.random(1, #found)])
			end)
		end
	}
}
