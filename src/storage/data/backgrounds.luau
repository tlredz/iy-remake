-- the images the custom background has downloaded: each URL is linked to the file its image is in, in the IY folder.
-- Read and written with getEntry / setEntry (a URL has dots, which getValue would cut)
return require("../fileSystem").new("storage/backgrounds")
