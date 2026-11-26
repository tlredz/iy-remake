-- Run from the project root: lune run src/tests/dock_test.luau
-- The drag rules of the main window (ui/utils/mainFrameDock, onDragEnded). moveTo and minimize are replaced by recorders,
-- so each case checks the state a drag leads to, without any tween. A gesture has the fields dragService gives:
-- dx, dy (net px, down positive), velocityY (px/s over the last movement), travel (farthest px)
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local passed = 0
local function check(name, value)
    assert(value, "FAIL: " .. name)
    passed += 1
end

-- any Enum.Group.Name is its name
local Enum = setmetatable({}, {
    __index = function()
        return setmetatable({}, { __index = function(_, name) return name end })
    end,
})

local deps = {
    ["../../framework/services/rbxServices"] = {
        TweenService = {},
        UserInputService = { MouseEnabled = false },
        RunService = {},
    },
    ["../../framework/services/connectionService"] = {},
    ["../../framework/services/tweenService"] = {},
}

local dock = luau.load(fs.readFile("src/ui/utils/mainFrameDock.luau"), {
    environment = {
        require = function(name)
            assert(deps[name] ~= nil, "unmocked dependency: " .. name)
            return deps[name]
        end,
        Enum = Enum,
    },
    injectGlobals = true,
    debugName = "mainFrameDock",
})()

-- a screen 800px tall, a window 300px tall and a top bar 40px tall: expanded is at top 500, minimized at top 760
local SCREEN_HEIGHT, WINDOW_HEIGHT, TOP_BAR = 800, 300, 40

local function windowAt(state: string, top: number, options)
    options = options or {}
    local self = setmetatable({
        state = state,
        frame = { AbsolutePosition = { Y = top }, AbsoluteSize = { Y = WINDOW_HEIGHT } },
        screenGui = { AbsoluteSize = { Y = SCREEN_HEIGHT } },
        topBarHeight = TOP_BAR,
        getScale = function() return 1 end,
        keepOpen = options.keepOpen == true,
        commandBarInUse = options.commandBarInUse,
        swipeLocked = options.swipeLocked == true,
        dragging = false,
        connections = {},
    }, dock)
    self.moveTo = function(_, target) self.decided = target end
    self.minimize = function() self.decided = "minimized" end
    return self
end

-- the state a drag that ends now leads to
local function release(self, dx: number, dy: number, velocityY: number, travel: number?)
    self.decided = nil
    self:onDragEnded({
        dx = dx,
        dy = dy,
        velocityY = velocityY,
        travel = travel or math.max(math.abs(dx), math.abs(dy)),
        duration = 0.2,
    })
    return self.decided
end

-- taps and wobbles
check("a tap keeps the state", release(windowAt("top", 0), 1, 2, 0, 3) == "top")
check("a few px down keeps the top state", release(windowAt("top", 0), 0, 5, 0, 12) == "top")
check("a few px up keeps the minimized state", release(windowAt("minimized", 760), 0, -5, 0, 12) == "minimized")

-- slow slides
check("a slow slide down from the top opens it at the bottom", release(windowAt("top", 0), 0, 30, 150) == "expanded")
check("a slide down of exactly SLIDE_MIN from the top counts", release(windowAt("top", 0), 0, 10, 50, 12) == "expanded")
check("a slow slide down from the bottom keeps it open", release(windowAt("expanded", 500), 0, 30, 150) == "expanded")
check("a slow slide down from minimized keeps it minimized", release(windowAt("minimized", 760), 0, 30, 150) == "minimized")
check("a slow drag all the way down minimizes it", release(windowAt("top", 760), 0, 760, 200) == "minimized")
check("a slow drag from the bottom all the way down minimizes it", release(windowAt("expanded", 760), 0, 260, 200) == "minimized")

-- flicks
check("a flick down from the top minimizes it", release(windowAt("top", 0), 0, 60, 1500) == "minimized")
check("a short flick (DRAG_DOWN_MIN px) minimizes it", release(windowAt("top", 0), 0, 35, 1500) == "minimized")
check("a flick down from the bottom minimizes it", release(windowAt("expanded", 500), 0, 80, 1600) == "minimized")
check("a fast wobble shorter than DRAG_DOWN_MIN is not a flick", release(windowAt("top", 0), 0, 20, 2000) == "expanded")
check("a fast slide that is too slow at the release is not a flick", release(windowAt("top", 0), 0, 60, 300) == "expanded")

-- slides up
check("a slide up from the bottom moves it to the top", release(windowAt("expanded", 500), 0, -40, -400) == "top")
check("a weak slide up from the top keeps it at the top", release(windowAt("top", 0), 0, -15, -200, 15) == "top")
check("a weak slide up from minimized opens it", release(windowAt("minimized", 760), 0, -20, -200) == "expanded")
check("a slide up with a little sideways drift still moves it to the top",
    release(windowAt("expanded", 500), 5, -40, -400) == "top")

-- sideways swipes: they must not move the window, even when they drift up or down a little
check("a sideways swipe with a little drift up keeps the top state",
    release(windowAt("top", 0), 80, -15, -100, 82) == "top")
check("a sideways swipe with a little drift up keeps the bottom state (no move to the top)",
    release(windowAt("expanded", 500), 80, -15, -100, 82) == "expanded")
check("a sideways swipe with a little drift down does not minimize it",
    release(windowAt("top", 0), 80, 15, 100, 82) == "top")
check("a diagonal drag that is not mostly vertical does not move it",
    release(windowAt("expanded", 500), 30, -40, -400) == "expanded")

-- the locks do not stop a deliberate drag, only the automatic minimizing
check("the command bar in use does not stop a flick down",
    release(windowAt("top", 0, { commandBarInUse = function() return true end }), 0, 60, 1500) == "minimized")
check("the automatic keep open does not stop a flick down",
    release(windowAt("expanded", 500, { swipeLocked = true }), 0, 80, 1600) == "minimized")
check("Keep Menu Open does not stop a flick down",
    release(windowAt("top", 0, { keepOpen = true }), 0, 60, 1500) == "minimized")
check("the command bar in use still lets a slow slide open it at the bottom",
    release(windowAt("top", 0, { commandBarInUse = function() return true end }), 0, 30, 150) == "expanded")
check("Keep Menu Open still lets a slide up move it to the top",
    release(windowAt("expanded", 500, { keepOpen = true }), 0, -40, -400) == "top")

print(`{passed} drag checks passed`)
