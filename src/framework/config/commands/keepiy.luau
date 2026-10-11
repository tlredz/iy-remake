-- /src/framework/config/commands/keepiy.luau

return {
	-- settings key of the flag. The keepiy command and the UI's "keep interface" option share it
	settingKey = "interface.keepIY",

	-- the bundle that runs again after a teleport, published as a GitHub release asset
	bundleName = "compiled.luau",

	-- used first when it exists in the executor workspace (local development), before the release
	localBundlePath = "iy-remake/compiled.luau",
}
