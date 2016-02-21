# Copyright 2016 Packt Publishing

# Introduction to R for Business Intelligence
# Chapter 2 - Data Cleaning

#
# Summarizing your data for inspection
bike <- read.csv("./data/Ch2_raw_bikeshare_data.csv",
                 stringsAsFactors = FALSE)
str(bike)

#
# Finding and fixing missing data values
table(is.na(bike))

library(stringr)
str_detect(bike, "NA")
table(is.na(bike$sources))

bad_data <- str_subset(bike$humidity, "[a-z A-Z]")
location <- str_detect(bike$humidity, bad_data)
bike[location, ]

bike$humidity <- str_replace_all(bike$humidity, bad_data, "61")
bike[location, ]

#
#  Converting inputs to data types suited for analysis
bike$humidity <- as.numeric(bike$humidity)

categorical <- c("season", "holiday", "workingday", "weather")
bike[ ,categorical] <- lapply(bike[ ,categorical], factor)

library(lubridate)
bike$datetime <- mdy_hm(bike$datetime)
str(bike)

#
## Adapting string variables to a standard
unique(bike$sources)

bike$sources <- tolower(bike$sources)
bike$sources <- str_trim(bike$sources)
na_loc <- is.na(bike$sources)
bike$sources[na_loc] <- "unknown"
unique(bike$sources)

library(DataCombine)
web_sites <- "(www.[a-z]*.[a-z]*)"
current <- unique(str_subset(bike$sources, web_sites))
replace <- rep("web", length(current))
replacements <- data.frame(from = current, to = replace)
bike <- FindReplace(data = bike, Var = "sources", replacements,
                    from = "from", to = "to", exact = FALSE)
unique(bike$sources)

bike$sources <- as.factor(bike$sources)
str(bike)
