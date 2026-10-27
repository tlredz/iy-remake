-- src/storage/downloads.luau
-- What IY downloads from the repo, assets and scripts, is kept in the IY folder, in a folder for the version:
--   backups/<version>/assets/<name>.png
--   backups/<version>/scripts/<path>
-- A copy is only made when the version has none, so each version downloads a file once. A new version gets its own folder.

local fileSystem = require("./fileSystem")
local storageConfig = require("../framework/config/storage")
local version = require("../version")

local downloads = {}

-- the path of a file of a kind ("assets" or "scripts") for this version. The path is inside the IY folder
function downloads.path(kind: string, name: string): string
	return storageConfig.downloadPath:format(version, kind, name)
end

-- true when this version has a copy of the file
function downloads.has(kind: string, name: string): boolean
	return fileSystem:exist(downloads.path(kind, name))
end

-- the copy of this version, or nil when there is none
function downloads.read(kind: string, name: string): string?
	local path = downloads.path(kind, name)

	if not fileSystem:exist(path) then
		return nil
	end

	return fileSystem:readFile(path)
end

-- keeps the copy of this version. The folders it is in are made first
function downloads.write(kind: string, name: string, content: string)
	local path = downloads.path(kind, name)
	local folder = path:match("^(.*)/[^/]+$")

	if folder then
		fileSystem:makeFolder(folder)
	end

	fileSystem:writeFile(path, content)
end

return downloads
