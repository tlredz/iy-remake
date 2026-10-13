--[[
	this code is a lua bundle made for roblox
	made by: real_redz (redz hub team)
]]

local ORIGINAL_REQUIRE = require

local bundle = {}
local moduleCache = {}

local EXTENSIONS = { ".lua", ".luau", "/init.lua", "/init.luau" }

local function normalizePath(path)
	local parts = {}
	for part in string.gmatch(path, "[^/]+") do
		if part == ".." then
			table.remove(parts)
		elseif part ~= "." then
			table.insert(parts, part)
		end
	end
	return table.concat(parts, "/")
end

local function folderOf(path)
	return path:match("^(.*)/[^/]*$") or ""
end

function bundle.new(currentPath)
	currentPath = currentPath or ""
	assert(type(currentPath) == "string", "#1 must be a string")
	
	local bundler = {
		currentPath = normalizePath(currentPath),
	}
	
	function bundler.readFile(filePath)
		if type(readfile) ~= "function" or type(isfile) ~= "function" then
			return nil, "readfile/isfile not available"
		end
		if not isfile(filePath) then
			return nil, "file not found: " .. filePath
		end
		return readfile(filePath)
	end
	
	function bundler.createChunk(sourceCode, folderPath, debugPath)
		local chunk, err = loadstring(sourceCode, "=" .. debugPath)
		if not chunk then
			return false, err
		end
		
		if setfenv and getfenv then
			local env = setmetatable({}, { __index = getfenv(chunk) })
			env.require = bundle.new(folderPath).require
			setfenv(chunk, env)
		end
		
		return pcall(chunk)
	end

	function bundler.require(path)
		if type(path) ~= "string" then
			return ORIGINAL_REQUIRE(path)
		end
		
		local names = { path }
		if path:lower() ~= path then
			table.insert(names, path:lower())
		end
		
		local filePath, source
		for _, name in ipairs(names) do
			for _, ext in ipairs(EXTENSIONS) do
				local candidate = normalizePath(bundler.currentPath .. "/" .. name .. ext)
				
				local entry = moduleCache[candidate]
				if entry then
					if entry.loading then
						error("circular require: '" .. candidate .. "'", 2)
					end
					return entry.value
				end
				
				local content = bundler.readFile(candidate)
				if content then
					filePath, source = candidate, content
					break
				end
			end
			if filePath then
				break
			end
		end
		
		if not filePath then
			error("could not resolve module path: '" .. path .. "'", 2)
		end
		
		moduleCache[filePath] = { loading = true }
		
		local ok, result = bundler.createChunk(source, folderOf(filePath), filePath)
		if not ok then
			moduleCache[filePath] = nil
			error(result, 0)
		end
		
		if result == nil then
			result = true
		end
		
		moduleCache[filePath] = { value = result }
		return result
	end

	return bundler
end

return bundle