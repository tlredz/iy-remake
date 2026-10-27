local themes = {
	require("./classic"),
	require("./dark"),
	require("./light"),
	require("./m3dark")
}

local lookup = {}

for _, theme in themes do
	local name = string.lower(theme.DisplayName)
	lookup[name] = theme
end

return lookup