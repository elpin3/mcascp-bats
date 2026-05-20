# Created 05/15/2026
# Anneliese Pinnell
# Bin time calls

library(ggplot2)
library(tidyverse)
library(lubridate)
library(dplyr)
library(patchwork)

batData <- read.csv("data/bats/allTogether.csv") |>
  filter(batData$AUTO.ID. != "NoID")

allBatNames <- unique(batData$AUTO.ID.)

allPlots <- list()
for (i in seq(length(allBatNames))) {
  tempInterest <- batData |>
    filter(AUTO.ID. == allBatNames[i])
  tempInterest$HOUR <- as.character(tempInterest$HOUR)
  
  timeSorted <- tempInterest |>
    mutate(HOUR = factor(HOUR, levels = c("16", "17", "18", "19", "20", "21", "22",
                                          "23", "24", "0", "1", "2", "3", "4", "5", "6", "7")))
  plotted <- ggplot(timeSorted, aes(x = HOUR)) +
    geom_bar() +
    labs(x = ifelse(i == 14, "Hour", " "), 
         y = ifelse(i == 7, "Number Observations", " "),
         title = allBatNames[i])
  allPlots[[allBatNames[i]]] <- plotted
}

# add hour to it
png(filename = "figures/generalActivity2025.png", width = 8, height = 7, units = "in", res = 300)
wrap_plots(allPlots, nrow = 5, ncol = 3)
dev.off()

# seperate into weekdays vs weekends
# seperate into months? or sets of two weeks

# Weekdays vs. weekends


