# Created 05/24/2026
# Anneliese Pinnell
# maps locations of sites

library(tidyverse)
library(dplyr)
library(tmap)
library(sf)

# Read in site data
sites <- read.csv("data/sites/allSiteData.csv")
sites <- sites[!duplicated(sites$siteName), ]
sites$lon <- gsub("\u00a0", "", sites$lon)
sites$lon <- gsub(" ", "", sites$lon)
sites$lon <- as.numeric(sites$lon)

temp <- st_as_sf(sites, coords = c("lon", "lat"), crs = 4326)

tm_shape(temp) + 
  tm_basemap("OpenStreetMap") + 
  tm_dots()
