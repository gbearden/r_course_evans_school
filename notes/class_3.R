
# Reminders ---------------------------------------------------------------

# = and <- are the the same
# You need == for equivalency tests

# Testing code line by line -----------------------------------------------

library(tidyverse)

climate <- read_csv('https://bit.ly/3kKErEb')

saudi <- climate %>% 
  filter(year < 1900 & country == 'Saudi Arabia')

peru <- climate %>% 
  filter(year < 1900 & country == 'Peru')

saudi %>% pull(temp) %>% mean(na.rm = TRUE)
peru %>% pull(temp) %>% mean(na.rm = TRUE)

# Import data -------------------------------------------------------------

airbnb <- read_csv('https://bit.ly/3oadz2L')
climate <- read_csv('https://bit.ly/3kKErEb')

# Filtering on 2+ countries -----------------------------------------------

# Use %in% when filtering on 2+ values
# == when filtering on 1 value

plot_countries <- c("Brazil", "China", "India", "Turkey", "United States")

climate %>% 
  filter(country %in% c("Brazil", "China", "India", "Turkey", "United States")) %>% 
  ggplot(aes(x = country, fill = country)) + 
  geom_bar()

# Data aggregation --------------------------------------------------------

airbnb %>% 
  group_by(address) %>% 
  summarise(mean_cost = mean(price))

airbnb %>% 
  filter(address == 'Kirkland') %>% 
  group_by(room_type, address) %>% 
  summarise(n_listings = n())

airbnb %>% 
  # Aggregate with group_by() %>% summarise()
  group_by(room_type, address) %>% 
  summarise(n_listings = n()) %>% 
  # Subset
  mutate(listings_deficit = if_else(n_listings < 100, 'y', 'n')) %>%
  filter(address == 'Kirkland') 

# Plotting aggregated data ------------------------------------------------

airbnb_agg <- airbnb %>% 
  # Aggregating with group_by() and summarise()
  group_by(address) %>%
  summarise(count = n()) 

sum(airbnb_agg$count) # 7423
nrow(airbnb) # 7423

airbnb %>% 
  group_by(room_type, address) %>% 
  summarise(
    n_listings = n(),
    avg_reviews = mean(reviews),
    avg_bathrooms = mean(bathrooms, na.rm = TRUE)
    ) 

airbnb_agg %>%
  # Plotting (below)
  ggplot(
    aes(
      x = address,
      y = count,
      fill = address
    )
  ) + 
  geom_bar(stat = "identity")

# Here we reorder the bars in the plot
airbnb %>% 
  group_by(address) %>%   
  summarise(n_listings = n()) %>%
  ggplot(
    aes(
      # x = address,
      x = reorder(x = address, X = -n_listings),
      y = n_listings,  
      fill = address
    )
  ) + 
  geom_bar(stat = 'identity')

airbnb %>% 
  ggplot(aes(x = address, fill = room_type)) + 
  geom_bar() + 
  labs(
    x = 'City',
    y = 'Number of Rentals (#)',
    fill = 'Check out these colors',
    title = 'Room Types by City',
    subtitle = 'Shared Rooms are the Least Available Room Type'
  )

# Creating a plot with the climate data -----------------------------------

climate %>% 
  filter(country %in% c('Brazil', 'China', 'India', 'Turkey', 'United States')) %>% 
  group_by(country) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(x = reorder(country, -n), y = n, fill = country)) + 
  geom_bar(stat = 'identity') + 
  labs(
    x = 'Country'
    , y = 'Number of Observations (#)'
    , fill = element_blank()
    , title = 'Number of observations by country'
  ) + 
  scale_y_continuous(labels = comma)
