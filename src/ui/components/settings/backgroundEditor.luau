-- src/ui/components/settings/backgroundEditor.luau
-- The custom background, at the end of the Edit Theme page: a box for the URL of an image, a row that sets the image
-- from it, a row that downloads the image again, a row that takes the image away, and a slider for how much of the image
-- shows (its opacity). The images are kept by ui/services/backgroundService. addSection(list) adds this part to a list
-- (widgets.list).

local backgroundService = require("../../services/backgroundService")
local notifier = require("../../notifier")
local widgets = require("./widgets")
local config = require("../../../framework/config/ui/settings")

local TEXT = config.pages.background

local backgroundEditor = {}

function backgroundEditor.addSection(list)
	widgets.header(list, TEXT.title)

	local urlBox = widgets.textBox(list, TEXT.urlHint)
	urlBox.Text = backgroundService:getUrl() or ""

	-- shows the image of a URL. fresh downloads it again, even when it was downloaded before (refresh). The download runs
	-- in a thread of its own (backgroundService:startDownload): the same URL is not downloaded twice, and another URL
	-- cancels the download in progress
	local function fetchImage(url: string, fresh: boolean)
		local problem = backgroundService:checkUrl(url)

		if problem then
			notifier:notify(TEXT.notifyTitle, problem)
			return
		end

		if backgroundService:isDownloading(url) then
			notifier:notify(TEXT.notifyTitle, TEXT.alreadyDownloading)
			return
		end

		local replacing = backgroundService:isDownloading()

		notifier:notify(TEXT.notifyTitle, if replacing then TEXT.downloadReplaced else TEXT.downloading)

		backgroundService:startDownload(url, fresh, {
			onSlow = function()
				notifier:notify(TEXT.notifyTitle, TEXT.slow)
			end,

			onDone = function(success: boolean, reason: string?)
				if success then
					notifier:notify(TEXT.notifyTitle, if fresh then TEXT.refreshed else TEXT.set)
				else
					notifier:notify(TEXT.notifyTitle, reason or TEXT.downloadFailed)
				end
			end,
		})
	end

	local setRow = widgets.row(list)
	widgets.icon(setRow, TEXT.icons.apply)
	widgets.label(setRow, TEXT.apply, 0)

	setRow.Activated:Connect(function()
		fetchImage(urlBox.Text, false)
	end)

	local refreshRow = widgets.row(list)
	widgets.icon(refreshRow, TEXT.icons.refresh)
	widgets.label(refreshRow, TEXT.refresh, 0)

	refreshRow.Activated:Connect(function()
		local url = backgroundService:getUrl()

		if url == nil then
			notifier:notify(TEXT.notifyTitle, TEXT.nothingToRefresh)
			return
		end

		fetchImage(url, true)
	end)

	local removeRow = widgets.row(list)
	widgets.icon(removeRow, TEXT.icons.remove)
	widgets.label(removeRow, TEXT.remove, 0)

	removeRow.Activated:Connect(function()
		if backgroundService:getUrl() == nil then
			notifier:notify(TEXT.notifyTitle, TEXT.nothingToRemove)
			return
		end

		local deleted = backgroundService:clear()
		urlBox.Text = ""

		notifier:notify(TEXT.notifyTitle, if deleted then TEXT.removed else TEXT.removedKeptFile)
	end)

	local opacityRow = widgets.row(list)
	widgets.icon(opacityRow, TEXT.icons.opacity)

	widgets.slider(opacityRow, TEXT.opacity, backgroundService:getOpacity(), function(value: number)
		backgroundService:setOpacity(value)
	end)
end

return backgroundEditor
