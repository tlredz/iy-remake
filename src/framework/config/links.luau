local gitCfg = require("./github")

return {
	discord = "https://discord.gg/78ZuWSq",
	github = `https://github.com/{gitCfg.owner}/{gitCfg.repository}`
}