# Created 05/24/2026
# Anneliese Pinnell
# Purpose: conmbined area to run all code in order

# Site coordinate dataframe
source("code/0makeSiteCoords.R")
# Map site coordinates
source("code/0mapLocations.R")
# Combine both analyses together
source("code/0combineData.R")
# Calculates amount of activity per day per site
source("code/1numPerSitePerDay.R")
# starts to break down by hourly activity...kind of irrelevant
# source("code/1timesections.R")
# Makes graphs of activity per site
source("code/2makeSiteGraphs.R")