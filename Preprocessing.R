library(raster)
library(RStoolbox)
library(mapview)

# some functions
# ... to use further function arguments, to not have write all arguments manually, so user can pass any argument - optional arguments
# write pattern & x as default arguments which are needed
grepv <- function(pattern, x, ...) grep(pattern, x, ..., value = T)

ls_dir <- paste0(getwd(), "/data/LT05_L1TP_194026_20111015_20200820_02_T1/")
ls_files <- list.files(path = ls_dir, full.names = T)
ls_files_meta <- grep(pattern = "MTL.txt", x = ls_files, value = T)

# read META data - text file
meta <- readLines(ls_files_meta)
meta_fields <- c(
  "RADIANCE_MULT_BAND",
  "RADIANCE_ADD_BAND",
  "REFLECTANCE_MULT_BAND",
  "REFLECTANCE_ADD_BAND",
  "SUN_ELEVATION",
  "EARTH_SUN_DISTANCE",
  "K1_CONSTANT_BAND",
  "K2_CONSTANT_BAND"
  #"SUN_AZIMUTH"
)

# extract meta values
meta_vals <- lapply(meta_fields, function(field) {
  # iterate through meta_fields
  meta_lines <- grepv(field, meta)

  vals <- lapply(meta_lines, function(line) strsplit(line, " = ")[[1]][2])
  
  names(vals) <- sapply(meta_lines, function(line) {
    gsub(" ", "", strsplit(line, " = ")[[1]][1])
  })
  return(vals)
})


# convert to numeric and keep names
meta_vals <- unlist(meta_vals)
meta_attr <- attributes(meta_vals)
meta_vals <- as.numeric(meta_vals)
attributes(meta_vals) <- meta_attr

# calculate additional values
meta_vals <- c(meta_vals, c("SUN_ZENITH" = 90 - meta_vals[["SUN_ELEVATION"]]))

# band files
#ls_files_bands <- grepv(pattern = "[B]{1}[1-7]{1}.TIF", ls_files)
ls_files_bands <- list.files(path = ls_dir, pattern = glob2rx("*_B*.TIF"), full.names = T)
ls_dn <- stack(ls_files_bands)

dataType(ls_dn) # unsigned integer, 8 bit
#viewRGB(ls_dn[[c(1:3)]], r = 3, g = 2, b = 1)


#### Pre-processing ####

# conversion to TOA radiance
# from usgs landsat coversion
# Lλ= ML * Qcal + AL
ls_toa_rad <- stack(lapply(1:nlayers(ls_dn), function(band) {
  meta_vals[[paste0("RADIANCE_MULT_BAND_", band)]] * 
    ls_dn[[band]] + 
    meta_vals[[paste0("RADIANCE_ADD_BAND_", band)]]
}))

#viewRGB(ls_toa_rad[[c(1:3)]], r = 3, g = 2, b = 1)


# conversion to TOA planetary reflectance
# ρλ′= Mρ * Qcal + Aρ
ls_toa_refl_planet <- stack(lapply(1:nlayers(ls_dn)[-6], function(band) {
  (meta_vals[[paste0("REFLECTANCE_MULT_BAND_", band)]] * 
    ls_dn[[band]]) + 
    meta_vals[[paste0("REFLECTANCE_ADD_BAND_", band)]]
}))


# directional TOA reflectance (sun angle corrected)
# ρλ=ρλ′/cos(θSZ)=ρλ′/sin(θSE)
ls_toa_refl <- stack(lapply(1:nlayers(ls_toa_refl_planet), function(band) {
  ls_toa_refl_planet[[band]] / sin(meta_vals[["SUN_ELEVATION"]] * pi/180) # convert from degree to radiant
}))

viewRGB(ls_toa_refl[[1:3]], r = 3, g = 2, b = 1)



#### Homework ####
# topographic correction - Landsat
strm <- raster("data/SRTM_LT05_L1TP_194026_resampled/SRTM_LT05_L1TP_194026_resampled.tif")

# units (m) missing in projection of metadata?
meta2011 <- readMeta("data/LT05_L1TP_194026_20111015_20200820_02_T1/LT05_L1TP_194026_20111015_20200820_02_T1_MTL.txt")

# STRM already resamped to landsat data
# strm - 30m
# landsat - 30m

# topCor needs solar angles of scene (in meta file)
ls_toa_refl_ilu <- topCor(ls_toa_refl, dem = strm, metaData = meta2011, method = "C")


