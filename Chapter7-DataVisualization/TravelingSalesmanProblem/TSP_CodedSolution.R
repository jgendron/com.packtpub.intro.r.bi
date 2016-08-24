# Copyright 2016 Packt Publishing

# Introduction to R for Business Intelligence
# Chapter 7, Addendum - Maintenance Crew Problem

message("Introduction to R for Business Intelligence
        Chapter 7 - Visualizing the Data’s Story
        Copyright (2016) Packt Publishing \n
        Let's explore solving for service truck optimization using TSP")

library(TSP)
library(Imap)

# Load 2 custom functions for deriving the traveling salesman solution
# 1) ReplaceLowerOrUpperTriangle
# 2) GeoDistanceInMetresMatrix

ReplaceLowerOrUpperTriangle <- function(m, triangle.to.replace) {
     # If triangle.to.replace = "lower", replaces the lower triangle of a
     # square matrix with its upper triangle.
     # If triangle.to.replace = "upper", replaces the upper triangle of a
     # square matrix with its lower triangle.
     
     if (nrow(m) != ncol(m)) stop("Supplied matrix must be square.")
     if (tolower(triangle.to.replace) == "lower") tri <- lower.tri(m)
     else if (tolower(triangle.to.replace) == "upper") tri <- upper.tri(m)
     else stop("triangle.to.replace must be set to 'lower' or 'upper'.")
     
     m[tri] <- t(m)[tri]
     return(m)
}

GeoDistanceInMetresMatrix <- function(df.geopoints) {
     # Returns a matrix (M) of distances between geographic points.
     # M[i,j] = M[j,i] = Distance between 
     #    (df.geopoints$lat[i], df.geopoints$lon[i]) and
     #    (df.geopoints$lat[j], df.geopoints$lon[j])
     # The row and column names are given by df.geopoints$name.
     
     GeoDistanceInMetres <- function(g1, g2) {
          # Returns a vector of distances. 
          # (But if g1$index > g2$index, returns zero.)
          # The 1st value in the returned vector is the distance between
          # g1[[1]] and g2[[1]].
          # The 2nd value in the returned vector is the distance between
          # g1[[2]] and g2[[2]]. Etc.
          # Each g1[[x]] or g2[[x]] must be a list with named elements
          # "index", "latitude" and "longitude". For example:
          # g1 <- list(list("index" = 1, "latitude" = 12.1, "longitude" = 10.1),
          #            list("index" = 3, "latitude" = 12.1, "longitude" = 13.2))
          
          DistM <- function(g1, g2) {
               require("Imap")
               return(ifelse(g1$index > g2$index, 0,
                             gdist(lat.1 = g1$latitude,
                                   lon.1 = g1$longitude,
                                   lat.2 = g2$latitude,
                                   lon.2 = g2$longitude, units = "m")))
          }
          return(mapply(DistM, g1, g2))
     }
     n.geopoints <- nrow(df.geopoints)
     
     # The index column is used to ensure we only do calculations for the
     # upper triangle of points
     
     df.geopoints$index <- 1:n.geopoints
     
     # Create a list of lists
     list.geopoints <- by(df.geopoints[, c("index", "latitude",
                                           "longitude")], 1:n.geopoints,
                          function(x){return(list(x))})
     # Get a matrix of distances (in metres)
     
     mat.distances <- ReplaceLowerOrUpperTriangle(outer(list.geopoints,
                                                        list.geopoints,
                                                        GeoDistanceInMetres),
                                                  "lower")
     # Set the row and column names
     rownames(mat.distances) <- df.geopoints$name
     colnames(mat.distances) <- df.geopoints$name
     return(mat.distances)
}

kiosks <- read.csv("./data/Ch7_bike_kiosk_locations.csv",header = TRUE)

kiosks$popup <- paste0("Kiosk Location #", seq(1, nrow(kiosks)))

dist_matrix <- GeoDistanceInMetresMatrix(kiosks)
tsp <- TSP(dist_matrix)
tour <- solve_TSP(tsp)
shrtpath = kiosks[cut_tour(tour, "1"), ]
write.csv(shrtpath, "./data/Ch7_optimal_maint_route.csv", row.names = FALSE)
