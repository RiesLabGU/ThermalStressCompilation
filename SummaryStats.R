# 1. Calculate some basic summary statistics 
# 2. Create a subset of data with both survival and development time

# Import data
# source("Import.R"): OPEN and run file manually
 source("CalculateDevelopmentRate.R")
 
# 1. Calculate some basic summary statistics --------------------------------------------------
 
# Number of families represented
length(unique(Ana_rates$family)) # 23
 
# Number of sets within each family
family_sets <-  Ana_rates %>%
  select(set, family) %>% 
  distinct() %>% 
  group_by(family) %>% 
  summarise(sets = length(unique(set))) %>% 
  arrange(sets)

ggplot(family_sets, aes(x = reorder(family, - sets), y = sets)) +
  geom_col()+
  geom_hline(yintercept = 50)+
  geom_hline(yintercept = 25, linetype = 2)+
  theme_cowplot()+
  xlab("Family")+
  coord_flip()
# Number of species per family
species <-  Ana_rates %>%
  select(family, sp) %>% 
  distinct() %>% 
  group_by(family) %>% 
  summarise(sp_count = length(unique(sp))) %>% 
  arrange(sp_count)

ggplot(species, aes(x = reorder(family, - sp_count), y = sp_count)) +
  geom_col()+
  geom_hline(yintercept = 10, linetype = 2)+
  geom_hline(yintercept = 5, linetype = 1)+
  theme_cowplot()+
  xlab("Family")+
  ylab("Species")+
  coord_flip()

# Number of sets measuring each lifestage
lifestage_sets <-  Ana_rates %>%
  select(set, lifestage) %>% 
  distinct() %>% 
  group_by(lifestage) %>% 
  summarise(sets = length(unique(set))) %>% 
  arrange(sets)

ggplot(lifestage_sets, aes(x = reorder(lifestage,  sets), y = sets)) +
  geom_col()+
  geom_hline(yintercept = 50)+
  geom_hline(yintercept = 25, linetype = 2)+
  theme_cowplot()+
  xlab("Family")+
 
  coord_flip()

lifestage_sets_2 <-  Ana_rates %>%
  select(set, lifestage) %>% 
  distinct() %>% 
  group_by(lifestage) %>% 
  summarise(sets = length(unique(set))) %>% 
  arrange(sets) %>% 
  filter(sets > 4)
ggplot(lifestage_sets_2, aes(x = reorder(lifestage,  sets), y = sets)) +
  geom_col()+
  geom_hline(yintercept = 50)+
  geom_hline(yintercept = 25, linetype = 2)+
  theme_cowplot()+
  xlab("Family")+
  
  coord_flip()
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
