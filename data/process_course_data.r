library(tidyverse)

read_csv('data-raw/seattle_airbnb.csv', col_types = cols()) %>% 
  filter(! str_detect(address, 'Yarrow|Hunts Point|Medina|Clyde|Washington, WA, United States|西雅图|Bothell|Mercer|Newcastle|Renton|Tukwila|Vashon')) %>% 
  mutate(across(address, ~ case_when(str_detect(.x, 'Seattle') ~ 'Seattle'
                                     , str_detect(.x, 'Redmond') ~ 'Redmond'
                                     , str_detect(.x, 'Kirkland') ~ 'Kirkland'
                                     , str_detect(.x, 'Bellevue') ~ 'Bellevue'
                                     , TRUE ~ .x))
         ) %>% 
  select(-currency, -rate_type, -location, -last_modified) %>% 
  write_csv('data/seattle_airbnb.csv', na = '')
