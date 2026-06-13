return {
	action = "volume|vol",
	description = "Adjusts your game volume on a scale of 0 to 10",
	args = {
		kind = "number",
		clamp = {0, 10},
		floor = true
	}
}