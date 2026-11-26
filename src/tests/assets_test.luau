-- Run from the project root: lune run src/tests/assets_test.luau
-- The base64 decoder, and the images built into the code (ui/themes/icons/raw): each one must be its file, byte for byte
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local passed = 0
local function check(name, value)
    assert(value, "FAIL: " .. name)
    passed += 1
end

local function module(path, deps)
    local environment = {
        require = function(name)
            assert(deps[name] ~= nil, "unmocked dependency: " .. name)
            return deps[name]
        end,
    }
    return luau.load(fs.readFile("src/" .. path .. ".luau"), {
        environment = environment, injectGlobals = true, debugName = path,
    })()
end

local base64 = module("utils/base64", {})
check("empty text is empty", base64.decode("") == "")
check("four characters make three bytes", base64.decode("TWFu") == "Man")
check("three characters make two bytes", base64.decode("TWE=") == "Ma")
check("two characters make one byte", base64.decode("TQ==") == "M")
check("line breaks are skipped", base64.decode("TW\nFu") == "Man")
check("a PNG signature", base64.decode("iVBORw0KGgo=") == "\137PNG\r\n\26\n")

local raw = luau.load(fs.readFile("src/ui/themes/icons/raw.luau"), {
    injectGlobals = true, debugName = "raw",
})()

local images = 0
for folder, files in raw do
    for name, text in files do
        local original = fs.readFile(`assets/{folder}/{name}.png`)
        check(`built image {folder}/{name} is its file`, base64.decode(text) == original)
        images += 1
    end
end
check("the code has images built in", images > 0)

-- every icon of the legacy map is a name of the icon table: a missing name would stop the settings page from opening
local legacyFiles = module("ui/themes/icons/legacy", {})
local icons = luau.load(fs.readFile("src/ui/themes/icons/interface.luau"), {
    injectGlobals = true, debugName = "interface",
})()
local legacyCount = 0
for iconName in legacyFiles do
    check(`legacy icon {iconName} is in the icon table`, icons[iconName] ~= nil)
    legacyCount += 1
end
check("the legacy map has icons", legacyCount > 0)

print(`{passed} asset checks passed ({images} images)`)
