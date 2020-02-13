# Determine which datasets contain high enough temperatures to see a decline in survival / increase in development time
# This will help us determine what sorts of curves we should be fitting later on
# This could be mechanistically achieved by seeing if survival is highest (or development time is lowest) at the last temperature measured for each set
# In those datasets that do include high temperatures, identify whether survival rate starts dropping before development time starts increasing
# We're not sure development time will ever start increasing - the organisms might just die 

# Functions
t <- set_6$temp
p <- set_6$dt
is.rise <- function(t, p){
  table <- tibble(temperature = t,
                  performance = p)
  #table <- filter(table, !is.na(performance))
  p.large <- max(table$performance)
  t.large <- filter(table, performance == p.large)[["temp"]]
  colds <- filter(table, temperature < t.large)
  hots <- filter(table, temperature > t.large)
  output <- tibble(treatments = nrow(table), 
                   colds = nrow(colds), 
                   hots = nrow(hots))
  output
  
}

is.rise(set_6$temp, set_6$dt)

## Nest data 
nested <- interval_sets %>% 
  group_by(set) %>% 
  nest() %>% 
  mutate(ntemps = nrow())
