Load_reproject_crop_MODIS = function(modis_database_path,
                                     dataset_selected = "LC_Type1", 
                                     bounding_shapefile_path){
  # Load shapefile and its CRS (coordinate system)
  bounding_shapefile = vect(bounding_shapefile_path)
  bounding_shapefile_crs = crs(bounding_shapefile)
  
  # List MODIS hdf files
  modis_hdf_files = list.files(modis_database_path, full.names = TRUE)
  
  # Perform these operations: (1) load as a raster collection, (2) select dataset,
  # (3) reproject raster into boundary's CRS, (4) crop raster, (5) mask raster
  # Although the produced raster is a cropped then masked raster, henceforth,
  # it is called cropped raster for clarifty purpose
  modis_cropped_rasters = lapply(modis_hdf_files, function(modis_file){
    modis_raster = rast(modis_file)[dataset_selected]
    modis_repojected = project(modis_raster, bounding_shapefile_crs)
    modis_cropped = crop(modis_repojected, bounding_shapefile, snap = "OUT")
    modis_masked = mask(modis_cropped, bounding_shapefile)
  }) %>%
    `names<-`(modis_hdf_files)
}
