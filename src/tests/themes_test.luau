-- Run from the project root: lune run src/tests/themes_test.luau
-- Every theme must have the same color and font keys as the dark theme, or a part of the UI would get no color.
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local passed = 0
local function check(name, value)
    assert(value, "FAIL: " .. name)
    passed += 1
end

local enumProxy = setmetatable({}, { __index = function()
    return setmetatable({}, { __index = function(_, item) return item end })
end })
-- a color is a leaf of a theme, so it is kept as text here
local color3 = {
    fromRGB = function(r, g, b) return string.format("%d,%d,%d", r, g, b) end,
    new = function(r, g, b) return string.format("%d,%d,%d", r * 255, g * 255, b * 255) end,
}

local function loadTheme(name)
    local environment = { Color3 = color3, Enum = enumProxy }
    return luau.load(fs.readFile("src/ui/themes/" .. name .. ".luau"), {
        environment = environment, injectGlobals = true, debugName = name,
    })()
end

-- the registry, as the UI loads it: "./name" resolves to the theme file next to it
local registryEnvironment = { Color3 = color3, Enum = enumProxy }
registryEnvironment.require = function(name)
    return loadTheme(string.sub(name, 3))
end
local registry = luau.load(fs.readFile("src/ui/themes/init.luau"), {
    environment = registryEnvironment, injectGlobals = true, debugName = "themes",
})()

local dark = loadTheme("dark")

-- collects the paths of every key of a table, e.g. "Colors.Buttons.Default"
local function paths(value, prefix, found)
    found = found or {}
    if type(value) ~= "table" then
        table.insert(found, prefix)
        return found
    end
    for key, child in value do
        paths(child, if prefix == "" then tostring(key) else prefix .. "." .. tostring(key), found)
    end
    return found
end

local function lookup(root, path)
    local current = root
    for part in string.gmatch(path, "[^.]+") do
        if type(current) ~= "table" then return nil end
        current = current[part]
    end
    return current
end

check("the registry has the classic, dark, light and M3 dark themes",
    registry.classic ~= nil and registry.dark ~= nil and registry.light ~= nil and registry["m3 dark"] ~= nil)
check("the M3 dark theme is named for the picker", registry["m3 dark"].DisplayName == "M3 Dark")

local referenceKeys = paths(dark, "")
for name, theme in registry do
    check(name .. " has a font and colors (it can be used)", theme.Font ~= nil and theme.Colors ~= nil)
    for _, path in referenceKeys do
        if path ~= "DisplayName" then
            check(name .. " has " .. path, lookup(theme, path) ~= nil)
        end
    end
end

for name, theme in registry do
    check(name .. " has the tonal colors of the reference footer",
        lookup(theme, "Colors.Tonal.Default") ~= nil and lookup(theme, "Colors.Tonal.Text") ~= nil
        and lookup(theme, "Colors.Tonal.Disabled") ~= nil and lookup(theme, "Colors.Tonal.DisabledText") ~= nil)
end

print(`{passed} theme checks passed`)
