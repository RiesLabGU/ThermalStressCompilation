# Scale development time as a fraction of the maximum development time for each set.

# Sets for troubleshooting -----------------------------------------------------------------------------------------------------
set_944 <- filter(Ana_rates, set == 944)
set_6 <- filter(Ana_rates, set == 6)
set_70 <- filter(Ana_rates, set == 70)
trial <- rbind(set_6, set_70, set_944)

scale.dt <- function(table){
  maxdt <- max(table$dt, na.rm = T)
  table$s_dt <- 1 - table$dt/maxdt
  table
}
scale.dt(set_6)

trial <- scale.dt(trial)
ggplot(trial, aes(x = temp, y = s_dt, col = set))+
  geom_line()+
  facet_grid(.~set)

inter <- inter %>% 
  group_by(set) %>% 
  nest() %>% 
  mutate(s_dt = map(data, scale.dt))


# Is development time minimum at the highest temperature? ---------------------------------------------------------------

where.min.dt <- function(table){
  ta <- select(table, temp, dt) # make a 2 column table
  
  if(nrow(ta) == sum(is.na(ta[,2]))){ # this is to discard sets with only NA                                           # values
    print("No data")
  }else{
    
    # get:
    # minimum development time
    min.dt <- min(ta$dt, na.rm = T) 
    # maximum temperature
    t.max <- max(ta$temp, na.rm = T)
    
    min.dt.t <- tail(filter(ta, dt == min.dt)[["temp"]])
    
    #output table
    output <- tibble(is.min.at.hottest =  t.max == min.dt.t) # TRUE when min at hotest
    output
  }
}
where.min.dt(set_6)
where.min.dt(trial)
inter <- inter %>% 
  group_by(set) %>% 
  nest() %>% 
  mutate(is.min.dt.at.max.t = map(data, where.min.dt))

source("/Users/marianaabarcazama/Desktop/Projects/MyFunctions.R")

# Cummulative survival graphs --------------------------------------------------------------------------------------------

inter %>% 
  group_by(id, sp, lifestage, set) %>% 
  tally(sort = T)


egg_ids <- tibble(id = unique(egg$id))
larva_ids <- tibble(id = unique(larva$id))
pupa_ids <- tibble(id = unique(pupa$id))

fullstudies <- intersect(egg_ids,larva_ids,pupa_ids)

ontosurvival <- inter %>% filter(id %in% fullstudies$id)
ontosurvival$stagenum <- ifelse(ontosurvival$lifestage == "egg", 1, ifelse(ontosurvival$lifestage == "larva",2, 3))
ggplot(ontosurvival, aes(x = stagenum, y = survival, col = factor(round(temp))))+
  geom_point()+
  geom_line(aes( y = survival, x = stagenum, col = factor(round(temp))))+
  #theme(legend.position = "none")+
  xlab("Life stage 1:egg, 2:larva, 3:pupa")+
  facet_wrap(id~sp)
names(ontosurvival)
