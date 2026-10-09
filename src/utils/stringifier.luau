local stringifier = {}

local toString = {
	["Vector3"] = function(value)
		return `{value.X} {value.Y} {value.Z}`
	end,
	["Color3"] = function(value)
		return `{value.R} {value.G} {value.B}`
	end
}

local fromString = {
	["Vector3"] = function(text: string): Vector3
		local split = text:split(" ")
		return Vector3.new(split[1] or 0, split[2] or 0, split[3] or 0)
	end,
	["Color3"] = function(text: string): Color3
		local split = text:split(" ")
		return Color3.new(split[1] or 0, split[2] or 0, split[3] or 0)
	end
}

function stringifier:stringify(value: any): unknown
	local callback = toString[typeof(value)]
	assert(callback, "can't convert to string")
	
	return callback(value)
end

function stringifier:unstringify(text: string, kind: string): unknown
	local callback = fromString[kind]
	assert(callback, "can't convert to value")
	
	return callback(text)
end

return stringifier