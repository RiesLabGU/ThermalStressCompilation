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



