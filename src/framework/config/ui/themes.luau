-- src/framework/config/ui/themes.luau
-- The primary colors a theme can be given (Settings > Edit Theme, on the row of the theme in use). Each theme keeps
-- its own choice, saved in storage/data/settings as themePrimary.<theme name>, so a theme does not change the others.
--
-- Each option: key (what is saved), color (nil for the theme's own primary color, which is what the theme is made with).
-- A primary color also sets OnPrimary: the same color, darkened by `darken` (0 is the color, 1 is black).

return {
	defaultKey = "theme",
	darken = 0.31,

	options = {
		{ key = "theme" },
		{ key = "darkGreen", color = Color3.fromRGB(34, 110, 62) },
		{ key = "red", color = Color3.fromRGB(214, 58, 58) },
	},
}
