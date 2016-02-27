# Copyright 2016 Packt Publishing

# Introduction to R for Business Intelligence
# Chapter 3 - Exploratory Data Analysis

#
# Summary Statistics
bike <- read.csv("./data/Ch3_bike_sharing_data.csv",
                 stringsAsFactors = TRUE)
str(bike)

bike$season <- factor(bike$season, ordered = TRUE,
                      levels = c("spring","summer",
                                 "fall","winter"))
bike$weather <- factor(bike$weather, ordered = TRUE,
                       levels = c("clr_part_cloud",
                                  "mist_cloudy",
                                  "lt_rain_snow",
                                 "hvy_rain_snow"))

library(lubridate)
bike$datetime <- mdy_hm(bike$datetime)
str(bike)

head(bike)
head(bike, 12)
tail(bike)

summary(bike)

library(psych)
describe(bike)

#
# Univariate data analysis
table(bike$sources)
plot(bike$seasons)
hist(bike$temp)

#
# Bivariate Analysis
table(bike$holiday, bike$workingday)
table(bike$season, bike$weather)

crosstab <- xtab(~ season + weather, data = bike)
crosstab
addmargins(crosstab)

prop.table(crosstab, 1)
prop.table(crosstab, 2)
addmargins(prop.table(crosstab))

plot(bike$humidity ~ bike$temp)
#
# More than two variables

plot(bike$atemp ~ bike$temp) #strong + correlation
plot(bike$atemp ~ bike$windspeed) #no correlation

plot(bike$humidity ~ bike$windspeed) #weak - correlation
plot(bike$humidity ~ bike$temp) #weak - correlation

plot(bike$count ~ bike$humidity)
