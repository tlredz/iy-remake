return {
	-- Search order when no extension is given, or the requested file does not exist.
	extensions = { ".luau", ".lua", ".txt", ".iy" },
	-- Only tables with the classic IY Commands/Function structure are translated.
	translateClassic = true,
	-- Command list section shown below the built-in plugin management commands.
	sectionName = "plugin commands",
}
