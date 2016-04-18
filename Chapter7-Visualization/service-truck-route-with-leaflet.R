library(leaflet)
library(utils)
library(magrittr)
library(raster)
#Importing CSV file with coordinates
out <- read.csv("./Chapter7-Visualization/Ch7_bike_kiosk_locations (1).csv",header=TRUE)
head(out)
#Generating a preliminary map to test
leaflet() %>% addTiles()
#Creating the map with polylines
map <- leaflet() %>% 
  addTiles() %>%
  addCircles(data=out, lat = ~latitude, lng = ~longitude) %>%
  addPolylines(data = out, lng = ~longitude, lat = ~latitude,group = "Line")
#Adding layer control
map <- addLayersControl(map, 
                        overlayGroups = c("Line"),
                        options = layersControlOptions(collapsed = TRUE)
)
map
