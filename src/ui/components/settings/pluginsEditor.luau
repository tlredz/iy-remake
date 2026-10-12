-- src/ui/components/settings/pluginsEditor.luau
-- The Manage Plugins page. From the top: a box to type the file name of a plugin and add it, the plugins that are
-- installed, and the .luau files in the plugins folder that are not installed yet (tap one, or Add all).
--
-- A plugin shows how many commands it gave, or "(failed)" when it could not load. Tapping a plugin tells its state in
-- the line under the box (the reason, when it failed). Reload reads its file again, so changes to it take effect, and
-- Del removes it. It uses the same functions as addplugin, removeplugin, reloadplugin and addallplugins
-- (commands/systems/plugins), so the change is saved and works in the command bar at once.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel. See settings/init.luau.

local plugins = require("../../../commands/systems/plugins")
local commandsList = require("../../../commands/list")
local config = require("../../../framework/config/ui/settings")
local notifier = require("../../notifier")
local widgets = require("./widgets")

local PANEL = config.panel
local VALUE = config.value
local TEXT = config.pages.plugins

local function trim(text: string): string
	return text:match("^%s*(.-)%s*$") or ""
end

local function build(page: ScrollingFrame, ctx)
	local list = widgets.list(page)
	widgets.pageTop(list, TEXT.title, ctx.back)

	-- the box that adds a plugin by its file name
	widgets.header(list, TEXT.addTitle)
	local fileBox = widgets.textBox(list, TEXT.fileHint)

	local addRow = widgets.row(list)
	widgets.label(addRow, TEXT.addButton, 0)

	local note = widgets.note(list, string.format(TEXT.folderHint, plugins.FOLDER))
	widgets.note(list, TEXT.trustHint)

	-- the installed plugins, and the files in the folder
	local installedHeader = widgets.header(list, TEXT.installedTitle)
	local installedGroup = widgets.group(list)

	widgets.header(list, TEXT.folderTitle)
	local folderGroup = widgets.group(list)

	local render

	-- a refused action is told on the page and in a notification, since the line under the box can be out of view
	local function refuse(message: string)
		note.Text = message
		notifier:notify(TEXT.errorTitle, message)
	end

	-- adds a plugin by its file name. Returns true when it was added
	local function addPlugin(name: string): boolean
		local success, detail = plugins.add(commandsList, name)

		if success then
			note.Text = string.format(TEXT.added, name, detail :: number)
			render()
			return true
		end

		refuse(tostring(detail))
		return false
	end

	-- what the line under the box says when a plugin is tapped
	local function describeState(plugin): string
		if plugin.loaded then
			return string.format(TEXT.stateLoaded, plugin.name, plugin.commands)
		end

		if plugin.error then
			return string.format(TEXT.stateFailed, plugin.name, plugin.error)
		end

		return string.format(TEXT.stateUnknown, plugin.name)
	end

	local function renderInstalled()
		widgets.clear(installedGroup)

		local installed = plugins.getInstalled()
		local rows = widgets.list(installedGroup)

		installedHeader.Text = TEXT.installedTitle .. (if #installed > 0 then ` ({#installed})` else "")

		if #installed == 0 then
			widgets.note(rows, TEXT.noneInstalled)
			return
		end

		widgets.note(rows, TEXT.installedHint)

		local gap = PANEL.rowGap
		local removeOffset = PANEL.padding
		local reloadOffset = removeOffset + VALUE.buttonWidth + gap
		local rightSpace = reloadOffset + VALUE.reloadWidth + PANEL.padding

		for _, plugin in installed do
			local row = widgets.row(rows)

			local remove = widgets.rowButton(row, TEXT.remove, removeOffset, VALUE.buttonWidth)
			local reload = widgets.rowButton(row, TEXT.reload, reloadOffset, VALUE.reloadWidth)

			-- a plugin that did not load is shown dimmed
			local label = if plugin.loaded
				then string.format(TEXT.loadedLabel, plugin.name, plugin.commands)
				else string.format(TEXT.failedLabel, plugin.name)

			widgets.label(row, label, rightSpace, if plugin.loaded then nil else "Colors.Text.Darker")

			row.Activated:Connect(function()
				note.Text = describeState(plugin)
			end)

			reload.Activated:Connect(function()
				local success, detail = plugins.reload(commandsList, plugin.name)

				if success then
					note.Text = string.format(TEXT.reloaded, plugin.name, detail :: number)
					render()
				else
					render()
					refuse(tostring(detail))
				end
			end)

			remove.Activated:Connect(function()
				if plugins.remove(commandsList, plugin.name) then
					note.Text = string.format(TEXT.removed, plugin.name)
					render()
				end
			end)
		end
	end

	local function renderFolder()
		widgets.clear(folderGroup)

		local names, reason = plugins.getAvailable()
		local rows = widgets.list(folderGroup)

		if not names then
			widgets.note(rows, reason or "")
			return
		end

		if #names == 0 then
			widgets.note(rows, TEXT.noneInFolder)
			return
		end

		local addOffset = PANEL.padding

		for _, name in names do
			local row = widgets.row(rows)

			local add = widgets.rowButton(row, TEXT.add, addOffset, VALUE.buttonWidth)
			widgets.label(row, name, VALUE.buttonWidth + 2 * PANEL.padding)

			-- tapping the row adds it too, like the button
			row.Activated:Connect(function()
				addPlugin(name)
			end)

			add.Activated:Connect(function()
				addPlugin(name)
			end)
		end

		-- adds every file that is listed. The ones that fail are told, and stay out
		local allRow = widgets.row(rows)
		widgets.label(allRow, string.format(TEXT.addAll, #names), 0)

		allRow.Activated:Connect(function()
			local added = 0
			local failed = {}

			for _, name in names do
				local success, detail = plugins.add(commandsList, name)

				if success then
					added += 1
				else
					table.insert(failed, `{name}: {detail}`)
				end
			end

			local message = string.format(TEXT.addedAll, added)

			if #failed > 0 then
				message ..= string.format(TEXT.failedAll, #failed)

				for _, line in failed do
					warn(`plugin {line}`)
				end
			end

			note.Text = message
			render()
		end)
	end

	function render()
		renderInstalled()
		renderFolder()
	end

	local function addFromBox()
		local name = trim(fileBox.Text)

		if name == "" then
			refuse(TEXT.missingName)
			return
		end

		if addPlugin(name) then
			fileBox.Text = ""
		end
	end

	addRow.Activated:Connect(addFromBox)

	-- enter in the box adds the plugin
	fileBox.FocusLost:Connect(function(enterPressed: boolean)
		if enterPressed then
			addFromBox()
		end
	end)

	render()
end

return build
