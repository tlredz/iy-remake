local robloxServices = require("../../framework/services/rbxServices")
local playerService  = require("../../framework/services/playerService")
local commandsList   = require("../list")
local waypointsData  = require("../../storage/data/waypoints")
local aliasesData    = require("../../storage/data/aliases")
local pluginsData    = require("../../storage/data/plugins")
local tools          = require("../../utils/tools")

--[[
	Every validator receives the raw text of one argument and the arg config,
	and returns a result table:

	success   boolean  the text is a valid value
	value     any      the parsed value (only meaningful when success is true)
	display   string?  rich text used to show the valid value (defaults to the text)
	color     string?  colour name used for the display ("valid" by default)
	message   string?  shown as a warning (or a comment) when the text is invalid
	comment   boolean? show the message as a comment instead of a warning
	options   table?   suggestions used for autocomplete when the text is invalid

	The parser only calls a validator with non-empty text, except for pending
	arguments (the user typed a space but nothing after it yet), which get "".
]]

local argsValidator = {}

local function fail(message, options, comment)
	return {
		success = false,
		message = message,
		options = options,
		comment = comment,
	}
end

-- Options can be a table or a "a|b|c" string (used by some command definitions).
function argsValidator.normalizeOptions(options: any): { string }
	if type(options) == "string" then
		return string.split(options, "|")
	end
	return options or {}
end

-- Options used for autocomplete: the validator's own suggestions win over the arg config.
function argsValidator.getOptions(arg: any, result: any?): { string }
	local options = (result and result.options) or arg.options
	return argsValidator.normalizeOptions(options)
end

-- Case-insensitive lookup that returns the canonical spelling of the option.
local function findOption(options, text)
	local lowered = text:lower()
	
	for _, option in options do
		local name = tostring(option)
		if name:lower() == lowered then
			return name
		end
	end
	
	return nil
end

local function keysOf(tab)
	if type(tab) ~= "table" then return {} end
	return tools.unlookupify(tab)
end

local function validateFreeText(text)
	return {
		success = true,
		value = text,
		color = "string",
	}
end

local function validateString(text, arg)
	local options = argsValidator.normalizeOptions(arg.options)
	
	if #options == 0 then
		return validateFreeText(text)
	end
	
	local match = findOption(options, text)
	
	if match then
		return { success = true, value = match, color = "string" }
	end
	
	return fail(" - invalid option", options)
end

local BOOLEAN_WORDS = {
	["true"]     = true,
	["yes"]      = true,
	["enabled"]  = true,
	["false"]    = false,
	["no"]       = false,
	["disabled"] = false,
}

local function validateBoolean(text)
	local value = BOOLEAN_WORDS[text:lower()]
	
	if value == nil then
		return fail(" - invalid boolean", { "false", "true" })
	end
	
	return {
		success = true,
		value = value,
		color = "boolean",
	}
end

local function validateNumber(text, arg)
	local number = tonumber(text)
	
	if number == nil or number ~= number or math.abs(number) == math.huge then
		return fail(" - invalid number")
	end
	
	local min, max = arg.min, arg.max
	
	if arg.clamp then
		min, max = arg.clamp[1], arg.clamp[2]
	end
	
	if min and number < min then
		return fail(` - the <b>MIN</b> is <b>{min}</b>`)
	end
	
	if max and number > max then
		return fail(` - the <b>MAX</b> is <b>{max}</b>`)
	end
	
	if arg.floor and math.floor(number) ~= number then
		return fail(" - whole numbers only")
	end
	
	-- at most 5 decimal places
	if tonumber(string.format("%.5f", number)) ~= number then
		return fail(" - too many decimal places")
	end
	
	return {
		success = true,
		value = number,
		display = `<b>{text}</b>`,
		color = "number",
	}
end

local function validateVector3(text)
	local parts = text:split(",")
	
	if #parts > 3 then
		return fail(" - too many args")
	end
	
	local values = {}
	
	for index, part in parts do
		-- an empty component (like "1,,3") counts as 0
		if part:match("^%s*$") then
			part = "0"
		end
		
		local result = validateNumber(part, {})
		
		if not result.success then
			return result
		end
		
		values[index] = result.value
	end
	
	if #values ~= 3 then
		return {
			success = false,
			comment = true,
			message = `: {({"X", "Y", "Z"})[#values + 1]}`,
		}
	end
	
	local vector = Vector3.new(values[1], values[2], values[3])
	
	return {
		success = true,
		value = vector,
		display = `({vector})`,
		color = "others",
	}
end

