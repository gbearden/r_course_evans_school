library(tidyverse)

# -----------
# Import data 
# -----------

airbnb <- read_csv('https://bit.ly/3oadz2L', col_types = cols())
climate <- read_csv('https://bit.ly/3kKErEb', col_types = cols())

colombia <- climate %>% 
  filter(! is.na(temp) & year > 2000 & country == 'Colombia') %>% 
  transmute(
    year
    , month
    , city
    , fahrenheit = (temp * 9/5) + 32
  )

# -------------------------------
# Colombia Tempterature Line Plot
# -------------------------------

colombia %>%
  filter(year >= 1850) %>% 
  group_by(year, city) %>% 
  summarise(across(fahrenheit, mean), .groups = 'drop') %>% 
  ggplot(aes(x = year, y = fahrenheit, color = city)) + 
  geom_line(size = 1) + 
  theme_minimal() + 
  labs(
    x = 'Year', 
    y = 'Temperature', 
    title = 'Average Temperatures in Bogota and Cali since 1850',
    color = NULL
    ) + 
  theme(legend.position = 'top') + 
  ggthemes::scale_color_few()

ggsave('plots/colombia.jpeg', device = 'jpeg', width = 5, height = 3, dpi = 150, units = "in", bg = "white")

# ------------------------
# Airbnb Price and Ratings
# ------------------------

airbnb %>% 
  select(room_type, address, rating, price) %>% 
  group_by(room_type, address) %>% 
  summarise(across(.fns = mean, na.rm = TRUE), .groups = 'drop') %>% 
  gather(metric, value, c(rating, price)) %>% 
  mutate(across(metric, stringr::str_to_title)) %>% 
  ggplot(aes(x = address, y = value, fill = room_type)) + 
  geom_bar(stat = 'identity', position = position_dodge(), alpha = .8) + 
  facet_wrap(. ~ metric, ncol = 1, scales = 'free_y') + 
  labs(
    x = NULL,
    fill = NULL,
    y = NULL,
    title = 'Average Price and Ratings by Address and Room Type',
    subtitle = 'No meaningful relationship exists between Price and Ratings'
  ) + 
  theme_minimal() + 
  theme(
    legend.position = 'top',
    strip.text = element_text(size = 10)
    ) + 
  ggthemes::scale_fill_calc()
  
ggsave('plots/airbnb_price_ratings.jpeg', device = 'jpeg', width = 5.5, height = 3, dpi = 150, units = "in", bg = "white")
