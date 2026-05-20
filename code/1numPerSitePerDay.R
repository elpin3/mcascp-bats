# Created 05/16/2026
# Anneliese Pinnell

library(tidyverse)
library(beepr)

# Group by site
batData <- read.csv("data/bats/allTogether.csv") |>
  filter(AUTO.ID. != "NoID")
locationData <- read.csv("data/sites/allSiteData.csv")

batData$DATE.12 <- as.Date(batData$DATE.12, format = "%Y-%m-%d")
naDates <- batData[is.na(batData$DATE.12),]

merged <- left_join(batData, locationData, by = c("FOLDER" = "folderName"))

firstDate <- min(merged$DATE.12, na.rm = TRUE)
lastDate <- max(merged$DATE.12, na.rm = TRUE)

allSites <- unique(merged$siteName)
allDates <- c(seq(firstDate, lastDate, by = "day"))

#Replace bat names
merged$AUTO.ID.[merged$AUTO.ID. == "MYOLUC"] <- "MYO sp."
merged$AUTO.ID.[merged$AUTO.ID. == "MYOLAU"] <- "MYO sp."
merged$AUTO.ID.[merged$AUTO.ID. == "MYOSEP"] <- "MYO sp."
merged$AUTO.ID.[merged$AUTO.ID. == "MYOAUS"] <- "MYO sp."
merged$AUTO.ID.[merged$AUTO.ID. == "LASBOR"] <- "LASBOR/LASSEM"
merged$AUTO.ID.[merged$AUTO.ID. == "LASSEM"] <- "LASBOR/LASSEM"
allBats <- unique(merged$AUTO.ID.)

for (site in allSites){
  dateFrame <- data.frame("date" = c(allDates))
  latlon <- locationData |>
    filter(siteName == site) |>
    select(c("lat", "lon")) |>
    unique()
  
  for (bat in allBats){
    oneSpecies <- merged |>
      filter(siteName == site) |>
      filter(AUTO.ID. == bat) |>
      group_by(DATE.12) |>
      summarize(count = n())
    
    oneSpecies[[bat]] = oneSpecies$count
    
    oneSpecies <- oneSpecies |>
      select(-c(count))
    
    dateFrame <- left_join(dateFrame, oneSpecies, by = c("date" = "DATE.12"))
  }
  #Add location
  dateFrame$lat <- as.numeric(latlon$lat)
  dateFrame$lon <- as.numeric(latlon$lon)

  #If there is at least one detection of another species that night, set NAs to zero
  
  rowIndeces <- dateFrame |>
    mutate(row_num = row_number()) |>
    rowwise() |>
    filter(any(c_across(CORTOW:TADBRA) > 0)) |>
    pull(row_num)
  
  dateFrame[c(rowIndeces), ][is.na(dateFrame[c(rowIndeces), ])] <- 0
  
  write.csv(dateFrame, paste0("data/bats/2025BySite/", site, ".csv"), 
            fileEncoding = "UTF-8", row.names = FALSE)
}
beepr::beep(1)





