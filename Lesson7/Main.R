#Koen Veenenbos & Tim jak team JakVeenenbos
#January 2017

#Libraries used, please download the RColorBrewer
library(raster)
library(rgeos)
library(rgdal)

#Sources included
source("./R/download.R")
source("./R/coordinates.R")
source("./R/NDVImonth.R")

#Download and unzip the data
down_unzip("https://raw.githubusercontent.com/GeoScripting-WUR/VectorRaster/gh-pages/data/MODIS.zip", "./Data/NDVI.zip")

#Create variable for the Landsat data grid and brick this dataset
LandsathPath <- list.files("Data", pattern = glob2rx("*.grd"), full.names = TRUE)
NedLandsat <- brick(LandsathPath)

#Retrieve the Municipality data
NLMunicipality <- getData("GADM", country = "NLD", level = 2)

#Make sure both files have the same coordinates
#In this case we took the coordinates of the Landsat (raster) data and reprojected the municipality data
NLMunicipality_RP <- spTransform(NLMunicipality, CRS(proj4string(NedLandsat)))

#Combine Municipality data with the Landsat data, where for each municipality the average NDVI was calculated
NDVIJan <- CalcNDVI (NedLandsat, 1, NLMunicipality_RP)
NDVIAug <- CalcNDVI (NedLandsat, 8, NLMunicipality_RP)
NDVIYear <- extract(mean(NedLandsat, na.rm=TRUE)*0.0001, NLMunicipality_RP, fun = mean, na.rm=TRUE, sp = TRUE)

#Calculate the greenest municipality
Num_Jan <- which.max(NDVIJan$January)
GreenestMun_Jan <- NDVIJan$NAME_2[[Num_Jan]]
Num_Aug <- which.max(NDVIAug$August)
GreenestMun_Aug <- NDVIAug$NAME_2[[Num_Aug]]
Num_Year <- which.max(NDVIYear$layer)
GreenestMun_Year <- NDVIYear$NAME_2[[Num_Year]]

#Calculate NDVI per province
#Retrieve the province data instead of the municipality data
NLProvince <- getData("GADM", country = "NLD", level = 1)

#Make sure both files have the same coordinates
#In this case we took the coordinates of the Landsat (raster) data and reprojected the province data
NLProvince_RP <- spTransform(NLProvince, CRS(proj4string(NedLandsat)))

#Combine Province data with the Landsat data, where for each province the average NDVI was calculated
NDVIJan_Province <- CalcNDVI (NedLandsat, 1, NLProvince_RP)

#Calculate the greenest province
Num_Jan_Province <- which.max(NDVIJan_Province$January)
GreenestProv_Jan <- NDVIJan$NAME_1[[Num_Jan_Province]]

#Plot the greenest municipality, based on the average over the year
#Unfortunately the plot won't be plotted with Source. Please use the Run button
spplot(NDVIYear, zcol = "layer", 
       main = "Average NDVI value per municipality",
       col.regions = rev(topo.colors(n=16, alpha = 0.8)),
       col = "transparent")
