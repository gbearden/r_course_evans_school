
library(tidyverse)

location_rm <- c("Azad Jammu & Kashmir", "Balochistan", "Gilgit-Baltistan", "Islamabad Capital Territory"
  , "Khyber Pakhtunkhwa","Sindh","Andalucia","Aragon","Cantabria","Castilla-La Mancha"
  , "Community of Madrid", "Extremadura", "Balearic Islands", "Canary Islands"
  , "Asturias", "Murcia", "Castile and León", "Catalonia", "Navarre"
  , "Valencian Community", "Galicia", "Basque Country", "La Rioja", "Baden-Württemberg"
  , "Bavaria","Berlin", "Brandenburg", "Bremen", "Hamburg", "Hesse", "Lower Saxony"
  , "Mecklenburg-Vorpommern", "North Rhine-Westphalia","Rhineland-Palatinate", "Saarland"                                        
  , "Saxony-Anhalt", "Saxony","Schleswig-Holstein", "Thuringia"
  , "Acre", "Alagoas", "Amazonas", "Amapá", "Bahia", "Ceará", "Distrito Federal"
  , "Espírito Santo", "Goiás", "Maranhão", "Minas Gerais", "Mato Grosso do Sul", "Mato Grosso"                                     
  , "Pará", "Paraíba", "Paraná", "Pernambuco", "Piaui", "Rio de Janeiro"                                  
  , "Rio Grande do Norte", "Rondônia", "Roraima", "Rio Grande do Sul", "Santa Catarina", "Sergipe"                                         
  , "São Paulo", "Tocantins", "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Delhi"                                           
  , "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu & Kashmir and Ladakh", "Jharkhand"                                       
  , "Karnataka", "Kerala" )

read_csv('/Users/graham/Downloads/2020_09_18/Best_mask_hospitalization_all_locs.csv') %>% 
  select(-contains('upper'), -contains('lower'), , -V1, -location_id, -contains('smooth')
         , -sero_pct, -totdea_mean, -totdea_mean_p100k_rate, 
         , -inf_cuml_mean
         ) %>% 
  rename(
    location                = location_name
    , population            = total_pop
    ) %>% 
  rename_all(function(.) gsub('_mean|_rate', '', .)) %>% 
  filter(! location %in% location_rm) %>% 
  write_csv('/Users/graham/Downloads/2020_09_18/covid_data.csv', na = '')

new_crime_data <- read_csv('/Users/graham/Downloads/SPD_Crime_Data__2008-Present.csv') %>% 
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
    precinct = case_when(precinct %in% 'W' ~ 'West'
                           , precinct %in% 'N' ~ 'North'
                           , precinct %in% 'S' ~ 'South'
                           , precinct %in% 'E' ~ 'East'
                           , precinct %in% 'OOJ' ~ 'Out of Jurisdiction'
                           , precinct %in% 'SW' ~ 'Southwest'
                           , TRUE ~ precinct)
    )

names(new_crime_data) <- str_replace_all(names(new_crime_data), c(" " = "_"))

new_crime_data %>%
  filter(complete.cases(.)) %>% 
  sample_n(150000) %>% 
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
  write_csv('/Users/graham/Downloads/2020_09_18/crime_data.csv', na = '')
