local commandsController = require("../controllers/commandsController")
local searchController = require("../controllers/searchController")
local argsController = require("../controllers/argsController")

local commandsList = require("../commands/list")
local colors = require("../config/colors")

local tools = require("../utils/tools")
local logger = require("../utils/logger")

local colorFromRGB = tools.colorFromRGB
-- local richTextSize = tools.richTextSize

local startStringChars = tools.lookupify({"`", "'", "\""})
local whiteSpaceChars = tools.lookupify({" ", "\t", "\n", "\r"})
local skipWhiteSpaceChars = tools.lookupify({",","|","&"})

local function createToken(kind, value, usedChar)
	local text = value
	if kind == "string" then
		text = `{usedChar}{text}{usedChar}`
	end

	return setmetatable({
		kind = kind,
		value = value,
		usedChar = usedChar
	}, {
		__tostring = function() return text end
	})
end

local function concatTokens(tokens, separator)
	local buffer = {}
	for i = 1, #tokens do
		table.insert(buffer, tostring(tokens[i]))
	end
	return table.concat(buffer, separator)
end

local function getCommand(commandName)
	return commandsList.lookup[commandName]
end

local function matchText(text1, text2)
	local foundAt = text1:find(text2)
	
	local left  = text1:sub(1, foundAt - 1)
	local right = text1:sub(foundAt + #text2, -1)
	
	return left, right
end

local function colorFromName(text, name, fallBack)
	local acolors = colors.args
	return colorFromRGB(text, acolors[name] or fallBack or acolors.others)
end

local function removeWhiteSpace(text)
	return text:gsub(".", function(char)
		return whiteSpaceChars[char] and "_" or char
	end)
end

local function getArgTypes(arg, hasSpaces)
	local optional  = arg.optional and "?" or ""
	local separator = hasSpaces and "" or ": "
	local display   = arg.kind
	
	if arg.name then
		display = `{removeWhiteSpace(arg.name)}: {display}`
	end
	
	return `{separator}({display}{optional})`
end

local commandParser = {}
commandParser.__index = commandParser
commandParser.colorFromName = colorFromName
commandParser.removeWhiteSpace = removeWhiteSpace

function commandParser:parse(command)
	local cmdInput = self.cmdInput
	local length   = #command
	local pos      = 0

	local parsed = {}
	local buffer = {}
	local spaces = {}

	cmdInput.parsed = parsed

	while pos < length do
		pos += 1
		local char = command:sub(pos, pos)
		
		if startStringChars[char] then
			local startAt = pos + 1
			local endAt   = pos
			local found   = false
			
			while endAt do
				endAt = command:find(char, endAt + 1, true)
				
				if endAt and command:sub(endAt - 1, endAt - 1) ~= "\\" then
					table.insert(parsed, createToken("string", command:sub(startAt, endAt - 1), char))
					pos   = endAt
					found = true
					break
				end
			end
			
			if found then
				buffer, spaces = {}, {}
				continue
			end
		end
		
		while pos <= length and not whiteSpaceChars[char] do
			table.insert(buffer, char)
			
			pos += 1
			char = command:sub(pos, pos)
			
			if not skipWhiteSpaceChars[char] then continue end
			
			table.insert(buffer, char)
			
			repeat
				pos += 1
				char = command:sub(pos, pos)
			until pos > length or not whiteSpaceChars[char]
		end
		
		if #buffer > 0 then
			table.insert(parsed, createToken("identifier", table.concat(buffer)))
			buffer, spaces = {}, {}
		end
		
		if char ~= "" then
			table.insert(spaces, char)
		end
	end
	
	local spacesAtEnd = table.concat(spaces)
	
	cmdInput.spacesAtEnd     = spacesAtEnd
	cmdInput.noHighlightText = concatTokens(parsed, " ") .. spacesAtEnd
	
	for i, token in parsed do
		parsed[i].value = tools.escapeRichText(token.value)
	end
	
	return parsed
end

function commandParser:parseArg(arg, text)
	local cmdInput = self.cmdInput
	
	local result = argsController:validate(arg, text)
	
	if result.options and not result.success then
		local bestMatch = searchController:searchAtArray(result.options, text)[1]
		
		if not bestMatch then
			return { display = colorFromName(text, "error"), success = false }
		end
		
		cmdInput.correctionText = bestMatch
		local left, right = matchText(bestMatch, text)
		local highlight = colorFromName(text, "warn")
		
		return {
			success = false,
			display = colorFromName(`{left}{highlight}{right}`, "comment")
		}
	end

	if result.success then
		if result.value == nil then
			logger:error(`'{arg.kind}' is returning a nil value`)
			return
		end
		
		local color = result.color or "valid"
		return {
			success = true,
			value   = result.value or text,
			display = colorFromName(result.display or text, color)
		}
	end
	
	self:setComment(result.message, result.comment and "comment" or "warn")
	
	return {
		display = colorFromName(text, result.color or "warn"),
		success = false
	}
end

function commandParser:highlightArgType(arg)
	local optional = arg.optional and colorFromName("?", "symbol") or ""
	local text = `{colorFromName(arg.kind, arg.kind)}{optional}`
	
	if arg.name then
		local name = removeWhiteSpace(arg.name)
		return `{name}: {text}`
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
	cmdInput.highlightText   = ""
	cmdInput.commandName	 = ""
	cmdInput.isValidCommand  = false
	cmdInput.bestMatch	   = nil
	cmdInput.correctionText  = nil
	self:setComment("")
end

function commandParser:highlight(parsed)
	local cmdInput = self.cmdInput
	self:resetInput()
	
	if #parsed == 0 then return end

	local buffer = {}
	
	local cmdName         = tostring(table.remove(parsed, 1))
	local cmdData         = getCommand(cmdName)
	local isValidCommand  = cmdData ~= nil
	local isAbreviated    = isValidCommand and cmdData.name ~= cmdName
	local spacesAtEnd     = cmdInput.spacesAtEnd
	local hasSpaces       = #spacesAtEnd > 0

	cmdInput.commandName    = cmdName
	cmdInput.commandData    = cmdData
	cmdInput.isValidCommand = isValidCommand
	cmdInput.isAbreviated   = isAbreviated
	cmdInput.args           = {}
	
	if not isValidCommand then
		cmdInput.bestMatches = commandsController:search(cmdName)
		cmdInput.bestMatch = cmdInput.bestMatches[1]
		
		if hasSpaces or #parsed > 0 or not cmdInput.bestMatch then
			cmdInput.highlightText = colorFromName(
				table.concat({ cmdName, concatTokens(parsed, " ") }, " "),
				"error"
			) .. spacesAtEnd
			self:setComment(" - invalid command", "error")
			return
		end
	end
	
	table.insert(buffer, colorFromName(cmdName,
		(isValidCommand		 and "valid")
		or (cmdInput.bestMatch  and "warn")
		or "error"
	))

	if cmdInput.bestMatch then
		local left, right = matchText(cmdInput.bestMatch, cmdName)
		local last = buffer[#buffer]
		buffer[#buffer] = colorFromName(`{left}{last}{right}`, "comment")
		cmdInput.correctionText = cmdName
	end
	
	if isValidCommand then
		local isEmpty = #parsed == 0 and #spacesAtEnd == 0
		local isShowingType = false
		local hasBeenParsed = true
		
		if isEmpty and #cmdData.aliases > 1 then
			local clone = table.clone(cmdData.aliases)
			table.remove(clone, table.find(clone, cmdName))
			self:setComment(`: [{table.concat(clone, ", ")}]`, "comment")
		end
		
		for key, arg in ipairs(cmdData.args) do
			if isEmpty then break end
			
			local token = table.remove(parsed, 1)
			
			if token then
				local result = self:parseArg(arg, tostring(token))
				table.insert(buffer, result.display or tostring(token))
				
				table.insert(cmdInput.args, result)
				if not result.success then hasBeenParsed = false break end
			end
			
			if isShowingType then continue end
			if #parsed > 0 then continue end
			
			local nextArg = cmdData.args[key + 1]
			if hasSpaces and token ~= nil and not nextArg then continue end
			
			local currArg = (hasSpaces and token ~= nil) and nextArg or arg
			
			if currArg then
				isShowingType = true
				local argType = self:highlightArgType(currArg)
				local separator = hasSpaces and "" or ": "
				self:setComment(`{separator}({argType})`)
			end
		end
		
		if hasBeenParsed and #parsed > 0 then
			local text = concatTokens(parsed, " ")
			table.insert(buffer, colorFromName(`<b>{text}</b>`, "warn"))
			self:setComment(` - extra arg`, "warn")
		end
	end
	
	local highlightText	 = table.concat(buffer, " ") .. spacesAtEnd
	cmdInput.highlightText  = highlightText
	
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