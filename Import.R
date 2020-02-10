# Thermal biology of lepidoptera
# Mariana Abarca

# Import data table from excel file, keep studies lepidopterans only (discard parasitoids)

# packages
library(tidyverse)
library(readxl)

# Mariana's desktop
Data <- read_xlsx("/Users/marianaabarcazama/Desktop/Projects/ThermalPerformance/PhysiologyDatabaseVersion5.xlsx", 
                  sheet = "T3", na = c("NA", "")) 

# Mariana's laptop
Data <- read_xlsx("/Users/mar/Desktop/Projects/ThermalPerformance/PhysiologyDatabaseVersion5.xlsx", 
                  sheet = "T3", na = c("NA", "")) 
# Anna ()
Data <- read_xlsx("InsertYourPathHere/PhysiologyDatabaseVersion5.xlsx", 
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
