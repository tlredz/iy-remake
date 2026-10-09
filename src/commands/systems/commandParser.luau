local commandsController = require("../controllers/commandsController")
local searchController   = require("../controllers/searchController")

local commandsList  = require("../list")
local colors        = require("../../framework/config/colors")

local tools         = require("../../utils/tools")
local argsValidator = require("./argsValidator")

local colorFromRGB = tools.colorFromRGB
local esc          = tools.escapeRichText

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

-- Reads a bare word. A comma, pipe or ampersand also swallows the whitespace after it,
-- so "1, 2" is read as the single value "1,2" (the same way the command used to be read).
local function readIdentifier(command: string, startAt: number): (string, number)
	local buffer = {}
	local pos = startAt
	local length = #command
	
	while pos <= length do
		local char = command:sub(pos, pos)
		
		if whiteSpaceChars[char] then
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

local function makeCorrection(from, to, replacement, usedChar)
	return {
		from = from,
		to = to,
		text = quoteIfNeeded(replacement, usedChar),
	}
end

local commandParser = {}
commandParser.__index = commandParser
commandParser.colorFromName = colorFromName
commandParser.removeWhiteSpace = removeWhiteSpace

-- Splits the raw input into tokens. Each token keeps its position in the raw text.
function commandParser:parse(command: string)
	local cmdInput = self.cmdInput
	local tokens = {}
	local pos = 1
	local length = #command
	
	while pos <= length do
		local char = command:sub(pos, pos)
		
		if whiteSpaceChars[char] then
			pos += 1
		else
			local closeAt = startStringChars[char] and findClosingQuote(command, char, pos)
			
			if closeAt then
				local value = (command:sub(pos + 1, closeAt - 1):gsub("\\" .. char, char))
				table.insert(tokens, makeToken("string", value, command, pos, closeAt, char))
				pos = closeAt + 1
			else
				local value, lastAt = readIdentifier(command, pos)
				table.insert(tokens, makeToken("identifier", value, command, pos, lastAt))
				pos = lastAt + 1
			end
		end
	end
	
	local lastToken = tokens[#tokens]
	local afterTokens = lastToken and (lastToken.to + 1) or 1
	local spacesAtEnd = command:sub(afterTokens)
	
	local values = {}
	for _, token in tokens do
		table.insert(values, token.value)
	end
	
	cmdInput.rawText         = command
	cmdInput.parsed          = tokens
	cmdInput.spacesAtEnd     = spacesAtEnd
	cmdInput.noHighlightText = table.concat(values, " ") .. spacesAtEnd
	
	return tokens
end

-- Validates the token of one argument. Sets cmdInput.args[index] and returns what to show.
function commandParser:parseArg(arg, token, index)
	local cmdInput = self.cmdInput
	local text = token.value
	local result = argsValidator:validate(arg, text)
	local isValid = result.success and #text > 0
	
	local parsedData = { success = isValid, text = text }
	if isValid then
		parsedData.value = result.value
	end
	cmdInput.args[index] = parsedData
	
	if isValid then
		local display = result.display or esc(text)
		return { success = true, display = colorFromName(display, result.color or "valid") }
	end
	
	local options = argsValidator.getOptions(arg, result)
	local bestMatch = nil
	
	if #text > 0 then
		bestMatch = searchController:searchAtArray(options, text)[1]
	end
	
	if bestMatch then
		local left, typed, right = splitMatch(bestMatch, text)
		cmdInput.correction = makeCorrection(token.from, token.to, bestMatch, token.usedChar)
		
		return {
			success = false,
			suggestion = true,
			display = colorFromName(esc(left) .. colorFromName(esc(typed), "warn") .. esc(right), "comment"),
		}
	end
	
	return {
		success = false,
		display = colorFromName(esc(text), result.color or "warn"),
		message = result.message,
		comment = result.comment,
	}
end

-- The argument after the last space: nothing typed yet, so only suggest the first option.
function commandParser:parsePending(arg)
	local cmdInput = self.cmdInput
	local result = argsValidator:validate(arg, "")
	local options = argsValidator.getOptions(arg, result)
	
	if #options == 0 then
		return nil
	end
	
	local best = options[1]
	local position = #cmdInput.rawText + 1
	
	if not arg.optional then
		cmdInput.correction = { from = position, to = position - 1, text = quoteIfNeeded(best) }
	else
		cmdInput.hasGhost = true
	end
	
	return colorFromName(esc(best), "comment")
end

-- Highlights the arguments of a valid command and decides the comment and the run error.
function commandParser:highlightArgs(cmdData, parsed, hasSpaces, buffer)
	local cmdInput = self.cmdInput
	local args = cmdData.args
	local argCount = #args
	local typedCount = #parsed - 1
	
	local lastProcessed = 1 -- index in `parsed` of the last token that was validated
	local failure = nil     -- the first invalid argument
	
	for index, arg in args do
		local token = parsed[index + 1]
		
		if token == nil then
			if hasSpaces then
				local ghost = self:parsePending(arg)
				if ghost then
					table.insert(buffer, ghost)
				end
			end
			break
		end
		
		local result = self:parseArg(arg, token, index)
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
	for i = lastProcessed + 1, math.min(#parsed, argCount + 1) do
		table.insert(buffer, esc(parsed[i].raw))
	end
	
	local hasExtra = #parsed > argCount + 1
	
	if hasExtra then
		local extraText = cmdInput.rawText:sub(parsed[argCount + 2].from, parsed[#parsed].to)
		table.insert(buffer, colorFromName(`<b>{esc(extraText)}</b>`, "warn"))
		
		cmdInput.runError = " - extra arg"
		self:setComment(" - extra arg", "warn")
		return
	end
	
	if failure then
		local result = failure.result
		
		-- the run error names the argument; the comment explains what is wrong with it
		cmdInput.runError = ` - {argName(args[failure.index], failure.index)} is invalid`
		
		if result.message and not result.suggestion then
			self:setComment(result.message, result.comment and "comment" or "warn")
		end
		return
	end
	
	-- nothing invalid: report a missing required argument and hint the next one
	for index = typedCount + 1, argCount do
		local arg = args[index]
		
		if not arg.optional then
			cmdInput.runError = ` - {argName(arg, index)} is missing`
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
	
	if hintArg then
		local prefix = hasSpaces and "" or ": "
		self:setComment(`{prefix}({self:highlightArgType(hintArg)})`)
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
	
	self:setComment("")
end

-- Builds the rich text shown in the input and fills cmdInput (comment, correction, runError).
function commandParser:highlight(parsed)
	local cmdInput = self.cmdInput
	self:resetInput()
	
	if #parsed == 0 then return "" end
	
	local nameToken      = parsed[1]
	local typedName      = nameToken.value
	local commandKey     = typedName:lower()
	local cmdData        = getCommand(commandKey)
	local isValidCommand = cmdData ~= nil
	local spacesAtEnd    = cmdInput.spacesAtEnd
	local hasSpaces      = #spacesAtEnd > 0
	
	cmdInput.commandName    = commandKey
	cmdInput.commandData    = cmdData
	cmdInput.isValidCommand = isValidCommand
	cmdInput.isAbreviated   = isValidCommand and cmdData.name ~= commandKey
	
	if not isValidCommand then
		cmdInput.bestMatches = commandsController:search(commandKey)
		cmdInput.bestMatch   = cmdInput.bestMatches[1]
		
		if hasSpaces or #parsed > 1 or not cmdInput.bestMatch then
			local body = cmdInput.rawText:sub(nameToken.from, parsed[#parsed].to)
			
			cmdInput.runError = " - invalid command"
			self:setComment(" - invalid command", "error")
			cmdInput.highlightText = colorFromName(esc(body), "error") .. spacesAtEnd
			
			return cmdInput.highlightText
		end
	end
	
	local buffer = {}
	
	if isValidCommand then
		table.insert(buffer, colorFromName(esc(typedName), "valid"))
	else
		local bestMatch = cmdInput.bestMatch
		local left, typed, right = splitMatch(bestMatch, typedName)
		
		table.insert(buffer, colorFromName(esc(left) .. colorFromName(esc(typed), "warn") .. esc(right), "comment"))
		
		cmdInput.correctionText = bestMatch
		cmdInput.correction = makeCorrection(nameToken.from, nameToken.to, bestMatch, nameToken.usedChar)
		cmdInput.runError = " - invalid command"
	end
	
	if isValidCommand then
		-- while only the name is typed, show the other names of the command
		local isEmpty = #parsed == 1 and not hasSpaces
		
		if isEmpty and #cmdData.aliases > 1 then
			local clone = table.clone(cmdData.aliases)
			local index = table.find(clone, commandKey)
			
			if index then
				table.remove(clone, index)
			end
			
			self:setComment(`: [{table.concat(clone, ", ")}]`, "comment")
		end
		
		self:highlightArgs(cmdData, parsed, hasSpaces, buffer)
	end
	
	if cmdInput.correction or cmdInput.hasGhost then
		spacesAtEnd = ""
	end
	
	local highlightText = table.concat(buffer, " ") .. spacesAtEnd
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
