local githubConfig = require("../config/github")
local logger = require("../../utils/logger")

local ownerName = githubConfig.owner
local repoName = githubConfig.repository

local repoPath = `https://raw.githubusercontent.com/{ownerName}/{repoName}/refs/heads/main/`
local downloadPath = `https://github.com/{ownerName}/{repoName}/releases/latest/download/`

local fetchService = {}

local function request(url: string): string
	return game:HttpGet(url)
end

local function cleanPath(path: string): string
	if path:sub(1, 1) == "/" then
		return path:sub(2)
	end

	return path
end

local function get(base: string, path: string): string?
	local url = base .. cleanPath(path)
	local success, response = pcall(request, url)

	if not success then
		logger:warn(`failed to fetch http url '{url}':\n\t{response}`)
		return nil
	end

	if type(response) ~= "string" or #response == 0 then
		logger:warn(`empty response from '{url}'`)
		return nil
	end

	return response
end

function fetchService.download(name: string): string?
	return get(downloadPath, name)
end

-- the URL of a release asset, for code that fetches it later (queued after a teleport)
function fetchService.downloadUrl(name: string): string
	return downloadPath .. cleanPath(name)
end

function fetchService.fetch(path: string): string?
	return get(repoPath, path)
end

function fetchService.load(path: string, chunkName: string?): (() -> ...any)?
	local source = fetchService.fetch(path)
	if source == nil then return nil end

	local chunk, err = loadstring(source, chunkName)
	if chunk == nil then
		logger:warn(`failed to compile '{path}':\n\t{err}`)
		return nil
	end

	return chunk
end

return fetchService