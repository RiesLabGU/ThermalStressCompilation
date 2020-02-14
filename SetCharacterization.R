# Determine which datasets contain high enough temperatures to see a 
# decline in survival / increase in development time
# This will help us determine what sorts of curves we should be fitting later on
# This could be mechanistically achieved by seeing if survival is highest 
# (or development time is lowest) at the last temperature measured for each set
# In those datasets that do include high temperatures, identify whether survival 
# rate starts dropping before development time starts increasing
# We're not sure development time will ever start increasing 
# - the organisms might just die 

# Functions
# Helper code to make functions, to be deleted later:
# packages
library(tidyverse)
library(readxl)

# Mariana's desktop
Data <- read_xlsx("/Users/marianaabarcazama/Desktop/Projects/ThermalPerformance/PhysiologyDatabaseVersion5.xlsx", 
                  sheet = "T3", na = c("NA", "")) 

Data
names(Data)

# Discard non-leps
unique(Data$status)
Ana <- Data[Data$status != "parasitoid",]
rm(Data)

# convert character to factor
Ana <- Ana %>%
  mutate_if(is.character, factor)
source("CalculateDevelopmentRate.R")
# Sets for troubleshooting -----------------------------------------------------------------------------------------------------
set_944 <- filter(Ana_rates, set == 944)
set_6 <- filter(Ana_rates, set == 6)
set_70 <- filter(Ana_rates, set == 70)
trial <- rbind(set_6, set_70, set_944)
# rm(set_70, set_944, trial)

# is rise?

is_rise <- 

t <- set_6$temp
p <- set_6$dt
table <- set_944
response <- "dr"
is.rise <- function(table, response){
  ta <- select(table, temp, response)
  
  p.large <- max(ta[,2])
  t.max <- max(ta[,1])
  t.large <- filter(ta, ta[,2] == p.large)[["temp"]]
  colds <- filter(ta, ta[,1] < t.large)
  hots <- filter(ta, temp > t.large)
  opts <- filter(ta, ta[,2] == p.large)
  
  output <- tibble(just.rise =  t.max == t.large, 
                   ntemp = nrow(ta),
                   colds = nrow(colds), 
                   hots = nrow(hots), 
                   opts = nrow(opts))
output  
}

is.rise(set_6, "dt")
is.rise(set_70, "dt")
is.rise(set_944, "dt")

## Nest data 
nested <- interval_sets %>% 
  group_by(set) %>% 
  nest() %>% 
  mutate(ntemps = nrow())
