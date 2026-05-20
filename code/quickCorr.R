# Are certain sites correlated
library(corrplot)
library(tidyverse)

site1 <- read.csv("data/bats/2025BySite/BumpyRoad.csv")
site2 <- read.csv("data/bats/2025BySite/BurnPond.csv")
