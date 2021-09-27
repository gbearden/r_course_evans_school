library(tidyverse)
library(magrittr)

read_csv('data-raw/seattle_airbnb.csv', col_types = cols()) %>% 
  filter(! str_detect(address, 'Yarrow|Hunts Point|Medina|Clyde|Washington, WA, United States|西雅图|Bothell|Mercer|Newcastle|Renton|Tukwila|Vashon')) %>% 
  mutate(across(address, ~ case_when(str_detect(.x, 'Seattle') ~ 'Seattle'
                                     , str_detect(.x, 'Redmond') ~ 'Redmond'
                                     , str_detect(.x, 'Kirkland') ~ 'Kirkland'
                                     , str_detect(.x, 'Bellevue') ~ 'Bellevue'
                                     , TRUE ~ .x))
         ) %>% 
  select(-currency, -rate_type, -location, -last_modified) %>% 
  rename(rating = overall_satisfaction) %>% 
  write_csv('data/seattle_airbnb.csv', na = '')

read_csv('data-raw/GlobalLandTemperaturesByMajorCity.csv', col_types = cols()) %>% 
  mutate(
    across(dt, lubridate::year, .names = 'year')
    , across(dt, lubridate::month, .names = 'month')
    , across(Country, ~ case_when(.x == 'Congo (Democratic Republic Of The)' ~ 'Congo (DRC)'
                                  , .x == "Côte D'Ivoire" ~ 'Ivory Coast'
                                  , TRUE ~ .x))
    , across(City, ~ ifelse(.x == 'Mexico', 'Mexico City', .x))
  ) %>%
  rename(temp = AverageTemperature, uncertainty = AverageTemperatureUncertainty, city = City, country = Country) %>%
  select(year, month, country, city, temp, uncertainty) %>% 
  write_csv('data/global_temperatures.csv', na = '')
  
