-- Run from the project root: lune run src/tests/dragService_test.luau
-- The velocity of a release (ui/services/dragService, _velocity). The clock is the test's own, so each case sets the
-- time of each movement
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local passed = 0
local function check(name, value)
    assert(value, "FAIL: " .. name)
    passed += 1
end

local now = 0

-- a position with X and Y, where a difference is a position too
local function point(x: number, y: number)
    return setmetatable({ X = x, Y = y }, {
        __sub = function(a, b)
            return point(a.X - b.X, a.Y - b.Y)
        end,
    })
end

local deps = {
    ["../utils/inputUtils"] = { isPressingInput = function() return true end },
    ["../../framework/services/rbxServices"] = {
        UserInputService = { InputBegan = {}, InputEnded = {}, InputChanged = {} },
    },
    ["../../utils/signal"] = {
        new = function() return { Fire = function() end, Connect = function() end } end,
    },
}

local dragService = luau.load(fs.readFile("src/ui/services/dragService.luau"), {
    environment = {
        require = function(name)
            assert(deps[name] ~= nil, "unmocked dependency: " .. name)
            return deps[name]
        end,
        os = { clock = function() return now end },
        Vector2 = {
            new = function(x: number, y: number) return { X = x, Y = y } end,
            zero = { X = 0, Y = 0 },
        },
        Enum = setmetatable({}, { __index = function() return setmetatable({}, { __index = function(_, n) return n end }) end }),
    },
    injectGlobals = true,
    debugName = "dragService",
})()

-- a press that moved: each sample is a time and a position
local function sample(service, time: number, x: number, y: number)
    now = time
    service:_recordSample(point(x, y))
end

local function velocityAt(service, time: number)
    now = time
    return service:_velocity()
end

local function near(a: number, b: number): boolean
    return math.abs(a - b) < 0.5
end

-- a flick: 60px down in 0.06s, after the finger was on the screen
local flick = dragService.new()
sample(flick, 0, 0, 0)
sample(flick, 0.03, 0, 30)
sample(flick, 0.06, 0, 60)
check("a flick measures its speed (1000 px/s)", near(velocityAt(flick, 0.06).Y, 1000))

-- a flick that starts after a slow beginning: the speed is of the last movement, not the whole press
local late = dragService.new()
sample(late, 0, 0, 0)
sample(late, 0.4, 0, 5)
sample(late, 0.43, 0, 50)
sample(late, 0.46, 0, 95)
check("a flick after a slow start is still fast (1500 px/s)", near(velocityAt(late, 0.46).Y, 1500))

-- a finger that stopped before it was let go is not moving
check("a finger that stopped has no velocity", velocityAt(flick, 1.0).Y == 0)

-- a slow drag: 20px in half a second
local slow = dragService.new()
sample(slow, 0, 0, 0)
sample(slow, 0.5, 0, 20)
check("a slow drag measures its speed (40 px/s)", near(velocityAt(slow, 0.5).Y, 40))

-- a sideways swipe has speed on X, not on Y
local side = dragService.new()
sample(side, 0, 0, 0)
sample(side, 0.1, 60, 0)
local sideVelocity = velocityAt(side, 0.1)
check("a sideways swipe moves X (600 px/s)", near(sideVelocity.X, 600))
check("a sideways swipe does not move Y", sideVelocity.Y == 0)

print(`{passed} drag service checks passed`)
