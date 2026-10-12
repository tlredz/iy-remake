-- src/ui/components/settings/waypointsEditor.luau
-- The Edit/Goto Waypoints page, for the waypoints of the game you are in. From the top: a line to add a waypoint (its
-- name, and a position that can be left empty to save where you are standing), the way a tap on a waypoint takes you
-- there (teleport, tween or walk), a switch for the markers in the world, the waypoints themselves, and the rows that
-- clear them.
--
-- Tapping a waypoint goes to it. Del removes it, and a notification (with an Undo button, see ui/notifier) says which
-- one was removed. Clearing asks first. It uses the same functions as the waypoint commands (commands/systems/waypoints),
-- so a waypoint made here can be used in the command bar and the other way around.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel. See settings/init.luau.

local waypoints = require("../../../commands/systems/waypoints")
local playerService = require("../../../framework/services/playerService")
local config = require("../../../framework/config/ui/settings")
local notifier = require("../../notifier")
local widgets = require("./widgets")

local PANEL = config.panel
local BOX = config.box
local VALUE = config.value
local TEXT = config.pages.waypoints

-- how a tap goes: the position in TEXT.modes. It is kept, so the page opens on the way that was used last
local lastModeIndex = 1

local function trim(text: string): string
	return text:match("^%s*(.-)%s*$") or ""
end

