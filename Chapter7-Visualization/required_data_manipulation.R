#
# Data Manipulations for Bike Sharing Dataset
#
# Three variables must be manipulated each time it is read
# into R: season, weather, and datetime. 
#   
# Read in data retaining the factors
bike <- read.csv("./data/Ch7_clean_bike_sharing_data.csv",
                 stringsAsFactors = TRUE)

# season and weather: convert data type to ordered factor
bike$season <- factor(bike$season, ordered = TRUE,
                      levels = c("spring","summer",
                                 "fall","winter"))
bike$weather <- factor(bike$weather, ordered = TRUE,
                       levels = c("clr_part_cloud", 
                                  "mist_cloudy",
                                  "lt_rain_snow",
                                  "hvy_rain_snow"))

# datetime: convert strings into dates
library(lubridate)
bike$datetime <- ymd_hms(bike$datetime)
