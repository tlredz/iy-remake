-- Run from the project root: lune run src/tests/plugins_test.luau
-- Loads the real modules with a mocked executor/Roblox boundary; never copies their implementation.
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local passed = 0
local function check(name, condition)
	assert(condition, `FAIL: {name}`)
	passed += 1
	print(`PASS: {name}`)
end
local function module(path, dependencies, globals)
	local environment = table.clone(globals or {})
	environment.require = function(name)
		assert(dependencies[name] ~= nil, `unmocked dependency: {name}`)
		return dependencies[name]
	end
	return luau.load(fs.readFile(`src/{path}.luau`), {
		debugName = path,
		environment = environment,
		injectGlobals = true,
	})()
end
local argsManager = module("commands/systems/argsManager", {})
local function args(values)
	local entries = {}
	for _, value in values do table.insert(entries, { value = value }) end
	return argsManager.new(entries)
end
local defaultConfig = module("framework/config/commands/plugins", {})
local function event()
	local callbacks = {}
	return {
		Connect = function(_, callback)
			local connection = { connected = true }
			function connection:Disconnect() self.connected = false end
			table.insert(callbacks, { connection = connection, callback = callback })
			return connection
		end,
		Fire = function(self, ...)
			if self.paused then return end
			for _, item in callbacks do
				if item.connection.connected then item.callback(...) end
			end
		end,
	}
