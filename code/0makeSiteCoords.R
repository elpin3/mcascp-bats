# Created 05/24/2026
# Anneliese Pinnell
# Corresponds all folders and sites to lat lon coordinates
# Exports data/sites/allSiteData.csv

library(tidyverse)
library(dplyr)
library(tmap)
library(sf)
library(beepr)

# Check format on mainfiles
bats1 <- read.csv("data/bats/CPAnalysis1_id.csv", fileEncoding = "UTF-8")
bats2 <- read.csv("data/bats/CPAnalysis2_id.csv", fileEncoding = "UTF-8")
siteNames <- c(unique(bats1$FOLDER), unique(bats2$FOLDER))

#Dataframe for associating sites with folders 
siteFolders <- data.frame("siteName" = c(), 
                            "folderName" = c())
for (folder in siteNames){
  cleanedName <- unlist(strsplit(unlist(strsplit(folder, "_", fixed = FALSE))[2],
                          '\\\\', fixed = FALSE))[1]
  lineToAdd <- data.frame("siteName" = c(cleanedName),
                          "folderName" = c(folder))
  siteFolders <- rbind(siteFolders, lineToAdd)
}

# Adding coords to site folders
# Read in site coords
sites <- read.csv("data/sites/2025SiteCoords.csv",  fileEncoding = "UTF-8") |>
  separate_wider_delim("Coordinates.", delim = ",", names = c("lat", "lon"))
sites$Site. <- gsub(" ", "", sites$Site.)
sites$Site. <- gsub("’", "", sites$Site.)
sites$Site. <- gsub("'", "", sites$Site.)
# Gets rid of freaky trailing white space
sites$Site. <- gsub("\u00a0", "", sites$Site.)

siteFolders$siteName <- gsub("'", "", siteFolders$siteName)

joined <- left_join(siteFolders, sites, by = c("siteName" = "Site."))

#Gets rid of weird characters
joined$lon <- str_replace_all(joined$lon, "[^[:alnum:]_.]", "")
joined$Site.Number. <- str_replace_all(joined$Site.Number., "[^[:alnum:]_.]", "")
joined$Environment. <- str_replace_all(joined$Environment., "[^[:alnum:]_.]", "")
joined$Water.Present. <- str_replace_all(joined$Water.Present., "[^[:alnum:]_.]", "")

write_csv(joined, "data/sites/allSiteData.csv")

beepr::beep(1)