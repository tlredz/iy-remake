return {
	{
		action = "tpposition|tppos",
		description = "Teleports you to certain coordinates",
		args = { kind = "vector3" }
	},
	{
		action = "tweentpposition|ttppos",
		description = "Tween to coordinates (bypasses some anti cheats)",
		args = {
			{
				kind = "vector3"
			},
			{
				kind = "number",
				name = "tween speed",
				optional = true
			}
		}
	},
	{
		action = "offset",
		description = "Offsets you by certain coordinates",
		args = { kind = "vector3" }
	},
	{
		action = "tweenoffset|toffset",
		description = "Tween offset (bypasses some anti cheats)",
		args = {
			{
				kind = "vector3"
			},
			{
				kind = "number",
				name = "tween speed",
				optional = true
			}
		}
	},
	{
		action = "thru",
		description = "Teleports you [num] studs ahead of where your character is facing",
		args = { kind = "number" }
	}
}