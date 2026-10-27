local githubConfig = require("../config/github")
local downloads = require("../../storage/downloads")
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

-- the text of any URL (the background image, for one). Nothing is kept for it
function fetchService.fetchUrl(url: string): string?
	return get("", url)
end

function fetchService.fetch(path: string): string?
	return get(repoPath, path)
end

-- the name a script is kept under: its path in the repo, without the backups folder it is in
local function scriptName(path: string): string
	return (path:gsub("^backups/", ""))
end

-- compiles the source of a script. Returns the chunk, or nil when it does not compile
local function compile(source: string, path: string, chunkName: string?): (() -> ...any)?
	local chunk, err = loadstring(source, chunkName)

	if chunk == nil then
		logger:warn(`failed to compile '{path}':\n\t{err}`)
		return nil
	end

	return chunk
end

-- loads a script from the repo. The copy kept for this version is used first; when that copy does not compile, the
-- repo is asked again. A script from the repo is kept for this version once it compiles
function fetchService.load(path: string, chunkName: string?): (() -> ...any)?
	local name = scriptName(path)

	local kept = downloads.read("scripts", name)
	if kept ~= nil then
		local chunk = compile(kept, path, chunkName)

		if chunk ~= nil then
			return chunk
		end
	end

	local source = fetchService.fetch(path)
	if source == nil then
		return nil
	end

	local chunk = compile(source, path, chunkName)

	if chunk ~= nil then
		downloads.write("scripts", name, source)
	end

	return chunk
end

return fetchService
