local commandsController = require("../controllers/commandsController")
local searchController   = require("../controllers/searchController")

local commandsList  = require("../list")
local colors        = require("../../framework/config/colors")

local tools         = require("../../utils/tools")
local argsValidator = require("./argsValidator")

local colorFromRGB = tools.colorFromRGB
local esc          = tools.escapeRichText

-- "\" runs the next command after the one before it
local SEPARATOR   = "\\"
-- "count^delay^command" runs a command in a loop; a count of "inf" keeps going until breakloops
local LOOP_CHAR   = "^"
local INFINITE    = "inf"
-- "!command" runs a command again with the arguments it last used
local REPEAT_CHAR = "!"

local startStringChars    = tools.lookupify({ "`", "'", "\"" })
local whiteSpaceChars     = tools.lookupify({ " ", "\t", "\n", "\r" })
local skipWhiteSpaceChars = tools.lookupify({ ",", "|", "&" })

local function getCommand(commandName)
	return commandsList.lookup[commandName]
end

local function colorFromName(text, name, fallBack)
	local acolors = colors.args
	return colorFromRGB(text, acolors[name] or fallBack or acolors.others)
end

local function removeWhiteSpace(text)
	local result = text:gsub(".", function(char)
		return whiteSpaceChars[char] and "_" or char
	end)
	return result
end

local function argName(arg, index)
	if arg.name then
		return `'{removeWhiteSpace(arg.name)}'`
	end
	return `#{index}`
end

-- Position of the quote that closes the string opened at `openAt` (escaped quotes are skipped).
local function findClosingQuote(command: string, quote: string, openAt: number): number?
	local searchAt = openAt + 1

	while true do
		local found = command:find(quote, searchAt, true)

		if not found then
			return nil
		end

		if command:sub(found - 1, found - 1) ~= "\\" then
			return found
		end

		searchAt = found + 1
	end
end

-- Reads a bare word. It ends at a space or at "\". A comma, pipe or ampersand also swallows
-- the whitespace after it, so "1, 2" is read as the single value "1,2".
local function readIdentifier(command: string, startAt: number): (string, number)
	local buffer = {}
	local pos = startAt
	local length = #command

	while pos <= length do
		local char = command:sub(pos, pos)

		if whiteSpaceChars[char] or char == SEPARATOR then
			break
		end

		table.insert(buffer, char)
		pos += 1

		if skipWhiteSpaceChars[char] then
			while pos <= length and whiteSpaceChars[command:sub(pos, pos)] do
				pos += 1
			end
		end
	end

	return table.concat(buffer), pos - 1
end

local function makeToken(kind, value, command, from, to, usedChar)
	return {
		kind = kind,
		value = value,
		usedChar = usedChar,
		from = from,
		to = to,
		raw = command:sub(from, to),
	}
end

-- Splits a candidate around the first match of the query (case-insensitive).
local function splitMatch(candidate, query)
	if query == "" then
		return "", "", candidate
	end

	local startAt, endAt = candidate:lower():find(query:lower(), 1, true)

	if not startAt then
		return "", "", candidate
	end

	return candidate:sub(1, startAt - 1), candidate:sub(startAt, endAt), candidate:sub(endAt + 1)
end

local function quoteIfNeeded(text, usedChar)
	if usedChar then
		return usedChar .. text .. usedChar
	end

	if text:find("%s") then
		return `"{text}"`
	end

	return text
end

-- Keeps the quote the user typed around rich text, so a quoted argument still shows its quotes
local function wrapQuotes(richText: string, usedChar: string?): string
	if usedChar then
		return esc(usedChar) .. richText .. esc(usedChar)
	end

	return richText
end

local function makeCorrection(from, to, replacement, usedChar)
	return {
		from = from,
		to = to,
		text = quoteIfNeeded(replacement, usedChar),
	}
end

-- Reads the loop part of "100^1" or "inf^0.5" (the text before the command name).
-- Returns the loop settings, or nil and the message to show.
local function parseLoop(spec: string)
	local parts = spec:split(LOOP_CHAR)

	if #parts > 2 then
		return nil, " - invalid loop"
	end

	local count
	if parts[1]:lower() == INFINITE then
		count = math.huge
	else
		count = tonumber(parts[1])

		if count == nil or count < 1 or count ~= math.floor(count) then
			return nil, " - invalid loop count"
		end
	end

	local delay = 0
	if parts[2] ~= nil then
		delay = tonumber(parts[2])

		if delay == nil or delay < 0 then
			return nil, " - invalid loop delay"
		end
	end

	return { count = count, delay = delay }
end

