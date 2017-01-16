# Koen Veenenbos & Tim Jak
# Team JakVeenenbos
# 16-01-2017
# Geo-scripting

# Add libraries
library(sp)
library(rgdal)
library(rgeos)

# Add other scripts
source("R/down_unzip.R")
source("R/feature_buffer.R")
source("R/feature_reproject.R")

#Download and unzip the data
down_unzip("http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip", "./data/places.zip")
down_unzip("http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip", "./data/railways.zip")

# Create the features
railways = readOGR("./data", "railways")
places = readOGR("./data", "places")

#Transform the data to RD new
repro_railways = feature_reproject(railways, EPSG:28992)
repro_places = feature_reproject(places, EPSG:28992)

# Selecting all the railways with the type industrial
indust_railways = repro_railways[repro_railways$type == "industrial", ]

# Buffering the industrial railways with 1000 meters
indust_railways_buff = feature_buffer(indust_railways, 1000.0)

# Select places withing the buffer of the industrial railways
selected_places = gIntersects(indust_railways_buff, repro_places, byid=TRUE)

# Select the city and the name of the city
city = subset(repro_places, selected_places[, TRUE])
city_name = city$name
city_population = city$population

# Create a title and a population number
title = paste("Industrial railway close to", city_name) 
population = paste("The population of", city_name, "is", city_population)

# Plot the railwaybuffer, city and cityname
plot(indust_railways_buff, main=title, sub=population, axes=T)
plot(city, add=TRUE)
text(coordinates(city[,1]), as.character(city_name), cex = 1.1, col = "black", pos=4)

