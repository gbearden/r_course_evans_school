# =============================================================================
# Class 3: Data visualization with ggplot2
#   ggplot(), aes(), geom_bar(), geom_line(), geom_point(), labs(),
#   scales, themes, and color palettes
# =============================================================================

# Load libraries ---------------------------------------------------------------
library(tidyverse)
library(scales)    # number formatting for axes, e.g. comma
library(ggthemes)  # extra themes and palettes, e.g. theme_wsj()

# Load data --------------------------------------------------------------------
airbnb  <- read_csv("https://bit.ly/3oadz2L")  # Seattle-area Airbnb listings
climate <- read_csv("https://bit.ly/3kKErEb")  # Historical city temperatures
mba     <- read_csv("https://bit.ly/4evYpeW")  # MBA admissions


# -----------------------------------------------------------------------------
# 1. Warm-up: dplyr review
# -----------------------------------------------------------------------------

# Compare average pre-1900 temperatures in Saudi Arabia and Peru
saudi <- climate %>%
  filter(year < 1900 & country == "Saudi Arabia")

peru <- climate %>%
  filter(year < 1900 & country == "Peru")

mean(saudi$temp, na.rm = TRUE)
mean(peru$temp, na.rm = TRUE)

# Average GMAT score and number of female applicants, by major
mba %>%
  filter(gender == "Female") %>%
  group_by(major) %>%
  summarise(
    gmat_mean = mean(gmat),
    n = n()
  )


# -----------------------------------------------------------------------------
# 2. ggplot basics
#    data %>% ggplot(aes(...)) + geom_*()
#      - ggplot() creates the canvas
#      - aes() maps columns to visual properties (x, y, fill, color, ...)
#      - geom_*() adds a layer that draws the data
# -----------------------------------------------------------------------------

# With no aesthetics or geoms, ggplot() draws an empty canvas
airbnb %>%
  ggplot()

# geom_bar() counts the rows in each x category
airbnb %>%
  ggplot(aes(x = address)) +
  geom_bar()

# `fill` colors the inside of bars and areas
# `color` colors points, lines, and outlines
airbnb %>%
  ggplot(aes(x = address, fill = address)) +
  geom_bar()

# Same idea with the climate data, limited to five countries
five_countries <- c("Brazil", "China", "India", "Turkey", "United States")

climate %>%
  filter(country %in% five_countries) %>%
  ggplot(aes(x = country, fill = country)) +
  geom_bar()


# -----------------------------------------------------------------------------
# 3. stat = "count" vs. stat = "identity"
#    "count"    (default) - ggplot counts the rows for you; only x is needed
#    "identity"           - you supply the bar heights yourself as y
# -----------------------------------------------------------------------------

# ggplot does the counting
airbnb %>%
  ggplot(aes(x = address, fill = address)) +
  geom_bar(stat = "count")

# We do the counting with dplyr, then plot the result
airbnb %>%
  group_by(address) %>%
  summarise(count = n()) %>%
  ggplot(aes(x = address, y = count, fill = address)) +
  geom_bar(stat = "identity")

# Fill by a variable we create: flag Kirkland room types with < 100 listings
kirkland <- airbnb %>%
  filter(address == "Kirkland") %>%
  group_by(room_type) %>%
  summarise(n_listings = n()) %>%
  mutate(listings_deficit = if_else(n_listings < 100, "y", "n"))

kirkland

kirkland %>%
  ggplot(aes(x = room_type, y = n_listings, fill = listings_deficit)) +
  geom_bar(stat = "identity")


# -----------------------------------------------------------------------------
# 4. Stacked vs. side-by-side bars
#    When fill is a second variable, bars stack by default.
#    position = "dodge" (shorthand for position_dodge()) puts them side by side.
# -----------------------------------------------------------------------------

# Stacked (default)
airbnb %>%
  ggplot(aes(x = address, fill = room_type)) +
  geom_bar()

# Side by side
airbnb %>%
  ggplot(aes(x = address, fill = room_type)) +
  geom_bar(position = "dodge")


# -----------------------------------------------------------------------------
# 5. Ordering bars
#    reorder(category, value) sorts categories by value;
#    use -value to sort from largest to smallest.
# -----------------------------------------------------------------------------

listings_by_city <- airbnb %>%
  group_by(address) %>%
  summarise(n = n())

listings_by_city %>%
  ggplot(aes(x = reorder(address, -n), y = n, fill = address)) +
  geom_bar(stat = "identity")

