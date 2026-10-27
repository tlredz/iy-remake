-- src/framework/config/ui/background.luau
-- The custom background of the window (Settings > Edit Theme). See ui/services/backgroundService.
return {
	-- settings keys (saved in storage/data/settings)
	keys = {
		url = "background.url",         -- the URL of the image that is shown
		file = "background.file",       -- the file of that image, kept by earlier versions (moved to storage/data/backgrounds)
		opacity = "background.opacity", -- from 0 (not shown) to 1
	},

	-- the folder in the IY folder that holds the images
	folder = "background",

	-- the file types an image is kept with, by the extension of its URL. Any other one is kept as png
	extensions = {
		png = "png",
		jpg = "jpg",
		jpeg = "jpg",
	},
	defaultExtension = "png",

	defaultOpacity = 0.5,

	-- seconds a download can take before the window says it is taking a long time
	slowSeconds = 10,
}
