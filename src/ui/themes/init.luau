local themes = {
	require("./classic"),
	require("./dark"),
	require("./light")
}

local lookup = {}

for _, theme in themes do
	local name = string.lower(theme.DisplayName)
	lookup[name] = theme
end

return lookup