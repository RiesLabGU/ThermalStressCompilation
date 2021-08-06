# Map set locations --------------------------------------------------------------------------------
# Supplement 1
# Grey for any data
# Black for dt 
# Red for survival
# Dark grey for variation (SD/SE in dt)
# Dark green for survival only
# Goldenrod for survival & DT
# Dark orange for survival, DT and variation

# Load functions & packages --------------------------------------------------------------------------------------------------- 
source("/Users/marianaabarcazama/Desktop/Projects/MyFunctions.R")
# source("/Users/mar/Desktop/Projects/MyFunctions.R")

library(tidyverse)
library(readxl)
library(cowplot)
# library(MASS)
library(car)
library(broom)
library(maps)
# Import data (leps only)------------------------------------------------------------------------------------------------------

points <- read_xlsx("/Users/marianaabarcazama/Desktop/Projects/ThermalPerformance/PhysiologyDatabaseVersion5.xlsx", 
                  sheet = "WorkingTable", na = c("NA", "")) 
points$quality <-factor(points$quality)


world_data <- map_data("world")

ggplot() + scale_y_continuous(limits=c(-90,90), expand=c(0,0)) +
  scale_x_continuous(expand=c(0,0)) +
  theme(axis.ticks=element_blank(), axis.title=element_blank(),
        axis.text=element_blank()) +
  geom_polygon(data=world_data, mapping=aes(x=long, y=lat, group=group), fill='darkolivegreen') +
  geom_point(data = points, mapping = aes(x = lon, y = lat, group = NA), shape = 1)+
  ylab("Latitude")+
  xlab("Longitude")+
  theme_cowplot()




d <- map_data("world") %>% 
  ggplot( aes(x = long, y = lat, group = group))+
  geom_polygon(fill = "grey", col = "grey", alpha = 0.5)+
  geom_point(data = filter(points, factor(quality)  =="inferred"), mapping = aes(x = lon, y = lat, group = NA), col = "red")+
  geom_point(data = filter(points, factor(quality) !="inferred"), mapping = aes(x = lon, y = lat, group = NA), col = "black")+
  ylab("Latitude")+
  xlab("Longitude")+
  theme_cowplot()+
  theme(legend.position = "none")

d

table <- points %>% 
  select(sp, family) %>% 
  distinct()
