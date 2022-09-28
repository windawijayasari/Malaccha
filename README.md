# Markov-land-cover-extraction

# Description
This tool has been designed to make probability transition matrix in a simple and automatic way. Some inputs need to prepare before run the software are MODIS .hdf database, dataset string (type of the MODIS product), boundary shapefile (.shp), reclassification table (.csv), and classes order (.csv). The flowchart for the presented software is presented below.

 ![image](https://user-images.githubusercontent.com/16074044/192727445-5177eb14-da33-415a-98d6-dd61dc15db3b.png)

The software is separated into six script files, i.e., the main script and five other scripts that constitute the five subprocesses in the entire process: MODIS dataset loader, MODIS rasters extraction and reclassification, annual transition matrix calculator function, the dataset to transition matrices extractor, and average transition matrix calculator.

# USER MANUAL
To run the software example case study, open **markov_lulc.Rproj**  in the folder src then run **main.R.** Then, to use users case or files, the users can change the associated paths.

# Required packages
The code has been written in R. You can easly install the R studio and open the file .Rproj from the folder to set the environment.
The R studio download link; https://www.rstudio.com/products/rstudio/
Then  install the following packages by running:
- terra
- tidyverse
- MASS

First of all you have to create some folders (into the “code” folder):
- Data folder: # data
  - example_bound: contains shapefile
  - MCD12Q1 : contains raw MODIS file .hdf
  -	classification_factor_order.csv
  -	reclassification_table.csv
-	Code folder: # src

The MODIS file can be change depends on the study area as well as the boundary area.
To check if the MODIS data clipped properly
plot(modis_cropped_rasters[[1]]) 

![image](https://user-images.githubusercontent.com/16074044/192771316-69465a4c-da2b-452d-abba-18915896d315.png)

Figure 2 Example MODIS “LC_Type1” dataset (a) loaded and reprojected into example boundary’s coordinate system, (b) MODIS dataset after reprojection and cropping using the example boundary

The reclassification _table.csv also can made as needed.

Table 1 Example land cover mapping reclassification supplied as an input file

|LC_index | LC_class |
|---------|----------|
|    1    | 	Forest  |
|    2    | 	Forest  |
|    4	   |  Forest  |
|    5    |	 Forest  |
|    6    |Agriculture|
|    7    |	Agriculture|
|    8    |	Forest|
|    9    |	Forest|
|   10    |	Agriculture |
|   11    |	Agriculture|
|   12    |	Agriculture|
|   13    |	Developed|
|   14    |	Agriculture|
|   15    |	NA|
|   15    |	NA|
|   15    |	NA|
|   16    |	NA|
|   17    |	NA|


Classification_factor_order.csv define how the order of such land cover categorical classifications should henceforth be shown.
After all the inputs ready, the software can run. 
The results is normalized yearly transition matrix of the MODIS data.

![image](https://user-images.githubusercontent.com/16074044/192802160-ed255e3c-f106-43ff-9196-f734cf42a78a.png)

Figure 3 Example calculation results (a) example land cover reclassified table, (b) example land cover matrix, and (c) example average transition matrix

The transition matrix can be apply to predict future land cover.
The simplest model is using Markov:

X(t+c) = X(t) * B^c 

Where t is the initial year, c is the gap year, and B is the average transition matrix from the model. 
Further, the yearly transition matrix now ready to apply to another sophisticated model.










