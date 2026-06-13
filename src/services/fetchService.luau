local githubConfig = require("../config/github")
local logger = require("../utils/logger")

local repoPath = "https://raw.githubusercontent.com/%s/%s/refs/heads/main/"
repoPath = repoPath:format(githubConfig.owner, githubConfig.repository)

local fetchService = {}

local function request(url)
	return game:HttpGet(url)
end

function fetchService.fetch(url)
	if url:sub(1, 1) == "/" then
		url = url:sub(2)
	end
	
	local success, raw = pcall(request, repoPath .. url)
	
	if not success then
		logger:warn(`failed to fetch http url '{url}':\n\t{raw}`)
		return
	end
	
	return raw
end

return fetchService