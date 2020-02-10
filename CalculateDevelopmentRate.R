
# Calculate development rate

# input: Ana (from Import.R)
# output: Ana_rates

# Load packages --------------------------------------------------------------------------------------------------- 

library(tidyverse)
library(readxl)
library(cowplot)

# Import data (leps only)------------------------------------------------------------------------------------------------------
# source("Import.R"): OPEN and run file manually

# Calculate dr ----------------------------------------------------------------------------------------------------
Ana <- Ana %>% 
  mutate(dr.naive = 1/dt)

# Issues:
# 1. With the code above, when survival is zero, dt would be NA. 
# However, dr should be 0 (no development because they died).  
# 2. There is one case with dt < 0 (less than 1 day), those cases should be rounded to 1.

fast <- filter(Ana, dt < 1)

Ana <- Ana %>% 
  mutate(dt = ifelse(dt < 1, ceiling(dt),dt))
  
# Check
# ggplot(Ana, aes(x = dt, y = dt2))+
#   geom_point()+
#   ylim(0, 4)+
#   xlim(0, 4)

# Sets to use in tests --------------------------------------------------------------------------------------------------------
# set_944 <- filter(Ana, set == 944)
# set_6 <- filter(Ana, set == 6)
# set_70 <- filter(Ana, set == 70)
# trial <- rbind(set_6, set_70, set_944)

# Calculate dr changing NA to 0 ONLY when appropriate ------------------------------------------------------------------------------

sets <- unique(Ana$set) 
rates <- tribble(~set, ~temp, ~dr)
rates2 <- tribble(~set, ~temp, ~dr)
output.table <- tibble()

for(i in seq_along(sets)) {
  
  # make a table per set and determine whether it includes dt data
  seti <- sets[i]
  table <- filter(Ana, set == seti)
  suma <- sum(table$dt, na.rm = T)
  
  # if there is dt data
  if (suma > 0){ 
    
    clement <- filter(table, dt > 0) [["temp"]] # temperatures that allow for development
    hotlim <- max(clement, na.rm = T) # max temp that permits development
    coldlim <- min(clement, na.rm = T) # min temp that permits development
    tempes <- unique(table$temp) # each temperature included in set i
    
    # evaluate each temperature of a set
    for(ii in 1:length(unique(tempes))){
      
      tempii <- tempes[ii]
      
      # if it is lower than coldlim, dr should be zero
      if (table$temp[ii] < coldlim){
        dr <- 0
      output.row <- cbind(set = seti, temp = tempii, dr = dr)
      
      # if it is higher than hotlim, dr should be zero  
      } else if (table$temp[ii] > hotlim) {
        
        dr <- 0
      output.row <- cbind(set = seti, temp = tempii, dr = dr)
      
      # in all other cases, it should be 1/dt
      } else{
        dr <- 1/table$dt[ii]
        output.row <- cbind(set = seti, temp = tempii, dr = dr)
      }
      
      output.table <- rbind(output.table, output.row)
    }
    
    # print stuff to make sure loop is working
    cat(seti, " ")
    
    
  # if there is no development time in that set, dr should be zero
    } else {
    cat("set: ", seti, "has no dt \n")
  }
  
}

rates <- output.table

Ana_rates <- left_join(Ana, rates, by = c("set","temp"))

rm(fast, output.row, output.table, rates, rates2, table)
rm(clement, coldlim, dr, hotlim, i, ii, seti, sets, suma, tempes, tempii)



