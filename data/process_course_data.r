library(tidyverse)
library(magrittr)

# Process Airbnb dataset

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

# Process temperature data

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

# Manufacture fake check-in data for Airbnb dataset

x <- airbnb %>%
  transmute(
    room_id
    , stays = round(runif(nrow(.), min = 1, 120), 0)
  ) %>% 
  nest(stays_rows = -room_id) %>% 
  mutate(stays_rows = map(stays_rows, ~ .x %>% complete(stays = 1:stays)))

x2 <- x %>% 
  sample_frac(.75) %>% 
  unnest(cols = stays_rows) %>% 
  rowwise() %>% 
  mutate(
    check_in_helper = case_when(stays == 1 ~ round(runif(1, min = 1, max = 364), 0))
    , days_later = case_when(stays != 1 ~ round(runif(1, min = 2, max = 20), 0))
  ) %>%
  ungroup

x3 <- x2 %>%
  mutate(check_in_date = case_when(stays == 1 ~ lubridate::ymd('2010-01-01') + lubridate::days(check_in_helper))) %>% 
  group_by(room_id) %>% 
  mutate(
    across(days_later, replace_na, 0)
    , across(days_later, cumsum)
    , across(check_in_date, max, na.rm = TRUE)
  ) %>% 
  ungroup %>% 
  transmute(
    room_id
    , across(check_in_date, ~ case_when(stays != 1 ~ .x + lubridate::days(days_later), TRUE ~ .x))
  )

x3 %>% 
  select(room_id, check_in_date) %>% 
  write_csv('data/airbnb_checkin.csv')