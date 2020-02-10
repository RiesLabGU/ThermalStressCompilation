# 1. Calculate some basic summary statistics 
# 2. Create a subset of data with both survival and development time

# Import data
# source("Import.R"): OPEN and run file manually
 source("CalculateDevelopmentRate.R")
 
# 1. Calculate some basic summary statistics --------------------------------------------------
 
# Number of families represented
length(unique(Ana_rates$family)) # 23
 
# Number of sets within each family
# Number of sets measuring each lifestage* 

# Potentially use this as the dataset for some of our initial analyses 

# 2. Data with both survival and development rate data -----------------------------------------------------
interval_sets <- Ana_rates %>% 
  group_by(set) %>% 
  mutate(dr_sum = sum(dr), 
         n_temps = length(unique(temp)), 
         validcount = sum(!is.na(dt)), 
         validcount_s = sum(!is.na(survival))) %>% 
  filter(n_temps > 3, dr_sum > 0, validcount > 3, validcount_s > 3)

interval_set_list <- unique(interval_sets$set) 

interval <- Ana_rates %>% filter(set %in% interval_set_list)
length(unique(interval$set)) # 240
length(unique(interval$sp)) # 57
length(unique(interval$lifestage)) # 21
main_stages <- Ana_rates %>% 
  filter(lifestage == "egg"|lifestage == "larva"|lifestage == "pupa")
main_stages_list <- unique(main_stages$lifestage)
inter <- interval %>% filter(lifestage %in% main_stages_list) 
inter$lifestage <- factor(inter$lifestage)
length(unique(inter$set)) # 137
length(unique(inter$sp)) # 51
length(unique(inter$lifestage)) # 3
