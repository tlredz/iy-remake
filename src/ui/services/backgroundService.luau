-- src/ui/services/backgroundService.luau
-- The custom background (Settings > Edit Theme): an image from a URL, shown as the background of the window.
--
-- Every image it downloads is kept in the IY folder. The map of those files is saved as a JSON file
-- (storage/data/backgrounds): each URL is linked to the file its image is in. A URL that was downloaded before is shown
-- from its file, so it is not downloaded again. Refresh downloads the image again. Removing the image deletes its file
-- and takes its link out of the map. The URL that is shown and the opacity (0 to 1) are saved in the settings.
--
-- The main frame is an ImageLabel (see components/mainFrame), so the image is its own background: the window's color is
-- under it, and the opacity decides how much of the image covers that color. While an image shows, the top bar is
-- see-through, so the image is seen there too.

local executorEnv = require("../../framework/environment/executor")
local fetchService = require("../../framework/services/fetchService")
local settingsData = require("../../storage/data/settings")
local backgroundsData = require("../../storage/data/backgrounds")
local fileSystem = require("../../storage/fileSystem")

local config = require("../../framework/config/ui/background")
local texts = require("../../framework/config/ui/settings").pages.background

local backgroundService = {
	frame = nil, -- the main frame, which shows the image as its background
	topBar = nil, -- the top bar of the main frame
	asset = nil, -- the custom asset of the image, when one is shown
}

-- the files made this session. It makes each download's file name its own
local imageCount = 0

-- the download in progress, or nil: { url, thread }. It is kept here, not in the editor, so it goes on when the settings
-- page is built again
local activeDownload = nil

local function trim(text: string): string
	return text:match("^%s*(.-)%s*$") or ""
end

-- the file type an image is kept with, from its URL (the query is left out). A type that is not known is kept as png
local function extensionOf(url: string): string
	local path = url:match("^[^?#]*") or url
	local extension = (path:match("%.(%w+)$") or ""):lower()

	return config.extensions[extension] or config.defaultExtension
end

local function readOpacity(): number
	local value = settingsData:getValue(config.keys.opacity)

	if type(value) ~= "number" then
		return config.defaultOpacity
	end

	return math.clamp(value, 0, 1)
end

-- the file the map links a URL to, when that file is still in the IY folder
local function fileOf(url: string): string?
	local file = backgroundsData:getEntry(url)

	if type(file) == "string" and fileSystem:exist(file) then
		return file
	end

	return nil
end

-- a background set before the map existed kept its file in the settings. That file joins the map, and the settings
-- forget it
local function adoptSavedFile(url: string): string?
	local saved = settingsData:getValue(config.keys.file)

	if saved == nil then
		return nil
	end

	settingsData:setValue(config.keys.file, nil)
	settingsData:save()

	if type(saved) ~= "string" or not fileSystem:exist(saved) then
		return nil
	end

	backgroundsData:setEntry(url, saved)
	backgroundsData:save()

	return saved
end

-- downloads the image of a URL into a new file of the IY folder. Returns the file and its asset, or nil and the reason.
-- When isCurrent() says the download was cancelled while it ran, nothing is written and nil is returned with no reason
local function download(url: string, isCurrent: () -> boolean): (string?, string?, string?)
	local content = fetchService.fetchUrl(url)

	if not isCurrent() then
		return nil, nil, nil
	end

	if content == nil then
		return nil, nil, texts.downloadFailed
	end

	-- getcustomasset can give back an old picture for a file name it has seen before, so each download gets its own name
	imageCount += 1
	local path = `{config.folder}/image-{os.time()}-{imageCount}.{extensionOf(url)}`

	fileSystem:makeFolder(config.folder)
	fileSystem:writeFile(path, content)

	local asset = fileSystem:getCustomAsset(path)

	if asset == nil then
		-- an image that can't be shown is not kept
		fileSystem:delete(path)
		return nil, nil, texts.loadFailed
	end

	return path, asset, nil
end

-- the URL that is shown, or nil when there is no image
function backgroundService:getUrl(): string?
	local url = settingsData:getValue(config.keys.url)

	if type(url) == "string" and url ~= "" then
		return url
	end

	return nil
end

function backgroundService:getOpacity(): number
	return readOpacity()
end

-- the reason a URL can't be used now, or nil when it can
function backgroundService:checkUrl(url: string): string?
	local clean = trim(url)

	if clean == "" then
		return texts.empty
	end

	if not clean:match("^https?://") then
		return texts.badUrl
	end

	if executorEnv.getcustomasset == nil then
		return texts.noCustomAsset
	end

	return nil
end

-- shows the image on the window: at an opacity of 0 it is not seen, at 1 it covers the window's color
function backgroundService:paint()
	local frame = self.frame
	if frame == nil then return end

	local asset = self.asset

	frame.Image = asset or ""
	frame.ImageTransparency = 1 - readOpacity()

	if self.topBar then
		self.topBar.BackgroundTransparency = if asset ~= nil then 1 else 0
	end