local commandParser = {}
commandParser.__index = commandParser
commandParser.colorFromName = colorFromName
commandParser.removeWhiteSpace = removeWhiteSpace

-- Splits the raw input into statements, one per command (they are separated by "\").
-- Each statement keeps its tokens, with positions in the raw text, and the spaces after them.
function commandParser:parse(command: string)
	local cmdInput = self.cmdInput
	local statements = {}
	local allTokens = {}
	local length = #command
	local current = { tokens = {}, start = 1 }
	local pos = 1

	table.insert(statements, current)

	while pos <= length do
		local char = command:sub(pos, pos)

		if whiteSpaceChars[char] then
			pos += 1
		elseif char == SEPARATOR then
			current.stop = pos
			current = { tokens = {}, start = pos + 1 }
			table.insert(statements, current)
			pos += 1
		else
			local token
			local closeAt = startStringChars[char] and findClosingQuote(command, char, pos)

			if closeAt then
				local value = (command:sub(pos + 1, closeAt - 1):gsub("\\" .. char, char))
				token = makeToken("string", value, command, pos, closeAt, char)
				pos = closeAt + 1
			else
				local value, lastAt = readIdentifier(command, pos)
				token = makeToken("identifier", value, command, pos, lastAt)
				pos = lastAt + 1
			end

			table.insert(current.tokens, token)
			table.insert(allTokens, token)
		end
	end

	current.stop = length + 1

	for _, statement in statements do
		local firstToken = statement.tokens[1]
		local lastToken = statement.tokens[#statement.tokens]
		local afterAt = if lastToken then lastToken.to + 1 else statement.start

		statement.lead = if firstToken then command:sub(statement.start, firstToken.from - 1) else ""
		statement.spaces = command:sub(afterAt, statement.stop - 1)
	end

	local values = {}
	for _, token in allTokens do
		table.insert(values, token.value)
	end

	local lastStatement = statements[#statements]

	cmdInput.rawText         = command
	cmdInput.parsed          = allTokens
	cmdInput.spacesAtEnd     = lastStatement.spaces
	cmdInput.noHighlightText = table.concat(values, " ") .. lastStatement.spaces

	return statements
end

-- Validates the token of one argument. Stores the value in info.args and returns what to show.
function commandParser:parseArg(arg, token, index, info)
	local text = token.value
	local result = argsValidator:validate(arg, text)
	local isValid = result.success and #text > 0

	local parsedData = { success = isValid, text = text }
	if isValid then
		parsedData.value = result.value
	end
	info.args[index] = parsedData

	if isValid then
		-- the display keeps what was typed, quotes included
		local display = if result.display then wrapQuotes(result.display, token.usedChar) else esc(token.raw)
		return { success = true, display = colorFromName(display, result.color or "valid") }
	end

	local options = argsValidator.getOptions(arg, result)
	local bestMatch = nil

	if #text > 0 then
		bestMatch = searchController:searchAtArray(options, text)[1]
	end

	if bestMatch then
		local left, typed, right = splitMatch(bestMatch, text)
		info.correction = makeCorrection(token.from, token.to, bestMatch, token.usedChar)

		local inner = esc(left) .. colorFromName(esc(typed), "warn") .. esc(right)
		return {
			success = false,
			suggestion = true,
			display = colorFromName(wrapQuotes(inner, token.usedChar), "comment"),
		}
	end

	return {
		success = false,
		display = colorFromName(esc(token.raw), result.color or "warn"),
		message = result.message,
		comment = result.comment,
	}
end

-- The argument after the last space: nothing typed yet, so only suggest the first option.
function commandParser:parsePending(arg, info, statement)
	local result = argsValidator:validate(arg, "")
	local options = argsValidator.getOptions(arg, result)

	if #options == 0 then
		return nil
	end

	local best = options[1]

	-- the suggestion goes where the next argument would be typed, before any "\"
	if not arg.optional then
		info.correction = { from = statement.stop, to = statement.stop - 1, text = quoteIfNeeded(best) }
	else
		info.hasGhost = true
	end

	return colorFromName(esc(best), "comment")
end

-- Highlights the arguments of a valid command and decides the comment and the run error.
function commandParser:highlightArgs(info, cmdData, statement, hasSpaces, buffer, isLast: boolean)
	local tokens = statement.tokens
	local args = cmdData.args
	local argCount = #args
	local typedCount = #tokens - 1

	local lastProcessed = 1 -- index in `tokens` of the last token that was validated
	local failure = nil     -- the first invalid argument

	for index, arg in args do
		local token = tokens[index + 1]

		if token == nil then
			if hasSpaces then
				local ghost = self:parsePending(arg, info, statement)
				if ghost then
					table.insert(buffer, ghost)
				end
			end
			break
		end

		local result = self:parseArg(arg, token, index, info)
		lastProcessed = index + 1

		if result.display then
			table.insert(buffer, result.display)
		end

		if not result.success then
			failure = { index = index, result = result }
			break
		end
	end

	-- tokens after an invalid argument are shown as typed, without validation
	for i = lastProcessed + 1, math.min(#tokens, argCount + 1) do
		table.insert(buffer, esc(tokens[i].raw))
	end

	if #tokens > argCount + 1 then
		local extraText = self.cmdInput.rawText:sub(tokens[argCount + 2].from, tokens[#tokens].to)
		table.insert(buffer, colorFromName(`<b>{esc(extraText)}</b>`, "warn"))

		info.runError = " - extra arg"
		info.comment = { text = " - extra arg", color = "warn" }
		return
	end

	if failure then
		local result = failure.result

		-- the run error names the argument; the comment explains what is wrong with it
		info.runError = ` - {argName(args[failure.index], failure.index)} is invalid`

		if result.message and not result.suggestion then
			info.comment = { text = result.message, color = if result.comment then "comment" else "warn" }
		end
		return
	end

	-- nothing invalid: report a missing required argument and hint the next one
	for index = typedCount + 1, argCount do
		local arg = args[index]

		if not arg.optional then
			info.runError = ` - {argName(arg, index)} is missing`
			break
		end
	end

	local hintIndex = nil

	if hasSpaces then
		hintIndex = typedCount + 1
	elseif typedCount > 0 then
		hintIndex = typedCount
	end

	local hintArg = hintIndex and args[hintIndex]

	-- a hint is for the command being typed; a finished statement before "\" does not need one
	if hintArg and isLast then
		local prefix = if hasSpaces then "" else ": "
		info.comment = { text = `{prefix}({self:highlightArgType(hintArg)})` }
	end
end

function commandParser:highlightArgType(arg)
	local optional = arg.optional and colorFromName("?", "symbol") or ""
	local text = `{colorFromName(arg.kind, arg.kind)}{optional}`

	if arg.name then
		return `{removeWhiteSpace(arg.name)}: {text}`
	end

	return text
end

function commandParser:highlightArgsType(args)
	if #args == 0 then return "" end

	local buffer = {}

	for _, arg in args do
		table.insert(buffer, self:highlightArgType(arg))
	end

	return `({table.concat(buffer, ", ")})`
end

function commandParser:resetInput()
	local cmdInput = self.cmdInput

	cmdInput.highlightText  = ""
	cmdInput.commandName    = ""
	cmdInput.commandData    = nil
	cmdInput.isValidCommand = false
	cmdInput.isAbreviated   = false
	cmdInput.bestMatch      = nil
	cmdInput.bestMatches    = {}
	cmdInput.correctionText = nil
	cmdInput.correction     = nil
	cmdInput.runError       = nil
	cmdInput.hasGhost       = false
	cmdInput.args           = {}
	cmdInput.statements     = {}

	self:setComment("")
end

-- Highlights one statement (one command). Returns what it shows and what it needs to run.
function commandParser:highlightStatement(statement, isLast: boolean)
	local cmdInput = self.cmdInput
	local tokens = statement.tokens
	local info = {
		lead = statement.lead,
		text = "",
		trailing = statement.spaces,
		args = {},
		commandName = "",
		bestMatches = {},
		isValidCommand = false,
		isAbreviated = false,
	}

	if #tokens == 0 then
		info.empty = true
		return info
	end

	local nameToken = tokens[1]
	local hasSpaces = #statement.spaces > 0
	local typedName = nameToken.value
	local rest = typedName
	local loop = nil
	local loopError = nil
	local isRepeat = false

	-- "count^delay^" in front of the name, then "!" for repeat
	if nameToken.kind == "identifier" then
		local prefix, after = typedName:match("^(.*%^)(.*)$")

		if prefix then
			loop, loopError = parseLoop(prefix:sub(1, -2))
			rest = after
		end

		if rest:sub(1, 1) == REPEAT_CHAR then
			isRepeat = true
			rest = rest:sub(2)
		end
	end

	local prefixRaw = typedName:sub(1, #typedName - #rest)
	local commandKey = rest:lower()
	local cmdData = getCommand(commandKey)

	info.commandName = commandKey
	info.commandData = cmdData
	info.isValidCommand = cmdData ~= nil
	info.isAbreviated = cmdData ~= nil and cmdData.name ~= commandKey
	info.loop = loop

	if loopError then
		info.text = colorFromName(esc(typedName), "error")
		info.runError = loopError
		info.comment = { text = loopError, color = "error" }
		return info
	end

	local prefixDisplay = ""
	if prefixRaw ~= "" then
		prefixDisplay = colorFromName(esc(prefixRaw), "comment")
	end

	if not cmdData then
		local bestMatches = commandsController:search(commandKey)
		local bestMatch = bestMatches[1]

		info.bestMatches = bestMatches
		info.bestMatch = bestMatch

		if hasSpaces or #tokens > 1 or not bestMatch then
			local body = cmdInput.rawText:sub(nameToken.from, tokens[#tokens].to)

			info.text = colorFromName(esc(body), "error")
			info.runError = " - invalid command"
			info.comment = { text = " - invalid command", color = "error" }
			return info
		end

		-- a single name close to a command: show the match and offer it as a correction
		local left, typed, right = splitMatch(bestMatch, rest)

		info.text = prefixDisplay .. colorFromName(esc(left) .. colorFromName(esc(typed), "warn") .. esc(right), "comment")
		info.correction = makeCorrection(nameToken.from, nameToken.to, prefixRaw .. bestMatch, nameToken.usedChar)
		info.correctionText = bestMatch
		info.runError = " - invalid command"
		return info
	end

	local buffer = { prefixDisplay .. colorFromName(esc(rest), "valid") }

	-- while only the name is typed, show the other names of the command
	if isLast and #tokens == 1 and not hasSpaces and #cmdData.aliases > 1 then
		local clone = table.clone(cmdData.aliases)
		local index = table.find(clone, commandKey)

		if index then
			table.remove(clone, index)
		end

		info.comment = { text = `: [{table.concat(clone, ", ")}]`, color = "comment" }
	end

	if isRepeat and #tokens == 1 then
		-- "!command" without new arguments: it runs with the arguments it last used
		info.repeatLast = true

		if #cmdData.args > 0 and commandsController:getLastArgs(cmdData.name) == nil then
			info.runError = " - no previous arguments"
			info.comment = { text = " - no previous arguments", color = "error" }
		end
	else
		self:highlightArgs(info, cmdData, statement, hasSpaces, buffer, isLast)
	end

	info.text = table.concat(buffer, " ")
	return info
end

-- Builds the rich text shown in the input and fills cmdInput (comment, correction, runError and the
-- statements to run). The last statement is the one being typed, so the search and hints follow it.
function commandParser:highlight(statements)
	local cmdInput = self.cmdInput
	self:resetInput()

	local lastIndex = #statements
	local infos = {}

	for index, statement in statements do
		infos[index] = self:highlightStatement(statement, index == lastIndex)
	end

	local focus = infos[lastIndex]

	cmdInput.statements     = infos
	cmdInput.commandName    = focus.commandName
	cmdInput.commandData    = focus.commandData
	cmdInput.isValidCommand = focus.isValidCommand
	cmdInput.isAbreviated   = focus.isAbreviated
	cmdInput.bestMatch      = focus.bestMatch
	cmdInput.bestMatches    = focus.bestMatches
	cmdInput.args           = focus.args

	-- the first problem wins, so the bar points at the statement that has to be fixed first
	local comment = nil

	for _, info in infos do
		-- an empty statement is only a problem when another statement comes with it ("drop\")
		if info.empty and lastIndex > 1 then
			info.runError = " - command missing"
		end

		if info.runError and cmdInput.runError == nil then
			cmdInput.runError = info.runError
		end

		if info.correction and cmdInput.correction == nil then
			cmdInput.correction = info.correction
		end

		if info.hasGhost then
			cmdInput.hasGhost = true
		end

		if info.comment and comment == nil then
			comment = info.comment
		end
	end

	if comment then
		self:setComment(comment.text, comment.color)
	end

	local pieces = {}

	for index, info in infos do
		-- a suggestion or a ghost argument already takes the place of the spaces after it
		local trailing = if info.correction or info.hasGhost then "" else info.trailing
		local piece = info.lead .. info.text .. trailing

		if index < lastIndex then
			piece ..= colorFromName(esc(SEPARATOR), "symbol")
		end

		table.insert(pieces, piece)
	end

	local highlightText = table.concat(pieces)
	cmdInput.highlightText = highlightText

	return highlightText
end

function commandParser:setComment(...)
	return self.setCommentCallback(...)
end

function commandParser.new(cmdInput, commentCallback)
	return setmetatable({
		cmdInput = cmdInput,
		setCommentCallback = commentCallback
	}, commandParser)
end

return commandParser