end
local function setup(files, installed, config)
	local folder = "infiniteYield/plugins/"
	local state = { object = installed or {}, saves = 0 }
	function state:save() self.saves += 1 end
	local globals = {}
	local environments = {}
	local reads, probes, messages, executed = {}, {}, {}, {}
	local player = { Name = "Local" }
	local controller = {
		localPlayer = player,
		players = { LocalPlayer = player },
		playerService = { getMouse = function() return "mouse" end },
		notify = function(_, title, message) table.insert(messages, { title, message }) end,
	}
	local executor = {
		getfenv = getfenv, setfenv = setfenv,
		loadstring = function(source)
			local ok, chunk = pcall(luau.load, source, { environment = globals, injectGlobals = true })
			if ok then table.insert(environments, getfenv(chunk)); return chunk end
			return nil, chunk
		end,
		isfile = function(path)
			table.insert(probes, path)
			return files[path:sub(#folder + 1)] ~= nil
		end,
		readfile = function(path)
			table.insert(reads, path)
			local source = files[path:sub(#folder + 1)]
			if source == false then error("permission denied") end
			return source
		end,
		listfiles = function()
			local paths = {}
			for name in files do table.insert(paths, folder .. name) end
			return paths
		end,
	}
	local classic = module("commands/systems/classicPlugins", {
		["../../framework/environment/executor"] = executor,
		["./resolvePlayers"] = function(text) return { { Name = text == "me" and "Local" or text } } end,
	})
	classic.configure(controller, function(text) table.insert(executed, text); return true end)
	local plugins = module("commands/systems/plugins", {
		["../../framework/environment/executor"] = executor,
		["../../framework/config/storage"] = { privateFolder = "infiniteYield" },
		["../../storage/data/plugins"] = state,
		["../../framework/config/commands/plugins"] = config or table.clone(defaultConfig),
		["./classicPlugins"] = classic,
	})
	return {
		plugins = plugins, classic = classic, list = { lookup = {}, array = {}, original = {}, revision = 0, changed = event() }, state = state,
		executor = executor, globals = setmetatable({}, { __index = function(_, key)
			local environment = environments[#environments]
			return environment and environment[key]
		end }), reads = reads, probes = probes, files = files,
		controller = controller, messages = messages, executed = executed,
	}
end
local function native(name)
	return string.format('return {{action = "%s", run = function(self, args) return args:nextValue() end}}', name)
end

-- Explicit extensions take priority; missing files fall back in configured order.
for _, extension in defaultConfig.extensions do
	local t = setup({ [`demo{extension}`] = native("hello") })
	check(`loads {extension} without suffix`, t.plugins.add(t.list, "demo"))
	check(`persists actual {extension} filename`, t.state.object.demo == "demo" .. extension)
end
for _, requested in defaultConfig.extensions do
	for _, actual in defaultConfig.extensions do
		local t = setup({ [`demo{actual}`] = native("hello") })
		check(`request {requested}, actual {actual}`, t.plugins.add(t.list, "demo" .. requested))
		check(`saves fallback {requested} -> {actual}`, t.state.object.demo == "demo" .. actual)
	end
end
local t = setup({ ["demo.lua"] = native("lua"), ["demo.luau"] = native("luau") })
check("explicit extension wins", t.plugins.add(t.list, "demo.lua") and t.list.lookup.lua ~= nil and not t.list.lookup.luau)
check("cannot install same basename twice", not t.plugins.add(t.list, "demo.luau"))
check("reload keeps selected file", t.plugins.reload(t.list, "demo") and t.list.lookup.lua ~= nil)
check("reload accepts explicit file", t.plugins.reload(t.list, "demo.luau") and t.list.lookup.luau ~= nil and not t.list.lookup.lua)
check("remove accepts other supported suffix", t.plugins.remove(t.list, "demo.txt") and not t.list.lookup.luau and not t.state.object.demo)
local ordered = setup({ ["demo.lua"] = native("lua"), ["demo.txt"] = native("txt") }, nil,
	{ extensions = { ".txt", ".lua" }, translateClassic = true })
check("config controls search priority", ordered.plugins.add(ordered.list, "demo") and ordered.list.lookup.txt ~= nil)
local caps = setup({ ["demo.LUA"] = native("caps") })
check("discovered extension spelling preserved", caps.plugins.add(caps.list, "demo") and caps.state.object.demo == "demo.LUA")

local restore = setup({ ["demo.lua"] = native("saved"), ["demo.luau"] = native("other") }, { demo = "demo.lua" })
check("restore uses saved filename", next(restore.plugins.restore(restore.list)) == nil and restore.list.lookup.saved ~= nil)
restore = setup({ ["demo.txt"] = native("moved") }, { demo = "demo.luau" })
check("restore follows changed extension", next(restore.plugins.restore(restore.list)) == nil and restore.state.object.demo == "demo.txt" and restore.state.saves == 1)
restore = setup({}, { demo = "demo.iy" })
check("failed restore stays installed", restore.plugins.restore(restore.list).demo ~= nil and restore.state.object.demo == "demo.iy")
check("failed restore exposes error", restore.plugins.getInstalled()[1].error ~= nil)
restore = setup({ ["demo.lua"] = native("safe") }, { demo = "../../escape.lua" })
check("imported filename cannot escape folder", next(restore.plugins.restore(restore.list)) == nil and restore.state.object.demo == "demo.lua")
for _, path in restore.probes do check("all probes stay in plugin folder", path:sub(1, 22) == "infiniteYield/plugins/" and not path:find("..", 1, true)) end

local discover = setup({
	["z.lua"] = native("z"), ["z.txt"] = native("ignored"),
	["a.iy"] = native("a"), ["b.luau"] = native("b"), ["c.txt"] = native("c"),
	["x.json"] = native("x"), ["bad.name.lua"] = native("bad"),
})
check("discovery supports all extensions, sorts and deduplicates", table.concat(discover.plugins.getAvailable(), ",") == "a,b,c,z")
local all = discover.plugins.addAll(discover.list)
check("addAll installs each basename once", #all.added == 4 and #all.failed == 0)
check("addAll uses config priority", discover.state.object.z == "z.lua" and not discover.list.lookup.ignored)
check("available excludes installed", #discover.plugins.getAvailable() == 0)
check("addAll skips loaded", #discover.plugins.addAll(discover.list).added == 0)
local retry = setup({ ["bad.lua"] = "return {}", ["bad.txt"] = native("unused") }, { bad = "bad.lua" })
check("duplicate failed basename reported once", #retry.plugins.addAll(retry.list).failed == 1)
retry.files["bad.lua"] = native("fixed")
check("addAll retries installed failure", #retry.plugins.addAll(retry.list).added == 1)

local errors = setup({ ["demo.lua"] = "not valid luau !!!", ["demo.txt"] = native("fallback") })
check("syntax error does not fall back", not errors.plugins.add(errors.list, "demo.lua") and #errors.reads == 1 and not errors.list.lookup.fallback)
errors = setup({ ["demo.lua"] = false, ["demo.txt"] = native("fallback") })
check("read error does not fall back", not errors.plugins.add(errors.list, "demo.lua") and #errors.reads == 1)
errors = setup({})
for _, name in { "../escape.lua", "dir/demo.lua", "dir\\demo.lua", "bad.exe", "", ".lua" } do
	check(`rejects invalid name '{name}'`, not errors.plugins.add(errors.list, name))
end
check("invalid names never touch filesystem", #errors.probes == 0)
local ok, reason = errors.plugins.add(errors.list, "missing.iy")
check("missing error lists candidates", not ok and reason:find("missing.iy", 1, true) ~= nil and reason:find("missing.txt", 1, true) ~= nil)
errors.executor.listfiles = nil
check("discovery handles missing listfiles", errors.plugins.getAvailable() == nil)
errors.files["demo.lua"] = native("no_listing")
check("direct lookup works without listfiles", errors.plugins.add(errors.list, "demo"))

-- Real classic return shape from original.luau; callbacks and local helpers share the plugin environment.
local legacySource = [[
loads = (loads or 0) + 1
local function announce(args)
	notify("legacy", getstring(1, args))
end
return {
	PluginName = "Classic", PluginDescription = "Classic description",
	Commands = {
		greet = {
			ListName = "greet / hi [text]", Aliases = { "hi", "HI", "greet" }, Description = "Greeting",
			Function = function(args, speaker)
				announce(args)
				assert(speaker == Players.LocalPlayer and speaker == LocalPlayer)
				assert(IYMouse == "mouse")
				assert(getPlayer("me", speaker)[1] == speaker.Name)
				assert(getstring(1) == table.concat(args, " "))
				execCmd("other " .. table.concat(args, " "))
				return speaker.Name .. ": " .. table.concat(args, " ")
			end,
		},
	},
}
]]
local legacy = setup({ ["classic.iy"] = legacySource })
check("classic plugin loads", legacy.plugins.add(legacy.list, "classic"))
check("classic executes file only once", legacy.globals.loads == 1)
check("classic aliases translated and deduplicated", legacy.list.lookup.greet == legacy.list.lookup.hi and #legacy.list.array == 2)
local entry = legacy.list.lookup.greet
check("classic description and list label preserved", entry.description == "Greeting" and entry.classicListName == "greet / hi [text]")
check("classic arguments are optional and variadic", entry.args[1].optional and entry.args[1].variadic)
check("classic callback keeps args and speaker", entry.run(legacy.controller, args({ "hello", "quoted world", "42" })) == "Local: hello quoted world 42")
check("classic notify works in local helper", legacy.messages[1][1] == "legacy" and legacy.messages[1][2] == "hello quoted world 42")
check("classic string return notifies", legacy.messages[2][2] == "Local: hello quoted world 42")
check("classic execCmd uses current runner", legacy.executed[1] == "other hello quoted world 42")
check("classic helpers do not leak globally", legacy.globals.notify == nil and legacy.globals.cargs == nil)
entry.run(legacy.controller, args({ "nonotify" }))
check("classic nonotify suppresses return notification", #legacy.messages == 3)
check("classic accepts no arguments", entry.run(legacy.controller, args({})) == "Local: ")
check("classic reload works", legacy.plugins.reload(legacy.list, "classic.iy"))
check("classic removal removes aliases", legacy.plugins.remove(legacy.list, "classic") and not legacy.list.lookup.hi and #legacy.list.array == 0)

local nativeSource = [[
loads = (loads or 0) + 1
return {
	action = "modern", Commands = { fake = { Function = function() error("wrong translation") end } },
	PluginName = "unrelated metadata", run = function(self, args) return args:nextValue() end,
}
]]
local modern = setup({ ["modern.lua"] = nativeSource })
check("native single command with legacy metadata unchanged", modern.plugins.add(modern.list, "modern") and modern.list.lookup.modern ~= nil and not modern.list.lookup.fake)
check("native callback keeps current calling convention", modern.list.lookup.modern.run(modern.controller, args({ "value" })) == "value")
check("native source runs once", modern.globals.loads == 1)
local mixed = setup({ ["modern.lua"] = [[return { {action = "native"}, Commands = { fake = {Function = function() end} } }]] })
-- Native lists may carry metadata. Verify detection alone, since the existing native loader rejects non-command entries.
check("native list never detected as classic", not mixed.classic.detect({ { action = "native" }, Commands = { fake = { Function = function() end } } }))
check("unrelated Commands field is not classic", not mixed.classic.detect({ Commands = { text = "metadata" } }))
check("classic detected by command shape without metadata", mixed.classic.detect({ Commands = { cmd = { Function = function() end } } }))
local disabled = setup({ ["classic.iy"] = legacySource }, nil, { extensions = defaultConfig.extensions, translateClassic = false })
check("translation can be disabled", not disabled.plugins.add(disabled.list, "classic"))
local malformed = setup({ ["bad.iy"] = [[return {PluginName = "Bad", Commands = { first = {Function = function() end}, second = {Aliases = {}, Function = false} }}]] })
check("malformed classic registers nothing", not malformed.plugins.add(malformed.list, "bad") and #malformed.list.array == 0 and not malformed.state.object.bad)
malformed.files["bad.iy"] = [[return {PluginName="Bad", Commands={cmd={Aliases={"bad|alias"},Function=function() end}}}]]
check("malformed aliases rejected", not malformed.plugins.add(malformed.list, "bad"))
local conflict = setup({ ["classic.iy"] = legacySource })
local builtin = { name = "hi" }
conflict.list.lookup.hi = builtin
check("classic cannot replace built-in alias", not conflict.plugins.add(conflict.list, "classic") and conflict.list.lookup.hi == builtin and not conflict.list.lookup.greet)

-- Exercise the real parser and validator, including quoted tokens and fixed native argument limits.
local list = { lookup = { old = entry, fixed = { name = "fixed", aliases = { "fixed" }, args = { { kind = "string" } } } }, array = { "old", "fixed" } }
local tools = {
	colorFromRGB = function(text) return text end,
	escapeRichText = function(text) return text end,
	lookupify = function(values)
		local lookup = {}; for _, value in values do lookup[value] = true end; return lookup
	end,
	unlookupify = function(values)
		local keys = {}; for key in values do table.insert(keys, key) end; return keys
	end,
}
local store = { getData = function() return {} end }
local pluginStore = { getData = function() return { demo = "demo.lua" } end }
local validator = module("commands/systems/argsValidator", {
	["../../framework/services/rbxServices"] = {}, ["./resolvePlayers"] = {}, ["../list"] = list,
	["../../storage/data/waypoints"] = store, ["../../storage/data/aliases"] = store,
	["../../storage/data/plugins"] = pluginStore, ["./plugins"] = modern.plugins, ["../../utils/tools"] = tools,
})
check("plugin validator accepts suffix", validator:validate({kind = "plugin"}, "demo.iy").value == "demo")
local parser = module("commands/systems/commandParser", {
	["../controllers/commandsController"] = { getBestMatches = function() return {} end },
	["../controllers/searchController"] = { searchAtArray = function() return {} end },
	["../list"] = list, ["../../framework/config/ui/colors"] = { args = {} },
	["../../utils/tools"] = tools, ["./argsValidator"] = validator,
})
local function parse(text)
	local input = {}
	local p = parser.new(input, function() end)
	p:highlight(p:parse(text))
	return input
end
local input = parse([[old one "two words" 3]])
check("classic parser accepts multiple arguments", input.runError == nil and #input.statements[1].args == 3)
check("classic parser preserves quoted argument", input.statements[1].args[2].value == "two words")
check("classic parser accepts zero arguments", parse("old").runError == nil)
check("classic parser handles trailing space", parse("old one two ").runError == nil)
check("native parser still rejects extra arguments", parse("fixed one two").runError ~= nil)
check("native parser still requires argument", parse("fixed").runError ~= nil)
check("variadic parsing does not mutate definition", #entry.args == 1)

-- Regression: a plugin installed while the command bar is awake must get a row and run through Enter.
-- Real list, loader, parser, runner, UI methods and FocusLost/Text events; only Roblox objects are simulated.
local live = setup({
	["echo.lua"] = [[return {{action = "echo|e", description = "Echo", args = {kind = "string", optional = true},
		run = function(self, args) self.runs = (self.runs or 0) + 1; self.lastValue = args:nextValue() or "empty" end}}]],
	["classic.iy"] = [[return {PluginName = "Classic", Commands = {classicrun = {Aliases = {"cr"},
		Function = function(args, speaker) notify("classic ran", speaker.Name .. ":" .. table.concat(args, ",")) end}}}]],
})
local logger = { expect = function() end, assert = assert, error = function(message) error(message) end }
local signalFactory = { new = event }
local listDeps = { ["../utils/logger"] = logger, ["../utils/signal"] = signalFactory }
for _, name in { "general", "interface", "character", "waypoints", "teleport", "communication", "visual", "camera", "workspace", "lighting", "aliases" } do
	listDeps["./cmds/" .. name] = {}
end
listDeps["./cmds/plugins"] = module("commands/cmds/plugins/init", { ["../../systems/plugins"] = live.plugins })
live.list = module("commands/list", listDeps)
live.controller.commandsList = live.list
function live.controller:search() return {} end
function live.controller:getLastArgs() return nil end
function live.controller:run(name, arguments)
	local command = assert(live.list.lookup[name], "unknown command")
	return command.run(self, arguments)
end
local liveValidator = module("commands/systems/argsValidator", {
	["../../framework/services/rbxServices"] = {}, ["./resolvePlayers"] = {}, ["../list"] = live.list,
	["../../storage/data/waypoints"] = store, ["../../storage/data/aliases"] = store,
	["../../storage/data/plugins"] = { getData = function() return live.state.object end },
	["./plugins"] = live.plugins, ["../../utils/tools"] = tools,
})
local liveParser = module("commands/systems/commandParser", {
	["../controllers/commandsController"] = live.controller,
	["../controllers/searchController"] = { searchAtArray = function() return {} end },
	["../list"] = live.list, ["../../framework/config/ui/colors"] = { args = {} },
	["../../utils/tools"] = tools, ["./argsValidator"] = liveValidator,
})
local liveRunner = module("commands/systems/commandRunner", {
	["../controllers/commandsController"] = live.controller, ["./commandParser"] = liveParser,
	["./argsManager"] = argsManager, ["../services/loopService"] = {}, ["../../utils/logger"] = logger,
})
local connections = module("framework/services/connectionService", { ["../environment/private"] = {} })
local function dimension(xScale, xOffset, yScale, yOffset)
	return { X = { Scale = xScale, Offset = xOffset }, Y = { Scale = yScale, Offset = yOffset } }
end
local udim2 = {
	new = dimension,
	fromOffset = function(x, y) return dimension(0, x, 0, y) end,
	fromScale = function(x, y) return dimension(x, 0, y, 0) end,
}
local inputService = { InputBegan = event() }
local runService = { Stepped = event(), Heartbeat = { Wait = function() end } }
local ui = module("ui/components/commands", {
	["../../framework/services/connectionService"] = connections,
	["../../framework/services/rbxServices"] = { UserInputService = inputService, RunService = runService, TweenService = {} },
	["../../framework/services/playerService"] = {}, ["../services/createService"] = {},
	["../../commands/systems/commandData"] = module("commands/systems/commandData", {}),
	["../../commands/systems/commandParser"] = liveParser, ["../../commands/systems/commandRunner"] = liveRunner,
	["../utils/inputUtils"] = {}, ["../services/assetsService"] = {}, ["../../commands/list"] = live.list,
	["../../utils/signal"] = signalFactory, ["../../utils/logger"] = logger, ["../../utils/tools"] = tools,
	["../utils/scaleObject"] = { getScale = function() return 1 end },
	["../../storage/data/settings"] = { getValue = function() return false end },
	["../../framework/config/ui/colors"] = { commands = {} }, ["../../framework/environment/isMobile"] = false,
}, {
	UDim2 = udim2, Vector2 = { new = function(x, y) return { X = x, Y = y } end },
	task = { spawn = function(callback, ...) callback(...) end, delay = function(_, callback) callback() end },
	Enum = { KeyCode = { Up = "Up", Down = "Down", Tab = "Tab" } },
})
local scroll = { index = 0, totalSpace = 0 }
function scroll:setTotalSpace(total) self.totalSpace = total end
function scroll:scrollTo(position) assert(type(position) == "number"); self.index = position end
function scroll:isVisible() return true end
local view = ui.new({ scrollBar = scroll, configs = { placeholderText = ">", padding = 0, labelSize = 17, textSize = 14 } })
local textChanged = event()
local box = { Text = "", Focused = event(), FocusLost = event(), focused = true }
function box:IsFocused() return self.focused end
function box:GetPropertyChangedSignal() return textChanged end
function box:CaptureFocus() self.focused = true; self.Focused:Fire() end
function box:ReleaseFocus() self.focused = false; self.FocusLost:Fire(false) end
view.searchBox = box
view.searchBoxHolder = {
	Placeholder = {}, Activated = event(), AbsoluteSize = { X = 200 },
	Input = { AbsoluteSize = { X = 50 } },
}
view.inputMarker = {}
view.inputComment = { Text = "" }
view.sendButton = { Activated = event() }
view.commandsFolder = {}
view.isEnabled = true
function view:tweenSearchBar() end
local destroyed = 0
function view:createCommandElement()
	return { Size = dimension(1, 0, 0, 17), Command = {}, Destroy = function() destroyed += 1 end }
end
view:createCommandsData()
view:awake()
local originalRows = #view.commandsData
local builtin = live.list.lookup.addplugin
local builtinData = builtin.commandData
local function pressEnter(text)
	box.Text = text
	box.focused = false
	box.FocusLost:Fire(true)
end
pressEnter("addplugin echo.lua")
check("Enter installs plugin with UI already awake", live.list.lookup.echo ~= nil and live.state.object.echo == "echo.lua")
check("plugin row created as soon as added", live.list.lookup.echo.commandData ~= nil)
check("plugin section sits below plugin management commands", live.list.original[originalRows + 1].isPluginSection and live.list.original[originalRows + 1].sectionName == "plugin commands")
check("aliases share one visual row", #view.commandsData == originalRows + 2 and live.list.lookup.e.commandData == live.list.lookup.echo.commandData)
check("existing built-in rows reused", builtin.commandData == builtinData)
check("scrollbar includes section and command", scroll.totalSpace == originalRows + 2)
pressEnter('echo "hello world"')
check("Enter runs native plugin command", live.controller.runs == 1 and live.controller.lastValue == "hello world")
check("search scrolls to plugin position", scroll.index == live.list.lookup.echo.commandData.position)
pressEnter("e alias")
check("Enter runs native plugin alias", live.controller.runs == 2 and live.controller.lastValue == "alias")
box.focused = true
box.Text = "e newline\n"
textChanged:Fire()
check("multiline Enter event runs plugin once", live.controller.runs == 3 and live.controller.lastValue == "newline")
check("multiline Enter strips newline from command bar", box.Text == "e newline" and not box:IsFocused())
view.commandClickedSignal:Fire(live.list.lookup.echo.commandData)
check("plugin row click fills command bar", box.Text == "e")

-- A delayed change notification must not leave the synchronous Enter/refresh path with missing commandData.
live.list.changed.paused = true
check("classic installs before deferred UI notification", live.plugins.add(live.list, "classic.iy"))
check("fixture reproduces command without commandData", live.list.lookup.classicrun.commandData == nil)
pressEnter('cr first "two words"')
check("Enter synchronizes rows before searching", live.list.lookup.classicrun.commandData ~= nil)
check("Enter runs classic callback with multiple arguments", live.messages[#live.messages][2] == "Local:first,two words")
live.list.changed.paused = false
local old = live.list.lookup.echo
old.commandData.element = old.commandData.element or view:createCommandElement()
local beforeDestroy = destroyed
live.files["echo.lua"] = [[return {{action = "renamed|rn", description = "Reloaded", run = function(self) self.reloaded = true end}}]]
pressEnter("reloadplugin echo.lua")
check("reload removes old lookup and visual data", live.list.lookup.echo == nil and old.commandData == nil)
check("reload destroys removed visual element", destroyed > beforeDestroy)
check("reload creates new visual row", live.list.lookup.renamed.commandData ~= nil and #view.commandsData == originalRows + 3)
pressEnter("rn")
check("Enter runs reloaded command", live.controller.reloaded == true)
pressEnter("removeplugin echo.txt")
check("remove clears renamed command and alias", live.list.lookup.renamed == nil and live.list.lookup.rn == nil)
check("remove preserves other plugin rows", live.list.lookup.cr.commandData ~= nil and #view.commandsData == originalRows + 2)
pressEnter("removeplugin classic.iy")
check("last plugin removal clears section and rows", #view.commandsData == originalRows and #live.list.original == originalRows)
check("positions remain contiguous", builtin.commandData.position == table.find(live.list.original, builtin) - 1)
check("rebuilding rows is idempotent", not view:syncCommandsData() and #view.commandsData == originalRows)
local beforeConflict = live.list.revision
live.files["conflict.lua"] = [[return {{action = "newname"}, {action = "addplugin"}}]]
check("failed installation leaves no partial visual rows", not live.plugins.add(live.list, "conflict")
	and #view.commandsData == originalRows and not live.list.lookup.newname and live.list.revision == beforeConflict)
-- A stale external alias/command with no display row must never break typing or Enter.
live.list.lookup.external = { name = "external", aliases = { "external" }, args = {}, run = function(self) self.external = true end }
pressEnter("external")
check("missing display metadata does not block Enter", live.controller.external == true)
print(`\n{passed} checks passed`)