local function validateColor3(text)
	local hex = text:match("^#?(%x%x%x%x%x%x)$")
	
	if hex then
		local r = tonumber(hex:sub(1, 2), 16)
		local g = tonumber(hex:sub(3, 4), 16)
		local b = tonumber(hex:sub(5, 6), 16)
		
		return {
			success = true,
			value = Color3.fromRGB(r, g, b),
			color = "others",
		}
	end
	
	local parts = text:split(",")
	
	if #parts ~= 3 then
		return fail(" - use R,G,B or #hex")
	end
	
	local values = {}
	
	for index, part in parts do
		local result = validateNumber(part, { min = 0, max = 255, floor = true })
		
		if not result.success then
			return result
		end
		
		values[index] = result.value
	end
	
	return {
		success = true,
		value = Color3.fromRGB(values[1], values[2], values[3]),
		color = "others",
	}
end

local PLAYER_KEYWORDS = {
	me = true,
	all = true,
	others = true,
	random = true,
}

local function validatePlayer(text)
	if text == "" then
		return fail(" - player missing")
	end
	
	local lowered = text:lower()
	
	-- selectors: me, all, others, random, #amount, %team
	if PLAYER_KEYWORDS[lowered] or lowered:match("^#%d+$") or lowered:match("^%%.+$") then
		return { success = true, value = text, color = "valid" }
	end
	
	if #playerService:getPlayersByName(text) > 0 then
		return { success = true, value = text, color = "valid" }
	end
	
	local names = {}
	for _, player in robloxServices.Players:GetPlayers() do
		table.insert(names, player.Name)
	end
	
	return fail(" - player not found", names)
end

local COMMON_CLASSES = {
	"BasePart", "Part", "MeshPart", "Model", "Folder", "Script", "LocalScript",
	"ModuleScript", "Sound", "Humanoid", "Tool", "ClickDetector",
	"ProximityPrompt", "TouchTransmitter", "SpawnLocation", "Seat", "VehicleSeat",
}

local function validateClassName(text)
	-- Instance.new is the only reliable check for a valid class name
	local isValid = pcall(function()
		local instance = Instance.new(text)
		instance:Destroy()
	end)
	
	if isValid then
		return { success = true, value = text, color = "valid" }
	end
	
	return fail(" - invalid class name", COMMON_CLASSES)
end

local function validateWaypoint(text)
	-- waypoints are stored per place: { [placeId] = { [name] = coords } }
	local names = keysOf(waypointsData:getValue(tostring(game.PlaceId)))
	
	if #names == 0 then
		return fail(" - no waypoints created")
	end
	
	local match = findOption(names, text)
	
	if match then
		return { success = true, value = match, color = "valid" }
	end
	
	return fail(" - invalid waypoint", names)
end

local function validateTeam(text)
	local names = {}
	
	for _, team in robloxServices.Teams:GetTeams() do
		table.insert(names, team.Name)
	end
	
	if #names == 0 then
		return fail(" - there are no teams")
	end
	
	local match = findOption(names, text)
	
	if match then
		return { success = true, value = match, color = "valid" }
	end
	
	return fail(" - invalid team", names)
end

local function validateKeycode(text)
	local lowered = text:lower()
	local names = {}
	local found
	
	for _, item in Enum.KeyCode:GetEnumItems() do
		table.insert(names, item.Name)
		
		if item.Name:lower() == lowered then
			found = item
		end
	end
	
	if found then
		return { success = true, value = found, color = "valid" }
	end
	
	return fail(" - invalid key", names)
end

local function validateCommand(text)
	local command = commandsList.lookup[text:lower()]
	
	if command then
		return { success = true, value = command.name, color = "valid" }
	end
	
	return fail(" - invalid command", commandsList.array)
end

-- aliases and plugins are stored flat, keyed by name
local function validateStoredName(store, text, emptyMessage, invalidMessage)
	local names = keysOf(store:getData())
	
	if #names == 0 then
		return fail(emptyMessage)
	end
	
	local match = findOption(names, text)
	
	if match then
		return { success = true, value = match, color = "valid" }
	end
	
	return fail(invalidMessage, names)
end

local function validateAlias(text)
	return validateStoredName(aliasesData, text, " - no custom aliases", " - invalid alias")
end

local function validatePlugin(text)
	return validateStoredName(pluginsData, text, " - no plugins installed", " - invalid plugin")
end

local validators = {
	string    = validateString,
	text      = validateString,
	object    = validateFreeText,
	boolean   = validateBoolean,
	number    = validateNumber,
	vector3   = validateVector3,
	color3    = validateColor3,
	player    = validatePlayer,
	waypoint  = validateWaypoint,
	className = validateClassName,
	team      = validateTeam,
	keycode   = validateKeycode,
	command   = validateCommand,
	alias     = validateAlias,
	plugin    = validatePlugin,
}

function argsValidator:validate(arg, text)
	local validate = validators[arg.kind]
	
	if not validate then
		return fail(` - missing parser {arg.kind}`)
	end
	
	return validate(text, arg)
end

return argsValidator
