-- src/utils/getHierarchy.luau
-- Builds the Lua code that reaches an instance from game, for example:
--   game:GetService("Workspace").Model["Front Door"].Handle
-- Names that are not plain Lua identifiers (spaces, dashes, a leading digit, Lua keywords...)
-- are written as ["..."] indexes, so the returned code always runs.

local LUA_KEYWORDS = {
	["and"] = true, ["break"] = true, ["do"] = true, ["else"] = true, ["elseif"] = true,
	["end"] = true, ["false"] = true, ["for"] = true, ["function"] = true, ["if"] = true,
	["in"] = true, ["local"] = true, ["nil"] = true, ["not"] = true, ["or"] = true,
	["repeat"] = true, ["return"] = true, ["then"] = true, ["true"] = true,
	["until"] = true, ["while"] = true,
}

local function escapeString(text: string): string
	local escaped = text:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("\n", "\\n")
	return escaped
end

local function indexFor(name: string): string
	if string.match(name, "^[%a_][%w_]*$") and not LUA_KEYWORDS[name] then
		return "." .. name
	end

	return '["' .. escapeString(name) .. '"]'
end

-- Services are reached with game:GetService. Anything else directly under game is reached with game[...].
local function rootFor(top: Instance): string
	local isService = pcall(game.GetService, game, top.ClassName)

	if isService then
		return `game:GetService("{top.ClassName}")`
	end

	return "game" .. indexFor(top.Name)
end

local function getHierarchy(instance: Instance?): string
	if not instance then
		return ""
	end

	-- walk up to game, collecting every instance on the way (top-level first)
	local chain = {}
	local node = instance

	while node and node ~= game do
		table.insert(chain, 1, node)
		node = node.Parent
	end

	-- detached instance (or a parent was destroyed): there is no code path from game to it
	if node ~= game then
		return instance:GetFullName()
	end

	if #chain == 0 then
		return "game"
	end

	local path = rootFor(chain[1])

	for index = 2, #chain do
		path = path .. indexFor(chain[index].Name)
	end

	return path
end

return getHierarchy
