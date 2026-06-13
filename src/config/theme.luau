local isTesting = require("./isTesting")

return {
	defaultTheme = isTesting and "Dark" or "Classic"
}