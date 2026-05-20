# Created 05/15/2026
# Anneliese Pinnell
# Combine bat data

library(tidyverse)
library(dplyr)
library(tmap)
library(sf)

bats1 <- read.csv("data/bats/CPAnalysis1_id.csv") |>
  filter(`AUTO.ID.` != "Noise")
bats2 <- read.csv("data/bats/CPAnalysis2_id.csv") |>
  filter(`AUTO.ID.` != "Noise")

bats1$DATE.12 <- as.Date(bats1$DATE.12, format = "%m/%d/%Y")
bats2$DATE.12 <- as.Date(bats2$DATE.12, format = "%Y-%m-%d")

bats <- rbind(bats1, bats2)

# Already filtered so just combine
write.csv(bats, "data/bats/allTogether.csv", row.names = FALSE)
