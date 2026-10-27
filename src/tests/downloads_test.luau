-- Run from the project root: lune run src/tests/downloads_test.luau
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

-- a file system that records the folders made and keeps the files written, by their full path
local made, files = {}, {}
local fileSystem = {
    makeFolder = function(_, path) table.insert(made, path) end,
    exist = function(_, path) return files[path] ~= nil end,
    readFile = function(_, path) return files[path] end,
    writeFile = function(_, path, content) files[path] = content end,
}
local downloads = module("storage/downloads", {
    ["./fileSystem"] = fileSystem,
    ["../framework/config/storage"] = module("framework/config/storage", {}),
    ["../version"] = "1.2.3",
})

downloads.write("reference", "plugins/examples/greeting.luau", "return {}")
check("each folder is made in order, from backups down", table.concat(made, " | ") ==
    "backups | backups/1.2.3 | backups/1.2.3/reference | backups/1.2.3/reference/plugins | backups/1.2.3/reference/plugins/examples")
check("the file is written where the version keeps it", files["backups/1.2.3/reference/plugins/examples/greeting.luau"] == "return {}")
check("the kept copy is read back for the same version", downloads.read("reference", "plugins/examples/greeting.luau") == "return {}")
check("a copy is missing for another kind", downloads.read("scripts", "plugins/examples/greeting.luau") == nil)

made = {}
downloads.write("assets", "lucide-close.png", "png")
check("a name without folders only makes the kind folders", table.concat(made, " | ") == "backups | backups/1.2.3 | backups/1.2.3/assets")

print(`{passed} download checks passed`)
