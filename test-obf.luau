-- just testing redz hub obfuscator

local files = {"before-optimization.lua", "original.lua"}

for index = 1, 9e9 do
	local fileName = `after-optimization-{index}.lua`
	if not isfile(`lumarge-iy/{fileName}`) then break end
	table.insert(files, fileName)
end

local function benchmark(fileName: string): (number)
    local startedAt = os.clock()
    print(`started loading '{fileName}'`)
    
    loadstring(readfile(`lumarge-iy/{fileName}`))()
    
    local totalTime = os.clock() - startedAt
    print(`iy remake loaded in {totalTime}`)
    return totalTime
end

--[[do
	local index, old = 1
	old = hookfunction(loadstring, function(src, chunkName)
		writefile(`lumarge-loadstring-dump/{index}.lua`, src)
		index += 1
		return old(src, chunkName)
	end)
end]]

do
	-- benchmark("before-optimization.lua")
	-- benchmark("after-optimization-6.lua")
	benchmark("iy-strong-3.lua")
	-- benchmark("after-optimization-7.lua")
	-- benchmark("iy-compiled-Obfuscated.lua")
	return
end

-- /storage/emulated/0/Delta/Workspace/lumarge-iy/original.lua /storage/emulated/0/Delta/Workspace/lumarge-iy/after-optimization-2.lua

for _, fileName in files do
	benchmark(fileName)
	task.wait(1)
end