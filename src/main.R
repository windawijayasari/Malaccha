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

# Paths and inputs
modis_database_path = "../data/MCD12Q1/"
dataset_selected = "LC_Type1"
bounding_shapefile_path = "../data/example_bound/example_shapefile.shp"

# Load reproject and crop MODIS
modis_cropped_rasters = Load_reproject_crop_MODIS(modis_database_path,
                                                  dataset_selected,
                                                  bounding_shapefile_path)

