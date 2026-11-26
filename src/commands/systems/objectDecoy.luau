-- /src/commands/systems/objectDecoy.luau

-- Client bypass. A protected object stays where it is, but the game reads a decoy instead: an instance of a
-- random class (Folder, MeshPart, Decal or Attachment), so ClassName, Name and the decoy's properties look like
-- the decoy. A property the decoy class does not have is read from the real object, so the game gets a value
-- instead of an error.
-- setProperty spoofs a property: the real value changes, and the game keeps reading the value it had before.
-- getProperty always reads the real value.
--
-- The hooks are installed the first time the bypass is turned on, and only then. The test picks the method that
-- installs them: hookmetamethod if it works, getrawmetatable otherwise. The state lives in privateEnv, so loading
-- this file again does not hook game's metamethods again.

local executorEnv = require("../../framework/environment/executor")
local privateEnv = require("../../framework/environment/private")

local DECOY_CLASSES = { "Folder", "MeshPart", "Decal", "Attachment" }

local objectDecoy = {}

local state = privateEnv.objectDecoy
if state == nil then
	state = {
		enabled = false,
		method = nil,
		hooked = false,
		originals = {},
		protectedObjects = setmetatable({}, { __mode = "k" }),
		spoofedFlags = setmetatable({}, { __mode = "k" }),
		spoofedValues = setmetatable({}, { __mode = "k" }),
	}
	privateEnv.objectDecoy = state
end

local function isSpoofed(object: Instance, property: string): boolean
	local flags = state.spoofedFlags[object]
	return flags ~= nil and flags[property] == true
end

