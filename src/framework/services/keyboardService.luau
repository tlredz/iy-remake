-- src/framework/services/keyboardService.luau
-- Manages the keyboard. Features use it in two ways:
--   onKeysPressed / onBindingPressed  run a function when a key is pressed
--   capture                           waits for the next key press (how Settings picks a key)
--
-- A binding is a named key the player can change (framework/config/services/keybinds). The key they picked is saved
-- in storage/data/settings, so it is still there after a restart. Listeners read the binding at each press,
-- so a new key applies at once.

local robloxServices = require("./rbxServices")
local connectionService = require("./connectionService")
local settingsData = require("../../storage/data/settings")
local keybindsConfig = require("../config/services/keybinds")
local keysToText = require("../config/utils/keysToText")

local userInputService = robloxServices.UserInputService

local keyboardService = {}

local listeners = {}
local capturing = nil
local isConnected = false

local function keyCodeFromName(name: any): EnumItem?
	if type(name) ~= "string" then return nil end
	
	local ok, keyCode = pcall(function()
		return Enum.KeyCode[name]
	end)
	
	return if ok then keyCode else nil
end

local function bindingConfig(name: string)
	local config = keybindsConfig.bindings[name]
	assert(config, `keyboardService: there is no binding named '{name}'`)
	return config
end

-- the key the binding is set to, or its default until the player picks one
local function bindingKey(name: string): EnumItem
	local config = bindingConfig(name)
	
	return keyCodeFromName(settingsData:getValue(config.settingKey))
		or keyCodeFromName(config.default)
		or Enum.KeyCode.Unknown
end

-- every key a binding responds to: the one it is set to, and its fixed keys
local function bindingKeys(name: string): { EnumItem }
	local config = bindingConfig(name)
	local keys = { bindingKey(name) }

	for _, fixedName in config.also or {} do
		local fixed = keyCodeFromName(fixedName)
		if fixed then
			table.insert(keys, fixed)
		end
	end

	return keys
end

local function onInputBegan(input: InputObject, processed: boolean)
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

	local keyCode = input.KeyCode
	if keyCode == Enum.KeyCode.Unknown then return end

	-- a capture takes the key first, so the key does not also run what it is bound to
	if capturing then
		local request = capturing
		capturing = nil

		if keyCode == Enum.KeyCode.Escape then
			if request.onCancel then
				request.onCancel()
			end
		else
			request.onKey(keyCode)
		end

		return
	end

	-- a key typed into a text box, or used by the game, is not a press for IY
	if processed then return end

	for _, listener in table.clone(listeners) do
		if listener.connected and table.find(listener.getKeys(), keyCode) then
			listener.callback(input)
		end
	end
end

local function ensureConnected()
	if isConnected then return end

	isConnected = true
	connectionService:Connect(userInputService.InputBegan, onInputBegan)
end

local function addListener(getKeys: () -> { EnumItem }, callback: (InputObject) -> ())
	ensureConnected()

	local listener = {
		getKeys = getKeys,
		callback = callback,
		connected = true,
	}

	table.insert(listeners, listener)

	local connection = {}

	function connection:Disconnect()
		listener.connected = false

		local index = table.find(listeners, listener)
		if index then
			table.remove(listeners, index)
		end
	end

	return connection
end

-- runs callback(input) each time one of the keys is pressed. Disconnect() on the result stops it
function keyboardService:onKeysPressed(keys: { EnumItem }, callback: (InputObject) -> ())
	return addListener(function()
		return keys
	end, callback)
end

-- runs callback(input) each time the key of the binding (or one of its fixed keys) is pressed
function keyboardService:onBindingPressed(name: string, callback: (InputObject) -> ())
	bindingConfig(name)

	return addListener(function()
		return bindingKeys(name)
	end, callback)
end

-- waits for the next key press: onKey(keyCode) gets the key, and Escape calls onCancel instead.
-- Returns a function that stops waiting. Starting a new capture replaces the one still waiting
function keyboardService:capture(onKey: (EnumItem) -> (), onCancel: (() -> ())?): () -> ()
	ensureConnected()

	local request = { onKey = onKey, onCancel = onCancel }
	capturing = request

	return function()
		if capturing == request then
			capturing = nil
		end
	end
end

function keyboardService:getBinding(name: string): EnumItem
	return bindingKey(name)
end

function keyboardService:setBinding(name: string, keyCode: EnumItem)
	local config = bindingConfig(name)
	assert(typeof(keyCode) == "EnumItem" and keyCode.EnumType == Enum.KeyCode, "keyboardService: setBinding needs a KeyCode")

	settingsData:setValue(config.settingKey, keyCode.Name)
	settingsData:save()
end

-- puts the binding back to its default key
function keyboardService:resetBinding(name: string)
	local config = bindingConfig(name)

	settingsData:setValue(config.settingKey, nil)
	settingsData:save()
end

function keyboardService:getKeyName(keyCode: EnumItem): string
	-- print(keyCode, keysToText[keyCode] or keyCode.Name)
	return keysToText[keyCode] or keyCode.Name
	-- local ok, character = pcall(function()
	-- 	return userInputService:GetStringForKeyCode(keyCode)
	-- end)
	
	-- if ok and type(character) == "string" and character:match("%S") then
	-- 	return character:upper()
	-- end
	
	-- return (keyCode.Name:gsub("(%l)(%u)", "%1 %2"))
end

function keyboardService:getBindingName(name: string): string
	return self:getKeyName(bindingKey(name))
end

return keyboardService
