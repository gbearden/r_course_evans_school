# %>%
# |>

ls()
ls(airbnb)

string_of_variables <- c("airbnb", "mba")

rm(list = string_of_variables)

# load the tidyverse
library(tidyverse)

# Read your data
airbnb <- read_csv('https://bit.ly/3oadz2L', col_types = cols())

ls(airbnb)

airbnb_df <- select(airbnb, host_id, reviews, price, accommodates)

airbnb %>%
  select(host_id, reviews, rating, price)

airbnb_df2 <- 
  airbnb_df %>%
  mutate(
    cost_per_num_accom = price / accommodates,
    mean_price = mean(price)
  )

x <- c(1, 2, 3, 5)
y <- c(4, 5, 1)
if_else(x > y, 'yes', 'no')

if_else(237 %in% 200:300, 'yes', 'no')

airbnb %>% 
  mutate(
    cost_per_num_accom = price / accommodates,
    mean_price = mean(price),
    seattle_address = if_else(address == 'Seattle', 'y', NA),
    large = if_else(accommodates > 5, 'y', NA)
  ) %>%
  select(room_id, host_id, cost_per_num_accom, mean_price, seattle_address, large)

  
climate <- read_csv('https://bit.ly/3kKErEb')

winter_months <- c(1, 2, 12)

# You can comment your code like this.
# At the top, say what the code chunk does.
climate %>% 
  mutate(
    high_uncertainty = if_else(uncertainty > 1.5, 1, 0), # You can comment here too at the end
    # Or here above a variable
    winter = if_else(month %in% winter_months, 1, NA)
  ) %>%
  select(country, city, high_uncertainty, winter)



california <- c('San Francisco', 'Los Angeles', NA)
if_else(is.na(california), "NA Value", "California City")


climate %>% 
  transmute(
    country,
    city,
    high_uncertainty = if_else(uncertainty > 1.5, 1, 0),
    winter = if_else(month %in% c(1, 2, 12), 1, NA)
  ) %>% 
  mutate(
    winter = if_else(is.na(winter), 0, winter)
  )

airbnb |> 
  transmute(
    city = address,
    cost = price,
    description = name
  )

climate %>% 
  transmute(
    year,
    location = city,
    temp = if_else(is.na(temp), 0, temp)
  ) %>%
  summary()

summary(climate)
summary(climate_2)

airbnb %>% 
  filter(
    (price > 50 & price < 100 & room_type == 'Entire home/apt') # 1st set of conditions
    | (rating > 4 & address == 'Seattle') # 2nd set of conditions
    ) %>% 
  select(room_id, host_id, address, room_type, rating, name)

# Exercise
colombia <- climate %>%
  # In filter:
  # Remove NA temp values
  # Remove dates before 2001
  # Only show Colombia
  filter(
    year >= 2001
    & country == "Colombia"
    & ! is.na(temp)
  ) %>% 
  # In transmute, create
  # the four variables
  transmute(
    year,
    month,
    city,
    fahrenheit = (temp * 9/5) + 32
  )

# Number of rows in colombia?
nrow(colombia)

# Mean temperature?
mean(colombia$fahrenheit)

# Cities in Colombia?
unique(colombia$city)

colombia <- climate %>% 
  filter(! is.na(temp) & year > 2000 & country == 'Colombia')
  
airbnb %>% 
  group_by(address) %>% 
  summarise(
    avg_price = mean(price),
    min_price = min(price),
    max_price = max(price),
    num_listings = n()
  )

airbnb %>% 
  group_by(room_type) %>% 
  summarise(
    avg_price = mean(price),
    min_price = min(price),
    max_price = max(price),
    num_listings = n()
  )
  
airbnb %>%
  group_by(room_type, address) %>%
  summarise(n_listings = n()) %>% 
  mutate(
    avg_room_type_listings = mean(n_listings)
  )
  
  
  








