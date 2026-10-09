return {
	{
		action = "autoclick",
		description = "Automatically clicks your mouse with a set delay",
		args = {
			{
				kind = "number",
				name = "click delay"
			},
			{
				kind = "number",
				name = "release delay"
			}
		}
	},
	{
		action = "unautoclick|noautoclick",
		description = "Turns off autoclick"
	},
	{
		action = "autokeypress|keypress",
		description = "Automatically presses a key with a set delay",
		args = {
			{
				kind = "keycode"
			},
			{
				kind = "number",
				name = "click delay"
			},
			{
				kind = "number",
				name = "release delay"
			}
		}
	},
	{
		action = "unautokeypress|noautokeypress|unkeypress|nokeypress",
		description = "Stops autokeypress"
	}
}
