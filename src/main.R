# This program objective is to extract markov transition matrices from MODIS 
# database to view the changes of LULC over the years. The input required are
# MODIS land cover database and boundary area in shapefile format (.shp).

# Clean the environment
rm(list = ls())

# Load the required libraries
library(terra)
library(tidyverse)
library(MASS)

# Define paths and inputs
modis_database_path = "../data/MCD12Q1/"
dataset_selected = "LC_Type1"
bounding_shapefile_path = "../data/example_bound/example_shapefile.shp"
reclass_table_path = "../data/reclassification_table.csv"
reclass_order_path = "../data/classification_factor_order.csv"

# Load source scripts
source("./Load_reproject_crop_MODIS.R")
source("./Extract_reclassify_rasters.R")
source("./Get_matrix_by_year.R")
source("./Calculate_transition_matrices.R")
source("./Calculate_average_transition_matrix.R")

# Load reproject and crop MODIS
modis_cropped_rasters = 
  Load_reproject_crop_MODIS(modis_database_path,
                            dataset_selected,
                            bounding_shapefile_path)

# Extract and reclassify rasters into one reclassified table
reclassified_table = 
  Extract_reclassify_rasters(modis_cropped_rasters,
                             reclass_table_path,
                             reclass_order_path)

# Get list of years
years = reclassified_table$Year %>% unique() %>% sort()

# Get all LC matrices
all_lc_matrices = 
  lapply(years, 
         function(year){
           Get_matrix_by_year(reclassified_table, year)})

# Calculate all transition matrices
all_transition_matrices = 
  mapply(
    function(a, b){
      Calculate_transition_matrix(reclassified_table, a, b)},
    years[1:(length(years)-1)], 
    years[2:length(years)], 
    SIMPLIFY = FALSE)

# Calculate average transition matrix
average_transition_matrix = 
  Calculate_average_transition_matrix(all_transition_matrices)
