-- src/ui/components/settings/eventBindsEditor.luau
-- The Edit Event Binds page. From the top: the events as buttons (tap the one you want), the form to add a bind to
-- it (its conditions, then one line with the command, the delay and the add button), and the binds of the event.
-- Tapping a bind removes it, and a notification (with an Undo button, see ui/notifier) says which bind was removed.
-- The delay of a bind is a box: type a new delay in it and leave the box (or press enter) to change it. It is kept short, so the
-- whole form shows without a scroll: the header says what the event is, and the command, the delay and the button
-- share a line. What a condition accepts is described in framework/config/services/eventBinds.
--
-- Pages are built by build(page, ctx): ctx.back goes to the panel. See settings/init.luau.

local eventBinds = require("../../../commands/systems/eventBinds")
local config = require("../../../framework/config/ui/settings")
local notifier = require("../../notifier")
local widgets = require("./widgets")

local PANEL = config.panel
local VALUE = config.value
local TEXT = config.pages.eventBinds

-- the event that was open last, so the page opens on it again
local lastEventIndex = 1

-- the conditions of a bind, as the texts that were saved
local function conditionsOf(bind): { string }
	local conditions = {}

	for _, text in bind.conditions or {} do
		table.insert(conditions, tostring(text))
	end

	return conditions
end

-- the text of a bind in the list: its command, then its conditions in brackets
local function describeBind(bind): string
	local conditions = conditionsOf(bind)

	if #conditions == 0 then
		return bind.command
	end

	return `{bind.command}  [{table.concat(conditions, ", ")}]`
end

-- a delay as its box shows it: "2s"
local function describeDelay(delay: number): string
	return `{delay}s`
end

-- the seconds a delay box holds: "2", "2s" and " 0.5 s" all mean seconds. Returns nil when the text is not a number
local function readDelay(text: string): number?
	local digits = text:gsub("%s", ""):gsub("s$", "")
	return tonumber(digits)
end