end

-- gives the main frame its image, and shows the image of the URL that is saved, when there is one
function backgroundService:attach(frame: GuiObject)
	if self.frame ~= nil then return end

	self.frame = frame
	self.topBar = frame:FindFirstChild("TopBar")

	local url = self:getUrl()

	if url ~= nil and executorEnv.getcustomasset ~= nil then
		local file = fileOf(url) or adoptSavedFile(url)

		if file ~= nil then
			self.asset = fileSystem:getCustomAsset(file)
		end
	end

	self:paint()
end

-- shows the image of a URL. A URL that was downloaded before is shown from its file, unless fresh is true: then the
-- image is downloaded again (refresh). The file it replaces is deleted. Returns true, or false and the reason
-- isCurrent (optional) is asked after the download: when it says no, the download was cancelled, and nothing is saved
function backgroundService:setFromUrl(url: string, fresh: boolean?, isCurrent: (() -> boolean)?): (boolean, string?)
	local clean = trim(url)
	local previous = fileOf(clean)
	local canContinue = isCurrent or function() return true end

	local path = previous
	local asset = nil

	if previous ~= nil and not fresh then
		asset = fileSystem:getCustomAsset(previous)
	end

	if asset == nil then
		local newPath, newAsset, reason = download(clean, canContinue)

		if newPath == nil or newAsset == nil then
			return false, reason
		end

		path = newPath
		asset = newAsset

		if previous ~= nil and previous ~= newPath then
			fileSystem:delete(previous)
		end
	end

	backgroundsData:setEntry(clean, path)
	backgroundsData:save()

	settingsData:setValue(config.keys.url, clean)
	settingsData:save()

	self.asset = asset
	self:paint()

	return true
end

-- takes the image away: the file of its URL is deleted and the URL's link is taken out of the map. Returns false when
-- the file could not be deleted (an exploit without delfile): the file stays, and the link is taken out anyway
function backgroundService:clear(): boolean
	-- an image that is still downloading must not come back once it is removed
	self:cancelDownload()

	local url = self:getUrl()
	local deleted = true

	if url ~= nil then
		local file = backgroundsData:getEntry(url)

		if type(file) == "string" then
			deleted = fileSystem:delete(file)
		end

		backgroundsData:setEntry(url, nil)
		backgroundsData:save()
	end

	settingsData:setValue(config.keys.url, nil)
	settingsData:save()

	self.asset = nil
	self:paint()

	return deleted
end

-- the opacity of the image, from 0 (not seen) to 1 (covers the window's color). It is saved and shown at once
function backgroundService:setOpacity(value: number)
	local opacity = math.round(math.clamp(value, 0, 1) * 100) / 100

	settingsData:setValue(config.keys.opacity, opacity)
	settingsData:save()

	self:paint()
end

-- whether the image of a URL is being downloaded now, or any image when the URL is left out
function backgroundService:isDownloading(url: string?): boolean
	if activeDownload == nil then return false end
	if url == nil then return true end

	return activeDownload.url == trim(url)
end

-- stops the download in progress, if there is one. Its thread is stopped; if the executor can't stop it, its result is
-- dropped instead, because it is no longer the download in progress
function backgroundService:cancelDownload()
	local cancelled = activeDownload
	if cancelled == nil then return end

	activeDownload = nil

	if cancelled.thread ~= nil then
		pcall(task.cancel, cancelled.thread)
	end
end

-- downloads the image of a URL in a thread of its own, and shows it when it is done. A download in progress is cancelled
-- first. listener.onSlow runs once, when the download takes longer than config.slowSeconds. listener.onDone(success,
-- reason) runs when it ends, but not when it was cancelled
function backgroundService:startDownload(url: string, fresh: boolean?, listener: {
	onSlow: (() -> ())?,
	onDone: ((boolean, string?) -> ())?
})
	self:cancelDownload()

	local job = { url = trim(url), thread = nil }
	activeDownload = job

	task.delay(config.slowSeconds, function()
		if activeDownload == job and listener.onSlow then
			listener.onSlow()
		end
	end)

	job.thread = task.spawn(function()
		-- a failure inside is reported as a failed download, so the download in progress is never left behind
		local ran, success, reason = pcall(function()
			return self:setFromUrl(job.url, fresh, function()
				return activeDownload == job
			end)
		end)

		if not ran then
			success, reason = false, texts.downloadFailed
		end

		-- cancelled meanwhile: nothing is shown, and the download in progress is another one
		if activeDownload ~= job then return end

		activeDownload = nil

		if listener.onDone then
			listener.onDone(success, reason)
		end
	end)
end

return backgroundService
