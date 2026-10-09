local require = require

if not IS_COMPILED and readfile and isfile then
	local bundlePath = nil
	local folderPath = nil
	
	for _, path in {"iy-remake", "tlredz/iy-remake"} do
		if isfolder(path) then
			folderPath = path
			break
		end
	end
	
	assert(folderPath, "failed to find IY folder")
	
	for _, path in {`{folderPath}/rbxBundle.lua`, `{folderPath}/rbxBundle.luau`} do
		if isfile(path) then
			bundlePath = path
			break
		end
	end
	
	assert(bundlePath, "failed to find rbxBundle")
	
	local bundle = loadstring(readfile(bundlePath))()
	require = bundle.new(folderPath).require
end

require("./main")