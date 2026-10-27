-- Run from the project root: lune run src/tests/reference_test.luau
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local passed = 0
local function check(name, value)
    assert(value, "FAIL: " .. name)
    passed += 1
end
local function module(path, deps, globals)
    local environment = table.clone(globals or {})
    environment.require = function(name)
        assert(deps[name] ~= nil, "unmocked dependency: " .. name)
        return deps[name]
    end
    return luau.load(fs.readFile("src/" .. path .. ".luau"), {
        environment = environment, injectGlobals = true, debugName = path,
    })()
end
local function event()
    local callbacks = {}
    return {
        Connect = function(_, callback)
            table.insert(callbacks, callback)
            return { Disconnect = function() end }
        end,
        Fire = function(_, ...)
            for _, callback in callbacks do callback(...) end
        end,
    }
end
local tools = module("utils/tools", {})
local color3 = { fromRGB = function(r, g, b)
    return { ToHex = function() return string.format("%02x%02x%02x", r, g, b) end }
end }
local colors = module("framework/config/ui/colors", {}, { Color3 = color3 })
local syntax = module("framework/config/utils/luaConvertions", { ["../../../utils/tools"] = tools })
local highlight = module("utils/luahighlight", {
    ["../framework/config/utils/luaConvertions"] = syntax,
    ["../framework/config/ui/colors"] = colors, ["./tools"] = tools,
})
local function plain(text)
    text = text:gsub("<[^>]+>", "")
    return (text:gsub("&quot;", '"'):gsub("&apos;", "'"):gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&amp;", "&"))
end
for _, source in {
    "", "local value: number = 3.5", "return true, false, nil", "-- return 42\nreturn 1",
    '--[=[ <font> "comment" ]=]\nreturn 0xFF',
    [=[local text = "<b> & \\\"quoted\\\" </b>"]=],
    "return [==[<tag> & string]==]", "-- unterminated comment", '"unterminated string',
    "return 0b1010, 1e-3, .25, 1_000", "return `value {42}`", "local café = 'olá'",
} do
    check("highlight preserves source: " .. source, plain(highlight:apply(source)) == source)
end
check("keywords highlighted", highlight:apply("return") == tools.colorFromRGB("return", colors.args.others))
check("type names highlighted", highlight:apply("string") == tools.colorFromRGB("string", colors.args.others))
check("numbers highlighted", highlight:apply("42") == tools.colorFromRGB("42", colors.args.number))
check("quoted tokens keep string color", highlight:apply('"return 42"') == tools.colorFromRGB('&quot;return 42&quot;', colors.args.string))
check("comments keep comment color", highlight:apply("-- return 42") == tools.colorFromRGB("-- return 42", colors.args.comment))
check("rich text injection escaped", not highlight:apply('"<b>unsafe</b>"'):find("<b>", 1, true))
check("instance highlighter works", highlight.new():apply("true") == highlight:apply("true"))

-- names are colored by what stands around them (function names, fields, table keys, interpolated code)
local function paint(text, color) return tools.colorFromRGB(text, color) end
check("a called name is a function", highlight:apply("print(x)") == paint("print", colors.args.func) .. paint("(", colors.args.symbol) .. "x" .. paint(")", colors.args.symbol))
check("a name after a dot is a field", highlight:apply("self.players") == paint("self", colors.args.others) .. paint(".", colors.args.symbol) .. paint("players", colors.args.field))
check("a method call colors the method as a function", highlight:apply("self:notify(1)") == paint("self", colors.args.others) .. paint(":", colors.args.symbol) .. paint("notify", colors.args.func) .. paint("(", colors.args.symbol) .. paint("1", colors.args.number) .. paint(")", colors.args.symbol))
check("the name of a local function is a function", highlight:apply("local function run()") == paint("local", colors.args.others) .. " " .. paint("function", colors.args.others) .. " " .. paint("run", colors.args.func) .. paint("()", colors.args.symbol))
check("a table key is a field", highlight:apply("{ kind = 1 }") == paint("{", colors.args.symbol) .. " " .. paint("kind", colors.args.field) .. " " .. paint("=", colors.args.symbol) .. " " .. paint("1", colors.args.number) .. " " .. paint("}", colors.args.symbol))
check("a variable is plain text", highlight:apply("x == y") == "x " .. paint("==", colors.args.symbol) .. " y")
check("a dot before a name is a field, a type after ':' is plain", highlight:apply("x: Foo") == "x" .. paint(":", colors.args.symbol) .. " Foo")
check("interpolated code is colored, the text stays a string", highlight:apply("`a {b}`") == paint("`a ", colors.args.string) .. paint("{", colors.args.symbol) .. "b" .. paint("}", colors.args.symbol) .. paint("`", colors.args.string))
check("a double dot is one symbol and digits after it are not a number", highlight:apply("a..5") == "a" .. paint("..", colors.args.symbol) .. paint("5", colors.args.number))
local storageConfig = module("framework/config/storage", {})
local pluginConfig = module("framework/config/commands/plugins", {})
local pluginSections = module("framework/config/ui/pluginReference", {
    ["../../../utils/luahighlight"] = highlight, ["../storage"] = storageConfig, ["../commands/plugins"] = pluginConfig,
})
local textHighlight = module("utils/textHighlight", { ["../framework/config/ui/colors"] = colors, ["./tools"] = tools })
local config = module("framework/config/ui/reference", {
    ["../../../utils/tools"] = tools, ["./colors"] = colors,
    ["../../../utils/textHighlight"] = textHighlight, ["./pluginReference"] = pluginSections,
})
check("exactly two reference pages", #config.pages == 2)
check("Types is the default existing page", config.pages[1].id == "types" and config.pages[1].sections == config.sections)
check("Plugins is the second page, and it is paged", config.pages[2].id == "plugins" and config.pages[2].sections == pluginSections and config.pages[2].paged == true)
check("Types is not paged", config.pages[1].paged == nil)
local EXAMPLE_PATHS = {
    "plugins/examples/greeting.luau", "plugins/examples/walkspeed.luau", "plugins/examples/message.luau",
    "plugins/examples/players.luau",
}
local filePaths = {}
local firstFile
for sectionOrder, section in pluginSections do
    for _, block in section do
        if block[1] == "file" then
            firstFile = firstFile or sectionOrder
            table.insert(filePaths, block[2])
        elseif block[1] == "text" then
            check("plugin text uses highlighting or prose", type(block[2]) == "string" and #block[2] > 0)
        end
    end
end
check("types and fields precede the examples", firstFile > 4)
for _, path in EXAMPLE_PATHS do
    check("example file exists: " .. path, fs.isFile(path))
    check("example file is listed in the docs: " .. path, table.find(filePaths, path) ~= nil)
end
check("the types file is shown in the docs", table.find(filePaths, "plugins/types.luau") ~= nil)
check("four complete code examples and the types file", #filePaths == 5)
local examples = {}
for index, path in EXAMPLE_PATHS do
    examples[index] = fs.readFile(path)
end
local executor = {
    loadstring = function(source) return luau.load(source) end,
    isfile = function(path) return path:match("example(%d+)%.luau$") ~= nil end,
    readfile = function(path) return examples[tonumber(path:match("example(%d+)%.luau$"))] end,
}
local state = { object = {}, save = function() end }
local classic = module("commands/systems/classicPlugins", {
    ["../../framework/environment/executor"] = executor, ["./resolvePlayers"] = function() return {} end,
})
local plugins = module("commands/systems/plugins", {
    ["../../framework/environment/executor"] = executor, ["../../framework/config/storage"] = storageConfig,
    ["../../storage/data/plugins"] = state, ["../../framework/config/commands/plugins"] = pluginConfig, ["./classicPlugins"] = classic,
})
local list = { lookup = {}, array = {}, original = {} }
for index, source in examples do
    luau.compile(source)
    check("example loads through plugin system " .. index, plugins.add(list, "example" .. index))
end
check("examples only use current plugin format", list.lookup.pluginhello and list.lookup.pluginws and list.lookup.pluginmessage)
local argsManager = module("commands/systems/argsManager", {})
local function args(values)
    local entries = {}
    for _, value in values do table.insert(entries, { value = value }) end
    return argsManager.new(entries)
end
local messages = {}
local humanoid = { WalkSpeed = 16 }
local controller = {
    playerService = { getHumanoid = function() return humanoid end },
    notify = function(_, title, text) table.insert(messages, { title, text }) end,
}
list.lookup.pluginhello.run(controller, args({}))
check("greeting handles omitted optional value", messages[#messages][2] == "Hello, world")
list.lookup.phi.run(controller, args({ "Ada" }))
check("greeting alias accepts a name", messages[#messages][2] == "Hello, Ada")
list.lookup.pluginws.run(controller, args({ 32 }))
check("walk speed example runs", humanoid.WalkSpeed == 32)
list.lookup.pluginresetws.run(controller, args({}))
check("second command resets walk speed", humanoid.WalkSpeed == 16)
humanoid = nil
list.lookup.pluginws.run(controller, args({ 32 }))
check("walk speed handles missing character", messages[#messages][1] == "Character")
list.lookup.pluginmessage.run(controller, args({ "info", "Hello world", false }))
check("boolean false preserved", messages[#messages][2] == "Hello world")
list.lookup.pluginmessage.run(controller, args({ "info", "Hello world", true }))
check("boolean true uppercases message", messages[#messages][2] == "HELLO WORLD")
list.lookup.pluginmessage.run(controller, args({ "warning", "Hello world" }))
check("optional boolean can be omitted", messages[#messages][1] == "warning" and messages[#messages][2] == "Hello world")

-- Build the real Reference component with simulated GUI objects; test tabs, paging, slides, scroll, code and copy.
local function dimension(xs, xo, ys, yo)
    return { X = { Scale = xs, Offset = xo }, Y = { Scale = ys, Offset = yo } }
end
local udim2 = {
    new = dimension, fromOffset = function(x, y) return dimension(0, x, 0, y) end,
    fromScale = function(x, y) return dimension(x, 0, y, 0) end,
}
local objects = {}
local function isInside(object, root)
    local current = object.Parent
    while current do
        if current == root then return true end
        current = current.Parent
    end
    return false
end
local create = { new = function(class, ...)
    local signals = {}
    local object = {
        isObject = true, ClassName = class, AbsoluteSize = { X = 500, Y = 300 }, Activated = event(),
        MouseEnter = event(), MouseLeave = event(),
    }
    function object:GetPropertyChangedSignal(property)
        signals[property] = signals[property] or event()
        return signals[property]
    end
    function object:TweenPosition(position) self.Position = position end
    function object:GetDescendants()
        local found = {}
        for _, other in objects do
            if isInside(other, self) then table.insert(found, other) end
        end
        return found
    end
    for _, argument in {...} do
        if type(argument) == "string" then
            object.Name = argument
        elseif argument.isObject then
            object.Parent = argument
        else
            for key, value in argument do
                if type(key) == "number" then
                    value.Parent = object
                elseif key == "ThemeTag" then
                    -- the theme service applies the tags when an object is created
                    for property, token in value do object[property] = token end
                else
                    object[key] = value
                end
            end
        end
    end
    table.insert(objects, object)
    return object
end }
local bar
local scrollFactory = { new = function()
    bar = { index = 0, totalSpace = 0, visibleSpace = 0, scrolledSignal = event() }
    function bar:create()
        self.container = create.new("Frame", "Container")
        return create.new("Frame", "ScrollBar")
    end
    function bar:setTotalSpace(total)
        self.totalSpace = total
        self.index = math.clamp(self.index, 0, math.max(0, total - self.visibleSpace))
    end
    function bar:setVisibleSpace(visible) self.visibleSpace = visible end
    function bar:scrollTo(index) self.index = index; self.scrolledSignal:Fire(index) end
    function bar:disableScroll() self.disabled = true end
    function bar:enableScroll() self.disabled = false end
    return bar
end }
local themes = {}
local icons = {}
local drag = { dragStarted = event(), dragEnded = event(), addGuiObject = function() end }
local clipboard = nil
local executor = { setclipboard = function(text) clipboard = text end }
-- the repo is simulated by the project's own files: a reference file is read from disk
local fetched = {}
local fetchService = { fetchReference = function(path)
    fetched[path] = (fetched[path] or 0) + 1
    return fs.readFile(path)
end }
-- every tween the component starts is recorded, so the tests can check direction, hover and timing
local tweenLog = {}
local TweenService = { Create = function(_, object, info, properties)
    local running = { object = object, info = info, properties = properties, Completed = event() }
    function running:Play()
        table.insert(tweenLog, { object = self.object, info = self.info, properties = self.properties })
        for property, value in self.properties do
            self.object[property] = value
        end
        self.Completed:Fire("Completed")
    end
    function running:Cancel()
        self.Completed:Fire("Cancelled")
    end
    return running
end }
local animation = { scale = 1 }
local tweenService = { getScale = function(_, time) return time * animation.scale end }
local connections = module("framework/services/connectionService", { ["../environment/private"] = {} })
-- every enum item is its own name: Enum.AutomaticSize.X is "X", Enum.PlaybackState.Completed is "Completed"
local enumProxy = setmetatable({}, { __index = function()
    return setmetatable({}, { __index = function(_, item) return item end })
end })
local reference = module("ui/components/reference", {
    ["../services/createService"] = create,
    ["../services/themeService"] = { addObject = function(_, object, tags)
        themes[object] = tags
        for property, token in tags do object[property] = token end
    end },
    ["../services/assetsService"] = { loadImage = function(_, object, name) icons[object] = name end },
    ["../utils/dragInstance"] = drag, ["./scrollBar"] = scrollFactory,
    ["../utils/scaleObject"] = { getScale = function() return 1 end },
    ["../../framework/services/connectionService"] = connections, ["../../framework/environment/executor"] = executor,
    ["../../framework/services/fetchService"] = fetchService,
    ["../../framework/services/rbxServices"] = { TweenService = TweenService },
    ["../../framework/services/tweenService"] = tweenService,
    ["../../framework/settings"] = { links = { discord = "example.test" } },
    ["../../framework/config/ui/reference"] = config, ["../../utils/luahighlight"] = highlight,
}, {
    UDim2 = udim2, UDim = { new = function(scale, offset) return { Scale = scale, Offset = offset } end },
    Enum = enumProxy,
    TweenInfo = { new = function(duration, style, direction) return { duration = duration, style = style, direction = direction } end },
    tick = function() return os.clock() end,
    -- the client runs spawned work on its own schedule; here it runs at once, and waits do not stall the test
    task = { spawn = function(callback, ...) callback(...) end, wait = function() end },
})

-- true when a tween of the object was started with a property that matches
local function tweened(object, matches)
    for _, entry in tweenLog do
        if entry.object == object and matches(entry.properties) then return true end
    end
    return false
end
local function countNamed(root, name, class)
    local count = 0
    for _, object in objects do
        if object.Name == name and object.Parent == root and (class == nil or object.ClassName == class) then
            count += 1
        end
    end
    return count
end
local function findNamed(root, name)
    for _, object in objects do
        if object.Name == name and object.Parent and (object.Parent == root or object.Parent.Parent == root) then
            return object
        end
    end
end

local view = reference.new()
local frame = view:create()
local typesPage, pluginsPage = view.pages.types, view.pages.plugins
local typesBody = typesPage.entries[1].body
check("Reference initially selects Types", view.pageId == "types" and typesPage.entries[1].slide.Visible)
check("Plugins entries start hidden", not pluginsPage.entries[1].slide.Visible and not pluginsPage.entries[2].slide.Visible)
check("Types has no footer", view.navigation.Visible == false and view.holder.Size.Y.Offset == 300)
check("the thumb starts under Types", view.thumb.Position.X.Scale == 0)
typesBody.AbsoluteSize.Y = 1400
pluginsPage.entries[1].body.AbsoluteSize.Y = 2600
pluginsPage.button.Activated:Fire()
check("Plugins tab switches page", view.pageId == "plugins" and pluginsPage.entries[1].slide.Visible)
check("Types hidden after switch", not typesPage.entries[1].slide.Visible)
check("Plugins uses its own content height", bar.totalSpace == 2600 and bar.index == 0)
check("the footer shows and the content gives up its room", view.navigation.Visible and view.holder.Size.Y.Offset == 260
    and view.footer.Size.Y.Offset == 40 and view.navigation.Position.Y.Offset == 0)
check("the thumb slides under the Plugins tab", view.thumb.Position.X.Scale == 0.5)
check("a switch to Plugins slides Types out to the left", tweened(typesPage.entries[1].slide, function(p)
    return p.Position and p.Position.X.Offset == -36 end))
check("the content height and the footer are tweened", tweened(view.holder, function(p) return p.Size and p.Size.Y.Offset == 260 end)
    and tweened(view.navigation, function(p) return p.Position and p.Position.Y.Offset == 0 end))
check("Plugins starts on its first page", pluginsPage.index == 1 and #pluginsPage.entries == 10)
check("first page: only NEXT is tonal, BACK is disabled", themes[view.nav.back.button].BackgroundColor3 == "Colors.Tonal.Disabled"
    and themes[view.nav.forward.button].BackgroundColor3 == "Colors.Tonal.Default")
check("first page: BACK is disabled in its label and icon too", themes[view.nav.back.label].TextColor3 == "Colors.Tonal.DisabledText"
    and themes[view.nav.back.icon].ImageColor3 == "Colors.Tonal.DisabledText")
check("the counter says the page number out of all", view.counter.Text == "1 / 10")
check("the label keeps its medium font with its color", themes[view.nav.back.label].Font == "Font.Medium")
check("the buttons carry their icons and labels in the right order", view.nav.back.icon.LayoutOrder == 1
    and view.nav.back.label.LayoutOrder == 2 and view.nav.forward.label.LayoutOrder == 1 and view.nav.forward.icon.LayoutOrder == 2)
check("only the current page is shown", pluginsPage.entries[1].slide.Visible and not pluginsPage.entries[2].slide.Visible)
bar:scrollTo(400)
check("scroll moves the active body", pluginsPage.entries[1].body.Position.Y.Offset == -400)

view.nav.forward.button.Activated:Fire()
check("NEXT shows the second page", pluginsPage.index == 2 and pluginsPage.entries[2].slide.Visible and not pluginsPage.entries[1].slide.Visible)
check("NEXT slides the old page out to the left", tweened(pluginsPage.entries[1].slide, function(p)
    return p.Position and p.Position.X.Offset == -36 end))
check("the new page is at rest", pluginsPage.entries[2].slide.Position.X.Offset == 0)
check("scroll resets on a new page", bar.index == 0)
check("BACK and NEXT are both tonal in the middle", themes[view.nav.back.button].BackgroundColor3 == "Colors.Tonal.Default"
    and themes[view.nav.forward.button].BackgroundColor3 == "Colors.Tonal.Default")
check("the counter follows the page", view.counter.Text == "2 / 10")
view.nav.back.button.Activated:Fire()
check("BACK returns to the first page", pluginsPage.index == 1)
check("BACK slides the old page out to the right", tweened(pluginsPage.entries[2].slide, function(p)
    return p.Position and p.Position.X.Offset == 36 end))
local tweensBeforeIdle = #tweenLog
view.nav.back.button.Activated:Fire()
check("BACK on the first page does nothing", pluginsPage.index == 1 and #tweenLog == tweensBeforeIdle)
for _ = 1, 20 do view.nav.forward.button.Activated:Fire() end
check("NEXT stops on the last page", pluginsPage.index == 10 and pluginsPage.entries[10].slide.Visible)
check("last page: NEXT is disabled, BACK is tonal", themes[view.nav.forward.button].BackgroundColor3 == "Colors.Tonal.Disabled"
    and themes[view.nav.back.button].BackgroundColor3 == "Colors.Tonal.Default")
check("the counter reads the last page", view.counter.Text == "10 / 10")
check("the pill is in the footer, the footer in the window", view.nav.forward.button.Parent == view.navigation
    and view.navigation.Parent == view.footer and view.footer.Parent == frame)
check("the tab track is outside the scroll area", pluginsPage.button.Parent.Parent.Parent == frame)
check("every page stays attached to the scroll container", typesPage.entries[1].slide.Parent == view.container
    and pluginsPage.entries[1].slide.Parent == view.container)

-- hover: an enabled half tints, a disabled one does not
local hoverTweens = #tweenLog
view.nav.back.button.MouseEnter:Fire()
check("hovering an enabled half tints it", tweened(view.nav.back.button, function(p)
    return p.BackgroundTransparency == 0.15 end))
view.nav.back.button.MouseLeave:Fire()
check("leaving the half clears the tint", tweened(view.nav.back.button, function(p) return p.BackgroundTransparency == 0 end))
view.nav.forward.button.MouseEnter:Fire()
check("a disabled half does not tint on hover", not tweened(view.nav.forward.button, function(p)
    return p.BackgroundTransparency == 0.15 end))
check("hover tweens were started", #tweenLog > hoverTweens)

view.pages.types.button.Activated:Fire()
check("switching to Types hides the footer again", view.pageId == "types" and typesPage.entries[1].slide.Visible
    and view.navigation.Visible == false and view.holder.Size.Y.Offset == 300)
check("Types is shown in full", typesPage.entries[1].slide.Visible and not pluginsPage.entries[10].slide.Visible)
check("Types has every section", countNamed(typesBody, "Section") == #config.sections)
pluginsPage.button.Activated:Fire()
check("returning to Plugins keeps the page it was on", pluginsPage.index == 10 and pluginsPage.entries[10].slide.Visible)
view.pages.types.button.Activated:Fire()
check("switching back to Types resets scroll", view.pageId == "types" and bar.index == 0 and bar.totalSpace == 1400)
check("invalid page ignored", not view:selectPage("missing") and view.pageId == "types")

-- the code blocks: each file is read when its page is shown, and then kept by the component
check("every code block is in the reference", countNamed(pluginsPage.entries[1].body, "Code") == 0
    and countNamed(pluginsPage.entries[6].body, "Code") == 1)
local codeLabels = 0
for _, object in objects do
    if object.Name == "Source" then
        codeLabels += 1
        check("code block is rich text and monospace", object.RichText and object.Font == "Font.MonoSpace")
    end
end
check("five code blocks: four examples and the types file", codeLabels == 5)

local roundedCodes = 0
local codePaddings = 0
for _, object in objects do
    if object.ClassName == "UICorner" and object.Parent and object.Parent.Name == "Code" and object.CornerRadius.Offset == 6 then
        roundedCodes += 1
    end
    if object.ClassName == "UIPadding" and object.Parent and object.Parent.Name == "Code" then
        error("the copy button would move with a padding on the block")
    end
    if object.ClassName == "UIPadding" and object.Parent and object.Parent.Name == "Source" and object.PaddingRight.Offset == 28 then
        codePaddings += 1
    end
end
check("code blocks have rounded corners", roundedCodes == 5)
check("the text, not the block, keeps clear of the copy button", codePaddings == 5)

local examplesRead = fetched["plugins/examples/greeting.luau"] == 1 and fetched["plugins/examples/walkspeed.luau"] == 1
    and fetched["plugins/examples/message.luau"] == 1 and fetched["plugins/examples/players.luau"] == 1
check("the examples are read when their pages are shown, once", examplesRead)
check("the types file is read on the last page, once", fetched["plugins/types.luau"] == 1)
local highlighted = 0
for _, object in objects do
    if object.Name == "Source" and object.Text:find("<font color=", 1, true) then highlighted += 1 end
end
check("the code of every page that was shown is highlighted", highlighted == 5)
check("a code block fades in when its text arrives", tweened(findNamed(pluginsPage.entries[10].body, "Source"), function(p)
    return p.TextTransparency == 0 end))

local typesCopy = findNamed(pluginsPage.entries[10].body, "Copy")
check("the copy button has the clipboard icon", typesCopy ~= nil and icons[typesCopy] == "lucide-clipboard-copy")
check("the copy button sits in the top right corner of its block", typesCopy.Parent.Name == "Code"
    and typesCopy.Position.X.Scale == 1 and typesCopy.Position.X.Offset == -20 and typesCopy.Position.Y.Offset == 6)
typesCopy.Activated:Fire()
check("the copy button copies the file text", clipboard == fs.readFile("plugins/types.luau"))
check("copying flashes the icon", tweened(typesCopy, function(p) return p.ImageColor3 == "Colors.Primary" end))

-- animations switched off (the animation scale is 0): every change is instant and no tween is started
animation.scale = 0
local tweensOff = #tweenLog
view.pages.types.button.Activated:Fire()
pluginsPage.button.Activated:Fire()
view.nav.back.button.Activated:Fire()
check("with animations off nothing is tweened", #tweenLog == tweensOff)
check("with animations off the page still changes at once", pluginsPage.index == 9 and pluginsPage.entries[9].slide.Visible
    and not pluginsPage.entries[10].slide.Visible and pluginsPage.entries[9].slide.Position.X.Offset == 0)
animation.scale = 1

view:open()
check("Reference still opens", view.isOpen)
view:close()
check("Reference still closes", not view.isOpen)
print(`{passed} Reference checks passed`)
