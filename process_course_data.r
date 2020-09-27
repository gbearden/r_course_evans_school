library(tidyverse)

read_csv('Best_mask_hospitalization_all_locs.csv') %>% 
  select(-contains('upper'), -contains('lower'), -contains('smooth'), -V1, -location_id, -sero_pct) %>%
  rename(
    location                = location_name
    , population            = total_pop
    , infections_cumulative = inf_cuml_mean
    , total_deaths          = totdea_mean
    , total_deaths_p100k    = totdea_mean_p100k_rate 
    ) %>% 
  rename_all(function(.) gsub('_mean|_rate', '', .)) %>%
  write.table('covid_data.txt')

new_crime_data <- read_csv('SPD_Crime_Data__2008-Present.csv') %>% 
  rename_all(tolower) %>% 
  rename(
    neighborhood = mcpp
    , occurred_date = `offense start datetime`
    , reported_date = `report datetime`
    ) %>% 
  select(-longitude, -latitude, -`offense end datetime`
         , -`group a b`, -`offense code`, -`100 block address`
         , -sector 
         ) %>% 
  mutate(
    precinct = case_when(precinct %in% 'W'       ~ 'West'
                           , precinct %in% 'N'   ~ 'North'
                           , precinct %in% 'S'   ~ 'South'
                           , precinct %in% 'E'   ~ 'East'
                           , precinct %in% 'OOJ' ~ 'Out of Jurisdiction'
                           , precinct %in% 'SW'  ~ 'Southwest'
                           , TRUE                ~ precinct)
    )

names(new_crime_data) <- str_replace_all(names(new_crime_data), c(" " = "_"))

new_crime_data %>%
  filter(complete.cases(.)) %>% 
  sample_n(200000) %>% 
  gather(var, val, 5:10) %>%
  mutate(val = ifelse(runif(nrow(.), 0, 1) > .1, val, NA)) %>%
  spread(var, val) %>%
  mutate(
    occurred_time = occurred_date %>% substr(12, 16) %>% str_replace_all('\\:', '')
    , reported_time = reported_date %>% substr(12, 16) %>% str_replace_all('\\:', '')
    , occurred_date = occurred_date %>% substr(1, 10) %>% lubridate::ymd()
    , reported_date = reported_date %>% substr(1, 10) %>% lubridate::ymd()
    , occurred_year = lubridate::year(occurred_date)
    , reported_year = lubridate::year(reported_date)
  ) %>% 
  select(report_number, offense_id, neighborhood, beat, precinct
         , crime_against_category, offense, offense_parent_group
         , contains('occurred'), contains('reported')) %>% 
  write.table('crime_data.txt')
