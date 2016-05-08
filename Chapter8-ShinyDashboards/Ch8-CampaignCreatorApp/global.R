# campaign-creator-app/global.R

# default strings to characters to 
# avoid potential factor-related issues
options(stringsAsFactors = FALSE)

# load all packages used by the shiny app here in a central location
# suppressing warnings and messages are simply for convenience

# shiny package contains core functions for the app
suppressWarnings(suppressPackageStartupMessages(library(shiny)))

# shinysky package contains an easy to implement progress wheel
# so that users can be alerted when the app is running a calculation
# and need to wait for it to finish before proceeding
suppressWarnings(suppressPackageStartupMessages(library(shinysky)))

# DT package provides an interface to the jQuery Plug-in DataTables,
# which is a feature-rich, interactive framework for displaying tables
# inside web applications
suppressWarnings(suppressPackageStartupMessages(library(DT)))

# dplyr package contains easy to use functions for manipulating
# data, which is a common task inside Shiny apps so that elements
# render properly
suppressWarnings(suppressPackageStartupMessages(library(dplyr)))

# ggplot2 package for creating graphics
suppressWarnings(suppressPackageStartupMessages(library(ggplot2)))

# scales package for formatting the ggplot graphics
suppressWarnings(suppressPackageStartupMessages(library(scales)))

# dendextend package for creating a dendrogram plot
# that has more features than base plotting
suppressWarnings(suppressPackageStartupMessages(library(dendextend)))

# RColorBrewer for creating a length 10 color scale
# to overwrite the default coloring of the dendextend package
suppressWarnings(suppressPackageStartupMessages(library(RColorBrewer)))

dendrogram_color_scheme <- c(head(brewer.pal(8, 'Set1'), 2), brewer.pal(8, "Dark2"))
