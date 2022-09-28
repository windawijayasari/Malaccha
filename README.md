# Markov-land-cover-extraction

# Description
This tool has been designed to make probability transition matrix in a simple and automatic way. Some inputs need to prepare before run the software are MODIS .hdf database, dataset string (type of the MODIS product), boundary shapefile (.shp), reclassification table (.csv), and classes order (.csv). The flowchart for the presented software is presented below.

 ![image](https://user-images.githubusercontent.com/16074044/192727445-5177eb14-da33-415a-98d6-dd61dc15db3b.png)

The software is separated into six script files, i.e., the main script and five other scripts that constitute the five subprocesses in the entire process: MODIS dataset loader, MODIS rasters extraction and reclassification, annual transition matrix calculator function, the dataset to transition matrices extractor, and average transition matrix calculator.

# USER MANUAL
To use the software run markov_lulc.Rproj

# Required packages
The code has been written in R. You can easly install the R studio and open the file .Rproj from the folder to set the environment.
The R studio download link; https://www.rstudio.com/products/rstudio/
Then  install the following packages by running:
•	Terra
•	Tidyverse
•	MASS

# Inputs to prepare







