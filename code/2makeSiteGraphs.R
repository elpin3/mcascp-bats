# Created 05/17/2026
# Anneliese Pinnell

library(tidyverse)
library(ggplot2)
library(pals)
library(ggthemes)

files <- list.files(path = "data/bats/2025BySite/")
siteNames <- sub(".csv", "", files)

for(i in seq(length(files))){
  oneSite <- read.csv(paste0("data/bats/2025BySite/", files[i])) |>
    pivot_longer(
      cols = -c(date),
      names_to = "species",
      values_to = "counts"
    )
  
  p <- ggplot(oneSite, aes(x = date, y = counts, 
                           color = species)) +
    geom_point(size = 3) + 
    #geom_line() +
    scale_color_tableau(palette = "Classic 10") +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    labs(title = siteNames[i])
  
  png(filename = paste0("figures/sites/", siteNames[i], ".png"),
      width = 20, height = 6, units = "in", res = 300)
  
  print(p)
  dev.off()
}