local function build(page: ScrollingFrame, ctx)
	local events = eventBinds.events
	local eventIndex = math.clamp(lastEventIndex, 1, #events)
	local conditionBoxes = {}

	-- the buttons leave out the "On" every event starts with; the header names the whole event
	local names = {}
	for _, event in events do
		table.insert(names, (event.name:gsub("^On", "")))
	end

	local list = widgets.list(page)
	widgets.pageTop(list, nil, ctx.back)

	local selectEvent
	local renderEvent
	local renderBinds

	selectEvent = widgets.choices(list, names, function(index: number)
		eventIndex = index
		lastEventIndex = index
		renderEvent()
	end, TEXT.columns)

	-- the event and what it is, in the place a title would go
	local eventHeader = widgets.header(list, "")

	-- one row for each condition of the event
	local conditionsGroup = widgets.group(list)

	local commandBox, delayBox, addButton = widgets.formRow(list, TEXT.commandHint, TEXT.delayHint, TEXT.addButton)

	local note = widgets.note(list, "")

	local listHeader = widgets.header(list, "")
	local bindsGroup = widgets.group(list)

	local function currentEvent()
		return events[eventIndex]
	end

	-- a refused bind is told on the page and in a notification, since the line under the form can be out of view
	local function refuse(message: string)
		note.Text = message
		notifier:notify(TEXT.notifyTitle, message)
	end

	-- tells which bind was removed, in the stack of notifications, with a button to put it back where it was
	local function askUndo(event, index: number, bind)
		local message = string.format(TEXT.undoMessage, bind.command, event.name)

		-- a second line with what else tells this bind apart: its delay and its conditions, when it has any
		local details = {}
		local conditions = conditionsOf(bind)

		if (bind.delay or 0) > 0 then
			table.insert(details, string.format(TEXT.undoDelay, describeDelay(bind.delay)))
		end

		if #conditions > 0 then
			table.insert(details, `[{table.concat(conditions, ", ")}]`)
		end

		if #details > 0 then
			message ..= "\n" .. table.concat(details, "  ")
		end

		notifier:ask(TEXT.undoTitle, message, {
			{
				text = TEXT.undo,
				primary = true,
				onTap = function()
					if eventBinds.restore(event.name, index, bind) then
						-- the page may have been built again (or closed) meanwhile
						if bindsGroup.Parent then
							note.Text = string.format(TEXT.restored, bind.command)

							if currentEvent() == event then
								renderBinds()
							end
						end
					end
				end,
			},
		}, TEXT.undoTime)
	end

	-- one row for each condition of the event
	local function renderConditions()
		widgets.clear(conditionsGroup)
		conditionBoxes = {}

		local conditionList = widgets.list(conditionsGroup)

		for index, condition in currentEvent().conditions do
			local _, box = widgets.inputRow(
				conditionList,
				condition.label,
				TEXT.conditionHints[condition.kind] or "",
				condition.default
			)

			conditionBoxes[index] = box
		end
	end

	function renderBinds()
		widgets.clear(bindsGroup)

		local event = currentEvent()
		local rows = widgets.list(bindsGroup)
		local binds = eventBinds.getBinds(event.name)

		listHeader.Text = string.format(TEXT.listTitle, event.name) .. (if #binds > 0 then ` ({#binds})` else "")

		if #binds == 0 then
			widgets.note(rows, TEXT.empty)
			return
		end

		widgets.note(rows, TEXT.listHint)

		for index, bind in binds do
			local row = widgets.row(rows)
			widgets.label(row, describeBind(bind), VALUE.delayWidth + 2 * PANEL.padding)

			-- the delay is a box at the right of the row. Typing in it is not a tap on the row, so it does not remove the bind
			local delayInput = widgets.valueInput(row, describeDelay(bind.delay or 0), VALUE.delayWidth)

			-- the delay changes when the box loses focus: by enter, or by tapping away
			delayInput.FocusLost:Connect(function()
				if not delayInput.Parent then return end -- the page was built again meanwhile

				local delay = readDelay(delayInput.Text)

				if delay == nil or delay < 0 then
					delayInput.Text = describeDelay(bind.delay or 0)
					refuse(if delay == nil then TEXT.badDelay else TEXT.negativeDelay)
					return
				end

				if eventBinds.setDelay(event.name, index, delay) then
					delayInput.Text = describeDelay(delay)
					note.Text = string.format(TEXT.delayChanged, bind.command, describeDelay(delay))
				end
			end)

			row.Activated:Connect(function()
				local removed = eventBinds.remove(event.name, index)

				if removed then
					note.Text = string.format(TEXT.removed, removed.command)
					renderBinds()
					askUndo(event, index, removed)
				end
			end)
		end
	end

	function renderEvent()
		eventHeader.Text = string.format(TEXT.header, currentEvent().name, currentEvent().description)
		note.Text = ""

		selectEvent(eventIndex)
		renderConditions()
		renderBinds()
	end

	local function addBind()
		local delay = if delayBox.Text == "" then 0 else readDelay(delayBox.Text)

		if delay == nil then
			refuse(TEXT.badDelay)
			return
		end

		if delay < 0 then
			refuse(TEXT.negativeDelay)
			return
		end

		local conditions = {}
		for index, box in conditionBoxes do
			conditions[index] = box.Text
		end

		local event = currentEvent()
		local added, reason = eventBinds.add(event.name, commandBox.Text, delay, conditions)

		if added then
			-- the event and the delay stay, so several binds can be added in a row
			commandBox.Text = ""
			renderBinds()
			note.Text = string.format(TEXT.added, event.name)
		else
			refuse(reason or TEXT.notAdded)
		end
	end

	addButton.Activated:Connect(addBind)

	-- enter in the command box or in the delay box adds the bind
	for _, box in { commandBox, delayBox } do
		box.FocusLost:Connect(function(enterPressed: boolean)
			if enterPressed then
				addBind()
			end
		end)
	end

	renderEvent()
end

return build
