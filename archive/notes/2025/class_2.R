# Cmd + shift + m
# |> 
# %>%


# shortcut: command + return
library(tidyverse)

mba <- read_csv("https://bit.ly/4evYpeW")
airbnb <- read_csv('https://bit.ly/3oadz2L', col_types = cols())
climate <- read_csv('https://bit.ly/3kKErEb', col_types = cols())


airbnb_2 <- select(airbnb, host_id, reviews, rating, price)

select(airbnb_2, `Room Type`)

select(airbnb, contains("id"))

sort(unique(starwars$gender))

airbnb %>% 
  select(host_id, reviews, rating, price)

airbnb |>
  # Insert columns above step in the code
  select(host_id, reviews, rating, price) |> 
  select(host_id, price, everything()) # You can also write comments at the end


airbnb_2 %>% 
  mutate(
    foo = if_else(reviews > price, 'yes', 'no')
  )

x <- c(1, 2, 3)
y <- c(4, 5, 1)
if_else(x > y, 'yes', 'no')

x[1] > y[1]

if_else(237 %in% 200:300, 'yes', 'no')


# Winter variable
# winter_months <- 

climate %>% 
  mutate(
    high_uncertainty = NA, # create high_uncertainty
    winter = if_else(month %in% c(1, 2, 12), 1, 0) # create winter
  )



# Apply a series of data transformation operations to the `climate` dataset
climate |> 
  # Create two new columns using the mutate function
  mutate(
    # Create a 'high_uncertainty' column: 1 if 'uncertainty' is greater than 1.5, else 0
    high_uncertainty = if_else(uncertainty > 1.5, 1, 0),
    
    # Create a 'winter' column: 1 if 'month' is January (1), February (2), or December (12), else 0
    winter = if_else(month %in% c(1, 2, 12), 1, 0)
  ) |>
  # Select only the 'country', 'city', 'high_uncertainty', and 'winter' columns from the dataset
  select(country, city, high_uncertainty, winter)



climate_winter <- 
  climate |> 
  transmute(
    country,
    city,
    high_uncertainty = if_else(uncertainty > 1.5, 1, 0),
    winter = if_else(month %in% c(1, 2, 12), 1, 0)
  )

airbnb %>% 
  mutate(
    rating = if_else(is.na(rating), 999, rating)
  )

airbnb |> 
  mutate(
    city = address,
    cost = price,
    description = name
  )


climate |> 
  transmute(
    year,
    location = city,
    temp = if_else(is.na(temp), 0, temp)
  ) %>% 
  filter(is.na(temp))

climate %>% 
  filter(is.na(temp))

airbnb |> 
  filter(price > 50 & price < 100 & room_type == 'Entire home/apt') |> 
  # select(room_id, host_id, address, room_type, rating, name) %>%
  summary()


colombia <- climate %>% 
  # subset the climate data
  filter(
    ! is.na(temp) # remove NA values in temp
    & country == "Colombia"
    & year >= 2001 # Keep years since 2001
  ) %>% 
  # create and select variables
  transmute(
    year,
    month,
    city,
    fahrenheit = (temp * 9/5) + 32
  ) 


airbnb |> 
  group_by(address) |> # group on x column in your tibble
  # Compute summary statistics by group
  summarise(
    mean_cost = mean(price)
    )

kirkland <- airbnb %>% 
  filter(address == 'Kirkland') %>% 
  group_by(room_type, address) %>% 
  summarise(n_listings = n()) 

airbnb %>% 
  filter(address == 'Kirkland') %>% 
  group_by(room_type, address) %>% 
  summarise(n_listings = n()) 

airbnb |> 
  group_by(room_type, address) |> 
  summarise(n_listings = n()) |> 
  filter(address == 'Kirkland') |> 
  mutate(listings_deficit = if_else(n_listings < 100, 'y', 'n'))


climate %>% 
  filter(country == "China") %>%
  group_by(month) %>% 
  summarise(
    mean_temp = mean(temp, na.rm = TRUE)
  )
















