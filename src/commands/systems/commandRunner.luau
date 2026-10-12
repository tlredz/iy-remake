-- src/commands/systems/commandRunner.luau
-- Runs command text the way the command bar does, without the bar. "\" runs one command after another,
-- "count^delay^command" loops a command, and "!command" runs it again with the arguments it last used.
-- The command bar and the event binds both run through here, so they behave the same.

local commandsController = require("../controllers/commandsController")
local commandParser = require("./commandParser")
local argsManager = require("./argsManager")
local loopService = require("../services/loopService")
local logger = require("../../utils/logger")

local commandRunner = {}

-- Runs a command with the arguments of one parsed statement (one of the statements that commandParser highlights)
function commandRunner.runStatement(info)
	local name = info.commandData.name
	local argValues = info.args

	if info.repeatLast then
		argValues = commandsController:getLastArgs(name) or {}
	end

	if info.loop then
		commandRunner.startLoop(name, argValues, info.loop)
		return
	end

	commandsController:run(name, argsManager.new(argValues))
end

-- Runs a command `count` times, `delay` seconds apart. "inf" keeps going until 'breakloops'.
function commandRunner.startLoop(name: string, argValues: { any }, loop)
	local runs = 0
	local id

	id = loopService:add(function()
		runs += 1

		local success, failure = pcall(function()
			commandsController:run(name, argsManager.new(argValues))
		end)

		if not success then
			loopService:remove(id)
			logger:error(`loop of '{name}' stopped: {failure}`)
			return
		end

		if runs >= loop.count then
			loopService:remove(id)
		end
	end, loop.delay)
end

-- Reads command text into statements, the same way the command bar reads what is typed. Nothing runs here.
-- Returns the statements and the first problem that stops the whole text from running (if there is one).
local function read(text: string)
	local cmdInput = {}
	local parser = commandParser.new(cmdInput, function() end)

	parser:highlight(parser:parse(text))

	return cmdInput.statements, cmdInput.runError
end

-- The reason a statement cannot run because its command is missing, or nil when every command exists
local function missingCommand(statements): string?
	for _, info in statements do
		if info.empty then
			return "write the command to run"
		end

		if not info.commandData then
			return `'{info.commandName}' is not a command`
		end
	end

	return nil
end

-- Checks that every command in the text exists. The arguments are not checked, since they can be placeholders
-- ($1) that are only filled in when the command runs. Returns true, or false and the reason.
function commandRunner.checkText(text: string): (boolean, string?)
	local statements = read(text)
	local reason = missingCommand(statements)

	if reason then
		return false, reason
	end

	return true
end

-- Runs command text. Like the command bar, nothing runs when a command is missing or an argument is not valid,
-- and otherwise the commands run in order until one fails. Returns true, or false and the reason.
function commandRunner.runText(text: string): (boolean, string?)
	local statements, problem = read(text)
	local reason = missingCommand(statements)

	if reason then
		return false, reason
	end

	if problem then
		-- the problems of the command bar start with " - ", which is only for the bar
		return false, (problem:gsub("^%s*%-%s*", ""))
	end

	for _, info in statements do
		local success, failure = pcall(commandRunner.runStatement, info)

		if not success then
			return false, tostring(failure)
		end
	end

	return true
end

return commandRunner
