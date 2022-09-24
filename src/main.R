# This program objective is to extract markov transition matrices from MODIS 
# database to view the changes of LULC over the years. The input required are
# MODIS land cover database and boundary area in shapefile format (.shp).

# Clean the environment
rm(list = ls())

# Load the required libraries
library(terra)
library(tidyverse)

# Load source scripts
source("./Load_reproject_crop_MODIS.R")
source("./Extract_reclassify_rasters.R")

# Paths and inputs
modis_database_path = "../data/MCD12Q1/"
dataset_selected = "LC_Type1"
bounding_shapefile_path = "../data/example_bound/example_shapefile.shp"
reclass_table_path = "../data/reclassification_table.csv"
reclass_order_path = "../data/classification_factor_order.csv"

# Load reproject and crop MODIS
modis_cropped_rasters = Load_reproject_crop_MODIS(modis_database_path,
                                                  dataset_selected,
                                                  bounding_shapefile_path)

# Extract and reclassify rasters into one reclassified table
reclassified_table = Extract_reclassify_rasters(modis_cropped_rasters,
                                                reclass_table_path,
                                                reclass_order_path)