local function createDecoy(): Instance
	return Instance.new(DECOY_CLASSES[math.random(#DECOY_CLASSES)])
end

-- Reads and writes that skip the hooks, so they reach the real object
local function readReal(object: Instance, property: string): any
	if state.hooked then
		return state.originals.index(object, property)
	end
	return object[property]
end

local function writeReal(object: Instance, property: string, value: any)
	if state.hooked then
		state.originals.newindex(object, property, value)
		return
	end
	object[property] = value
end

local function newIndexHook(self, index, value)
	if state.enabled then
		if isSpoofed(self, index) then
			state.spoofedValues[self][index] = value
			return
		end

		-- Parent is structure, not appearance: it always goes to the real object, so Parent = nil really removes it
		local record = state.protectedObjects[self]
		if record and index ~= "Parent" and pcall(state.originals.newindex, record.decoy, index, value) then
			return
		end
	end

	return state.originals.newindex(self, index, value)
end

local function indexHook(self, index)
	if state.enabled then
		if isSpoofed(self, index) then
			return state.spoofedValues[self][index]
		end

		local record = state.protectedObjects[self]
		if record then
			local ok, value = pcall(state.originals.index, record.decoy, index)
			if ok then
				return value
			end
		end
	end

	return state.originals.index(self, index)
end

-- Replaces a metamethod of game with fn, using the given method, and returns the original one
local function replaceMetamethod(method: string, name: string, fn: any): any
	if method == "getrawmetatable" then
		local mt = executorEnv.getrawmetatable(game)
		local original = mt[name]
		executorEnv.setreadonly(mt, false)
		mt[name] = fn
		executorEnv.setreadonly(mt, true)
		return original
	end

	return executorEnv.hookmetamethod(game, name, fn)
end

local function ensureHooks()
	if state.originals.newindex == nil then
		state.originals.newindex = replaceMetamethod(state.method, "__newindex", newIndexHook)
	end
	if state.originals.index == nil then
		state.originals.index = replaceMetamethod(state.method, "__index", indexHook)
	end
	state.hooked = true
end

-- Newer check: hooks __newindex and __index with a fresh instance. Not in use yet.
-- To use it, comment out probeMethod below and uncomment this block.
--[[
local PROBE_VALUE = "iy test"

-- Hooks game's __newindex, writes Name on a fresh instance and checks that the hook got that write.
-- A fresh instance is written, not game, so if the hook does not work nothing of the game changes.
-- The original is put back in every case, and other writes still reach it.
local function probeNewIndex(method: string): boolean
	local target = Instance.new("Folder")
	local success = false
	local original
	local replaced = false

	local ok = pcall(function()
		original = replaceMetamethod(method, "__newindex", function(self, index, value)
			if self == target and index == "Name" and value == PROBE_VALUE then
				success = true
				return
			end
			return original(self, index, value)
		end)
		replaced = true

		target.Name = PROBE_VALUE
	end)

	if replaced then
		pcall(replaceMetamethod, method, "__newindex", original)
	end

	return ok and success
end

-- Hooks game's __index, reads Name on a fresh instance and checks that the hook got that read.
-- The original is put back in every case.
local function probeIndex(method: string): boolean
	local target = Instance.new("Folder")
	local seen = false
	local original
	local replaced = false

	local ok, result = pcall(function()
		original = replaceMetamethod(method, "__index", function(self, index)
			if self == target and index == "Name" then
				seen = true
			end
			return original(self, index)
		end)
		replaced = true

		local _ = target.Name
		return seen
	end)

	if replaced then
		pcall(replaceMetamethod, method, "__index", original)
	end

	return ok and result == true
end

-- A method only counts when both metamethods the module hooks really run through it
local function probeMethod(method: string): boolean
	return probeNewIndex(method) and probeIndex(method)
end

]]

-- Swaps game's __index for a probe, reads a property of a fresh instance and checks that the probe ran.
-- The original is put back in every case.
local function probeMethod(method: string): boolean
	local target = Instance.new("Folder")
	local seen = false
	local original
	local replaced = false

	local ok, result = pcall(function()
		original = replaceMetamethod(method, "__index", function(self, index)
			if self == target then
				seen = true
			end
			return original(self, index)
		end)
		replaced = true

		local _ = target.Name
		return seen
	end)

	if replaced then
		pcall(replaceMetamethod, method, "__index", original)
	end

	return ok and result == true
end

local function probeHookmetamethod(): boolean
	if typeof(executorEnv.hookmetamethod) ~= "function" then
		return false
	end
	return probeMethod("hookmetamethod")
end

local function probeGetrawmetatable(): boolean
	if typeof(executorEnv.getrawmetatable) ~= "function" or typeof(executorEnv.setreadonly) ~= "function" then
		return false
	end
	return probeMethod("getrawmetatable")
end

-- Tests hookmetamethod first, and getrawmetatable only if hookmetamethod does not work.
-- Returns the method that works (nil when neither does) and the result of each test that ran.
function objectDecoy.test(): (string?, { [string]: boolean })
	local results = {}

	results.hookmetamethod = probeHookmetamethod()
	if results.hookmetamethod then
		return "hookmetamethod", results
	end

	results.getrawmetatable = probeGetrawmetatable()
	if results.getrawmetatable then
		return "getrawmetatable", results
	end

	return nil, results
end

-- The test command: says which method works, without turning the bypass on.
function objectDecoy.runTest(cmd)
	local method, results = objectDecoy.test()

	local lines = {}
	for _, name in { "hookmetamethod", "getrawmetatable" } do
		if results[name] ~= nil then
			local word = if results[name] then "works" else "does not work"
			table.insert(lines, `{name} {word}`)
		end
	end
	local report = table.concat(lines, ", ")

	if method == nil then
		cmd:notify("Client bypass test", `{report}. Neither works, so the client bypass cannot be turned on here.`)
	else
		cmd:notify("Client bypass test", `{report}. Using {method}.`)
	end
end

function objectDecoy.enable(cmd)
	if state.enabled then
		cmd:notify("Client bypass", "already on")
		return true
	end

	local method = state.method or objectDecoy.test()
	if method == nil then
		cmd:notify("Client bypass", "could not turn on: neither hookmetamethod nor getrawmetatable works in this executor")
		return false
	end

	state.method = method
	local ok, err = pcall(ensureHooks)
	if not ok then
		cmd:notify("Client bypass", `could not turn on: {err}`)
		return false
	end

	state.enabled = true
	cmd:notify("Client bypass", `on, using {method}`)
	return true
end

function objectDecoy.disable(cmd)
	if not state.enabled then
		cmd:notify("Client bypass", "already off")
		return false
	end

	state.enabled = false
	cmd:notify("Client bypass", "off: hidden objects show their real values again")
	return true
end

function objectDecoy.isEnabled(): boolean
	return state.enabled
end

-- Hides the object from the game and leaves it where it is, so it keeps working.
-- Does nothing while the bypass is off, so commands can call it without checking.
function objectDecoy.protect(object: Instance): Instance
	assert(typeof(object) == "Instance", "objectDecoy.protect: expected an Instance")

	if state.enabled and state.protectedObjects[object] == nil then
		state.protectedObjects[object] = { decoy = createDecoy() }
	end

	return object
end

function objectDecoy.isProtected(object: Instance): boolean
	return state.protectedObjects[object] ~= nil
end

-- Creates an instance with these properties and protects it. Parent is set last, so the object is only
-- in the world once the rest of its properties are set.
function objectDecoy.createProtected(className: string, properties: { [string]: any }?): Instance
	local object = Instance.new(className)
	local parent = nil

	for property, value in properties or {} do
		if property == "Parent" then
			parent = value
		else
			object[property] = value
		end
	end

	-- protected before it is parented, so listeners on the parent (like DescendantAdded) read the decoy class
	objectDecoy.protect(object)
	object.Parent = parent
	return object
end

-- Destroys the real object, protected or not. Calls the real method, so it does not depend on how the
-- method is looked up through the hooks.
function objectDecoy.destroy(object: Instance)
	local destroy = readReal(object, "Destroy")
	destroy(object)
end

-- The real value of a property, even when the object is protected or the property is spoofed.
function objectDecoy.getProperty(object: Instance, property: string): any
	return readReal(object, property)
end

-- Changes the real value. While the bypass is on, the game keeps reading the value it had before.
function objectDecoy.setProperty(object: Instance, property: string, value: any)
	if not state.enabled then
		writeReal(object, property, value)
		return
	end

	local flags = state.spoofedFlags[object]
	if flags == nil then
		flags = {}
		state.spoofedFlags[object] = flags
		state.spoofedValues[object] = {}
	end

	if not flags[property] then
		flags[property] = true
		state.spoofedValues[object][property] = readReal(object, property)
	end

	writeReal(object, property, value)
end

return objectDecoy
