#Use this script when creating a hex bin map of bird sightings to generate an alphabetical list of all bird species located in each hexagon.
library(tidyverse)
setwd("~/Documents/Bird Project")
library(sf)
bird_grid <- st_read("~/Documents/Bird Project/data/processed/hex_join_2020.shp")

birds <- st_drop_geometry(bird_grid) |> 
  group_by(GRID_ID) |> 
  summarize(birds = paste(sort(unique(COMMON_NAM)), collapse = ', '))

write_csv(birds,"~/Documents/Bird Project/data/processed/birds_grid_2020.csv")

