
# Class 2 -----------------------------------------------------------------

# Loading tidyverse -------------------------------------------------------
# You have to do this every time
library(tidyverse)


# Working with tibbles vs. vectors ----------------------------------------

# When using tibble functions
head(starwars)
nrow(starwars)

# When using vector functions
# Note the $
length(starwars$name)


# Importing data ----------------------------------------------------------

climate <- read_csv('https://bit.ly/3kKErEb')
airbnb <- read_csv('https://bit.ly/3oadz2L')


# Selecting and adding variables to a tibble ------------------------------


airbnb_2 <- select(airbnb, host_id, reviews, rating, price)

# Example: using `` when a variable is >1 word
# select(airbnb, host_id, reviews, rating, price, `Sq. Ft.`) 


# Writing comments when working with the pipe operator --------------------

# At the top of the code chunk
airbnb_tidy <- airbnb %>%
  # Within chunk
  select(host_id, reviews, rating, price) %>% # At the end of each line
  select(host_id, price, everything())

airbnb %>% 
  mutate(
    cost_per_num_accom = price / accommodates, # Define the variable 
    mean_price = mean(price) # Define the variable 
    )

# Breaking down if_else() -------------------------------------------------

x <- c(1, 2, 3)
y <- c(4, 5, 1)

x > y

if_else(x > y, 'yes', 'no')

city_1 <- 'San Francisco'
city_2 <- 'Portland'
california <- c('San Francisco', 'Los Angeles', 'San Diego')

# if_else() starts with a logical test
city_1 == city_2
city_1 %in% california

# Puting the logical test inside of if_else() allows you to 
# specify outputs other than TRUE/FALSE
if_else(city_1 %in% california, 'California City', 'Other City')
if_else(is.na(city_1), 'It is NA', 'It is not NA')
if_else(city_1 == NA, 'It is NA', 'It is not NA') # This will not work


climate %>% 
  mutate(
    high_uncertainty = if_else(condition = uncertainty > 1.5, true = 1, false = 0),
    winter = if_else(condition = month %in% c(1, 2, 12), true = 1, false = 0)
  ) %>%
  select(country, city, high_uncertainty, winter)


# Renaming variables - 3 different ways -----------------------------------

airbnb %>% 
  rename(
    city = address,
    cost = price,
    description = name
  )

airbnb %>% 
  mutate(
    city = address,
    cost = price,
    description = name
  )

airbnb %>% 
  transmute(
    city = address,
    cost = price,
    description = name
  )


# Replace NA with mutate()/transmute() and is.na()/replace_na() -----------

climate %>% 
  transmute(
    year,
    location = city,
    temp = if_else(condition = is.na(temp), true = 0, false = temp)
  )

climate_clean <- climate %>% 
  transmute(
    year,
    location = city,
    temp = replace_na(temp, 0)
  )

summary(climate_clean)
summary(climate)


#  %>% or $ when working with vectors -------------------------------------

climate$temp %>% summary() # option 1
summary(climate$temp) # option 2



# Referencing a data object inside of filter() ----------------------------

relevant_host_ids <- c(14942, 31481)

airbnb %>% 
  filter(host_id %in% relevant_host_ids) %>% 
  select(room_id, host_id, address)

# Colombia exercise -------------------------------------------------------

# Breadcrumbs
colombia <- climate %>%
  # Use filter to subset your data
  filter(
    # 1 condition to subset your data
    # Another condition to subset your data
    # A third condition...
  ) %>% 
  # Use (a) transmute() or (b) select() and mutate()
  # to create and select variables
  transmute(
    
  ) 
  
# Solution below
colombia <- climate %>% 
  filter(! is.na(temp) & year > 2000 & country == 'Colombia') %>% 
  transmute(
    year,
    month,
    city,
    fahrenheit = (temp * 9/5) + 32
  )