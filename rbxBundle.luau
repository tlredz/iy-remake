--[[
	this code is a lua bundle made for roblox
	made by: real_redz (redz hub team)
]]

local ORIGINAL_REQUIRE = require

local bundle = {}

local requiredModules = {}
local modulesGarbage = {}

function bundle.new(currentPath)
	currentPath = currentPath or ""
	assert(type(currentPath) == "string", "#1 must be a string")
	
	if currentPath:sub(#currentPath) == "/" then
		currentPath = currentPath:sub(1, -2)
	end
	
	local bundler = {
		currentPath = currentPath,
		owner = owner,
		repository = repository
	}
	
	-- Helper to read file from filesystem (Roblox Studio plugin environment)
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
		local chunk, err = loadstring(sourceCode, `={debugPath}`)
		
		if not chunk then
			return false, err
		end
		
		if setfenv and getfenv then
			local env = {}
			
			setmetatable(env, {
				__index = getfenv(chunk)
			})
			
			local subBundler = bundle.new(folderPath)
			env.require = subBundler.require
			
			setfenv(chunk, env)
		end
		
		return pcall(chunk)
	end
	
	-- Convert a filesystem path to a GitHub-style path (for display/storage)
	function bundler.getPath(path)
		if path:sub(1, 1) ~= "/" then
			path = "/" .. path
		end
		
		path = currentPath .. path
		return bundler.normalizePath(path)
	end
	
	-- Resolve a relative path against the current base path
	function bundler.normalizePath(path)
		local split = path:split("/")
		local fileName = table.remove(split)
		local parts = {}
		
		for _, part in split do
			if part == ".." then
				table.remove(parts)
			elseif part ~= "." then
				table.insert(parts, part)
			end
		end
		
		return table.concat(parts, "/"), fileName
	end
	
	-- Main require function
	function bundler.require(path)
		if type(path) ~= "string" then
			-- error(`invalid argument #1 to 'require' (string expected, got {typeof(path)})`, 2)
			return ORIGINAL_REQUIRE(path)
		end
		
		local fullPath = path:lower()
		
		local attemps = {
			fullPath .. ".lua",
			fullPath .. ".luau"
		}
		
		local source, folderPath, filePath = nil, nil, nil
		
		for _, attempt in attemps do
			local folder, name = bundler.getPath(attempt)
			folderPath, filePath = folder, (folder .. "/" .. name)
			
			if requiredModules[filePath] then
				return modulesGarbage[filePath]
			end
			
			source = bundler.readFile(filePath)
			if source then break end
		end
		
		if not source then
			error(`could not soulve module path: '{fullPath}'`)
		end
		
		-- Create and execute chunk
		local success, result = bundler.createChunk(source, folderPath, path)
		if not success then
			error(`={filePath}:\n{result}`, 2)
		end
		
		-- Cache and return
		requiredModules[filePath] = true
		modulesGarbage[filePath] = result
		
		return result
	end
	
	return bundler
end

return bundle