local function build(page: ScrollingFrame, ctx)
	local modes = TEXT.modes
	local modeIndex = math.clamp(lastModeIndex, 1, #modes)

	local list = widgets.list(page)
	widgets.pageTop(list, TEXT.title, ctx.back)

	-- the line that adds a waypoint
	widgets.header(list, TEXT.newTitle)
	local nameBox, positionBox, addButton = widgets.formRow(list, TEXT.nameHint, TEXT.positionHint, TEXT.addButton, VALUE.positionWidth)
	local note = widgets.note(list, TEXT.formHint)

	-- what a tap on a waypoint does
	widgets.header(list, TEXT.modeTitle)

	local labels = {}
	for _, mode in modes do
		table.insert(labels, mode.label)
	end

	local selectMode = widgets.choices(list, labels, function(index: number)
		modeIndex = index
		lastModeIndex = index
	end, #modes)
	selectMode(modeIndex)

	-- the markers in the world
	local markersRow = widgets.row(list)
	widgets.label(markersRow, TEXT.markers, BOX.size + 2 * PANEL.padding)
	local _, markersFill = widgets.box(markersRow)

	-- the waypoints
	local listHeader = widgets.header(list, "")
	local waypointsGroup = widgets.group(list)

	-- the rows that clear
	widgets.header(list, TEXT.clearTitle)
	local clearGameRow = widgets.row(list)
	widgets.label(clearGameRow, TEXT.clearGame, 0)
	local clearAllRow = widgets.row(list)
	widgets.label(clearAllRow, TEXT.clearAll, 0)

	local renderWaypoints

	-- a refused action is told on the page and in a notification, since the line under the form can be out of view
	local function refuse(message: string)
		note.Text = message
		notifier:notify(TEXT.notifyTitle, message)
	end

	local function drawMarkersSwitch()
		markersFill.Visible = waypoints.isShown()
	end

	-- goes to a waypoint the way the page is set to
	local function goTo(waypoint: waypoints.Waypoint)
		local mode = modes[modeIndex].mode
		local where = waypoints.format(waypoint.position)

		if not waypoints.go(waypoint, mode) then
			refuse(TEXT.cantGo)
			return
		end

		local message = if mode == "tween" then TEXT.wentTween elseif mode == "walk" then TEXT.wentWalk else TEXT.went
		note.Text = string.format(message, waypoint.name, where)
	end

	-- tells which waypoint was removed, in the stack of notifications, with a button to put it back
	local function askUndo(waypoint: waypoints.Waypoint)
		notifier:ask(TEXT.undoTitle, string.format(TEXT.undoMessage, waypoint.name, waypoints.format(waypoint.position)), {
			{
				text = TEXT.undo,
				primary = true,
				onTap = function()
					-- a waypoint made with the same name meanwhile is not replaced
					if waypoints.find(waypoint.name) then
						notifier:notify(TEXT.notifyTitle, string.format(TEXT.nameTaken, waypoint.name))
						return
					end

					waypoints.save(waypoint.name, waypoint.position)
					waypoints.refreshMarkers()

					-- the page may have been built again (or closed) meanwhile
					if waypointsGroup.Parent then
						note.Text = string.format(TEXT.restored, waypoint.name)
						renderWaypoints()
					end
				end,
			},
		}, TEXT.undoTime)
	end

	local function removeWaypoint(waypoint: waypoints.Waypoint)
		if not waypoints.remove(waypoint.name) then return end

		waypoints.refreshMarkers()
		note.Text = string.format(TEXT.removed, waypoint.name)
		renderWaypoints()
		askUndo(waypoint)
	end

	function renderWaypoints()
		widgets.clear(waypointsGroup)

		local waypointList = waypoints.list()
		local rows = widgets.list(waypointsGroup)

		listHeader.Text = TEXT.listTitle .. (if #waypointList > 0 then ` ({#waypointList})` else "")
		drawMarkersSwitch()

		if #waypointList == 0 then
			widgets.note(rows, TEXT.empty)
			return
		end

		widgets.note(rows, TEXT.listHint)

		for _, waypoint in waypointList do
			local row = widgets.row(rows)

			-- the button is made before the label, and the label stops where the button starts
			local delete = widgets.rowButton(row, TEXT.delete, PANEL.padding, VALUE.buttonWidth)
			widgets.label(row, waypoint.name, VALUE.buttonWidth + 2 * PANEL.padding)

			row.Activated:Connect(function()
				goTo(waypoint)
			end)

			delete.Activated:Connect(function()
				removeWaypoint(waypoint)
			end)
		end
	end

	local function addWaypoint()
		local name = trim(nameBox.Text)

		if name == "" then
			refuse(TEXT.missingName)
			return
		end

		local position: Vector3?
		local text = trim(positionBox.Text)

		if text == "" then
			local root = playerService:getRootPart()

			if not root then
				refuse(TEXT.noCharacter)
				return
			end

			position = root.Position
		else
			position = waypoints.parsePosition(text)

			if not position then
				refuse(TEXT.badPosition)
				return
			end
		end

		local replaced = waypoints.save(name, position :: Vector3)
		waypoints.refreshMarkers()

		nameBox.Text = ""
		positionBox.Text = ""
		note.Text = string.format(if replaced then TEXT.updated else TEXT.saved, name, waypoints.format(position :: Vector3))
		renderWaypoints()
	end

	addButton.Activated:Connect(addWaypoint)

	-- enter in the name box or in the position box adds the waypoint
	for _, box in { nameBox, positionBox } do
		box.FocusLost:Connect(function(enterPressed: boolean)
			if enterPressed then
				addWaypoint()
			end
		end)
	end

	markersRow.Activated:Connect(function()
		if waypoints.isShown() then
			waypoints.hide()
		elseif waypoints.count() == 0 then
			refuse(TEXT.noMarkers)
		else
			waypoints.show()
		end

		drawMarkersSwitch()
	end)

	-- asks before deleting every waypoint of this game, or of every game
	local function askClear(everyGame: boolean)
		local count = if everyGame then waypoints.countAll() else waypoints.count()

		if count == 0 then
			note.Text = TEXT.nothingToClear
			return
		end

		local message = string.format(if everyGame then TEXT.confirmAll else TEXT.confirmGame, count)

		notifier:ask(TEXT.confirmTitle, message, {
			{ text = TEXT.confirmCancel },
			{
				text = TEXT.confirmClear,
				primary = true,
				onTap = function()
					local cleared = if everyGame then waypoints.clearAll() else waypoints.clearPlace()
					waypoints.hide()

					-- the page may have been built again (or closed) meanwhile
					if waypointsGroup.Parent then
						note.Text = string.format(TEXT.cleared, cleared)
						renderWaypoints()
					end
				end,
			},
		})
	end

	clearGameRow.Activated:Connect(function()
		askClear(false)
	end)

	clearAllRow.Activated:Connect(function()
		askClear(true)
	end)

	renderWaypoints()
end

return build
