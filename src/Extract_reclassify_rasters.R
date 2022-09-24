Extract_reclassify_rasters = function(modis_cropped_rasters,
                                      reclass_table_path,
                                      reclass_order_path){
  # Extract rasters into one big table containing cell land cover class indices
  all_indices_table = lapply(modis_cropped_rasters, function(modis_raster){
    terra::as.data.frame(modis_raster, xy = TRUE) %>%
      `names<-`(c("X", "Y", "LC_index")) %>%
      as_tibble()
  }) %>%
    bind_rows(.id = "Varname") %>%
    tidyr::extract("Varname", "Year", "A(\\d+)001", convert = TRUE) %>%
    print()
  
  # Load reclassification table and reclassification factor order
  reclass_table = read.csv(reclass_table_path) %>% 
    as_tibble()
  reclass_order = read.csv(reclass_order_path) %>%
    mutate_all(.funs = as.factor) %>%
    as_tibble()
  
  # Reclassify table
  reclassified_table = all_indices_table %>%
    inner_join(reclass_table) %>%
    mutate(LC_class = factor(LC_class, levels = reclass_order$LC_class)) %>%
    print()
}