climate %>%
  filter(country %in% five_countries) %>%
  group_by(country) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = reorder(country, -n), y = n, fill = country)) +
  geom_bar(stat = "identity")


# -----------------------------------------------------------------------------
# 6. Styling a geom directly
#    Settings placed inside geom_*() (not aes()) apply to every bar.
#    Find color palettes at https://coolors.co/generate
# -----------------------------------------------------------------------------

listings_by_city %>%
  ggplot(aes(x = reorder(address, -n), y = n)) +
  geom_bar(
    stat = "identity",
    fill = "#ffd166",      # bar color (hex code)
    alpha = 1,             # transparency: 0 = invisible, 1 = solid
    color = "black",       # outline color
    linetype = "dashed",   # outline style
    linewidth = 2          # outline thickness
  )


# -----------------------------------------------------------------------------
# 7. Labels and axis scales
#    labs() sets axis, legend, and plot titles (NULL removes one).
#    scale_y_continuous(labels = comma) formats numbers like 10,000.
# -----------------------------------------------------------------------------

airbnb %>%
  ggplot(aes(x = address, fill = room_type)) +
  geom_bar() +
  labs(x = "City", y = "Number of Rentals (#)")

climate %>%
  filter(country %in% five_countries) %>%
  group_by(country) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = reorder(country, -n), y = n, fill = country)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Country",
    y = "Number of Observations (#)",
    fill = NULL,
    title = "Number of observations by country"
  ) +
  scale_y_continuous(labels = comma)


# -----------------------------------------------------------------------------
# 8. Themes and color palettes
#    theme_*()        - overall look (ggthemes adds theme_wsj(), theme_hc(), ...)
#    scale_fill_*()   - colors for the fill aesthetic
#    theme()          - fine-tune individual elements, e.g. hide the legend
# -----------------------------------------------------------------------------

# Wall Street Journal theme and palette, with the legend hidden
climate %>%
  filter(country %in% five_countries) %>%
  group_by(country) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = reorder(country, -n), y = n, fill = country)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Country",
    y = "Number of Observations (#)",
    fill = NULL,
    title = "Number of observations by country"
  ) +
  scale_y_continuous(labels = comma) +
  theme_wsj() +
  scale_fill_wsj() +
  theme(legend.position = "none")

# A custom palette: a vector of hex codes passed to scale_fill_manual()
wacky_palette <- c(
  "#FF0099", "#00CCFF", "#FF9900",
  "#33FF33", "#FF33CC", "#FFFF66", "#6600CC"
)

climate %>%
  filter(country %in% five_countries) %>%
  group_by(country) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = reorder(country, -n), y = n, fill = country)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Country",
    y = "Number of Observations (#)",
    fill = NULL,
    title = "Number of observations by country"
  ) +
  scale_y_continuous(labels = comma) +
  theme_wsj() +
  scale_fill_manual(values = wacky_palette)


# -----------------------------------------------------------------------------
# 9. Putting it together: Brazilian city temperatures by century
# -----------------------------------------------------------------------------

# Summarise temperatures for each city in the 19th and 20th centuries
brazil_temps <- climate %>%
  filter(
    country == "Brazil",
    !is.na(temp),
    year < 2000
  ) %>%
  mutate(century = if_else(year >= 1900, "20th Century", "19th Century")) %>%
  group_by(century, city) %>%
  summarise(
    mean_temp = mean(temp),
    median_temp = median(temp),
    max_temp = max(temp),
    .groups = "drop"
  ) %>%
  arrange(city)

brazil_temps

# Plot mean temperature by city, with centuries side by side
brazil_temps %>%
  ggplot(aes(x = reorder(city, mean_temp), y = mean_temp, fill = century)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "City", y = "Mean Temperature (Celsius)", fill = NULL) +
  theme_hc() +
  scale_fill_manual(values = wacky_palette)


# -----------------------------------------------------------------------------
# 10. Other geoms: lines and points
# -----------------------------------------------------------------------------

# geom_line(): average measurement uncertainty over time
climate %>%
  group_by(year) %>%
  summarise(uncertainty = mean(uncertainty, na.rm = TRUE)) %>%
  ggplot(aes(x = year, y = uncertainty)) +
  geom_line(color = "orange")

# geom_point(): relationship between temperature and uncertainty
climate %>%
  ggplot(aes(x = temp, y = uncertainty)) +
  geom_point()
