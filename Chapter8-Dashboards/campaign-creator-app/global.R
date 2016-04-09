# campaign-creator-app/global.R

# default strings to characters to 
# avoid potential factor-related issues
options(stringsAsFactors=FALSE)

# load all packages used by the shiny app here in a central location
# suppressing warnings and messages are simply for convenience
suppressWarnings(suppressPackageStartupMessages(library(shiny)))
suppressWarnings(suppressPackageStartupMessages(library(shinysky)))
suppressWarnings(suppressPackageStartupMessages(library(DT)))
