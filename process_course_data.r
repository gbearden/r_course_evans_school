library(tidyverse)

old_contribution_data <- read_csv('https://goo.gl/GTRqZs')
new_contribution_data <- read_csv('Contributions_to_Candidates_and_Political_Committees.csv')

old_crime_data <- read_csv('https://goo.gl/FHW2Ni')
new_crime_data <- read_csv('Crime_Data.csv')

new_contribution_data %>% 
  select_(.dots = colnames(select(old_contribution_data, -receipt_year))) %>% 
  filter(complete.cases(.)) %>% 
  sample_n(90000) %>% 
  gather(var, val, 2:21) %>% 
  mutate(val = ifelse(runif(nrow(.), 0, 1) > .1, val, NA)) %>% 
  spread(var, val) %>% 
  mutate(
    receipt_date   = lubridate::mdy(receipt_date)
    , receipt_year = lubridate::year(receipt_date)
    ) %>% 
  write.table('contributions_data.txt')

new_crime_data <- new_crime_data %>% 
  rename_all(tolower)

names(new_crime_data) <- str_replace_all(names(new_crime_data), c(" " = "_"))

new_crime_data %>% 
  select_(.dots = colnames(select(old_crime_data, -occurred_year, -reported_year))) %>%
  filter(complete.cases(.)) %>% 
  sample_n(190000) %>%
  gather(var, val, 2:11) %>% 
  mutate(val = ifelse(runif(nrow(.), 0, 1) > .1, val, NA)) %>% 
  spread(var, val) %>% 
  mutate(
    reported_date   = lubridate::mdy(reported_date)
    , occurred_date = lubridate::mdy(occurred_date)
    , occurred_year = lubridate::year(occurred_date)
    , reported_year = lubridate::year(reported_date)
  ) %>% 
  write.table('crime_data.txt')
