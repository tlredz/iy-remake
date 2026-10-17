local startedAt = os.clock()
local fileNwme = ("iy-compiled.obfuscated.luau") -- ("iy-compiled.luau"), ("iy-compiled.obfuscated.luau")

print(`started loading '{fileName}'`)

loadstring(readfile(fileNwme))()

print(`iy remake loaded in {os.clock() - startedAt}`)