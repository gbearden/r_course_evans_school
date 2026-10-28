# =============================================================================
# Class 4: Stakeholder-ready plots and reshaping data
#   if_else() categories, stacked and diverging bar charts, ggthemes,
#   pivot_longer(), and pivot_wider()
# =============================================================================

# Load libraries ---------------------------------------------------------------
library(tidyverse)
library(ggthemes)  # extra themes and palettes, e.g. theme_fivethirtyeight()

# Load data --------------------------------------------------------------------
airbnb  <- read_csv("https://bit.ly/3oadz2L")  # Seattle-area Airbnb listings
climate <- read_csv("https://bit.ly/3kKErEb")  # Historical city temperatures
mba     <- read_csv("https://bit.ly/4evYpeW")  # MBA admissions


# -----------------------------------------------------------------------------
# 1. Warm-up: ggplot review
# -----------------------------------------------------------------------------

# Average measurement uncertainty by year
climate %>%
  group_by(year) %>%
  summarise(uncertainty = mean(uncertainty, na.rm = TRUE)) %>%
  ggplot(aes(x = year, y = uncertainty)) +
  geom_line()

# Mean temperature (Fahrenheit) in six Brazilian cities since 1850
climate %>%
  filter(country == "Brazil" & year >= 1850) %>%
  mutate(temp = (temp * 9/5) + 32) %>%  # convert Celsius to Fahrenheit
  group_by(city) %>%
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(city, -mean_temp), y = mean_temp, fill = city)) +
  geom_bar(stat = "identity") +
  theme_bw() +
  scale_fill_wsj() +
  labs(
    x = "City",
    y = "Mean Temperature (Fahrenheit)",
    title = "Temperatures in 6 Brazilian Cities, 1850 - present",
    fill = NULL
  )


# -----------------------------------------------------------------------------
# 2. Building a stacked bar chart from a summary table
#    Steps: filter rows -> create a category -> count by group -> plot.
#    Because we count with summarise(), the plot uses stat = "identity".
# -----------------------------------------------------------------------------

# Start with the table: domestic applicants by industry and GMAT score group
gmat_by_industry <- mba %>%
  filter(international == FALSE) %>%  # keep domestic applicants only
  mutate(high_gmat = if_else(gmat > 650, "High GMAT Score", "Low GMAT Score")) %>%
  group_by(work_industry, high_gmat) %>%  # one row per industry/score group
  summarise(n = n())                      # count applicants in each group

gmat_by_industry

# Plot it: industry on the y-axis (sorted by count), score group as fill
gmat_by_industry %>%
  ggplot(aes(y = reorder(work_industry, n), x = n, fill = high_gmat)) +
  geom_bar(stat = "identity") +
  labs(fill = NULL) +
  theme_fivethirtyeight() +
  scale_fill_fivethirtyeight()


# -----------------------------------------------------------------------------
# 3. Diverging bar chart
#    Make one group's counts negative so its bars point left of zero.
#    Then relabel the x-axis with abs() so every label reads as positive.
# -----------------------------------------------------------------------------

gmat_by_industry %>%
  # After summarise(), the data are still grouped by work_industry, so
  # sum(n) is the total for each industry (used to sort the bars)
  mutate(
    industry_n = sum(n),
    n = if_else(high_gmat == "Low GMAT Score", n * -1, n)
  ) %>%
  ggplot(aes(y = reorder(work_industry, -industry_n), x = n, fill = high_gmat)) +
  geom_bar(stat = "identity") +
  scale_x_continuous(
    labels = function(x) abs(x),                         # show -50 as 50
    limits = function(x) c(-max(abs(x)), max(abs(x)))    # center zero
  ) +
  theme_fivethirtyeight() +
  theme(axis.title.y = element_text()) +  # this theme hides axis titles; turn y back on
  scale_fill_fivethirtyeight() +
  labs(fill = NULL, y = "Industry")


# -----------------------------------------------------------------------------
# 4. Reshaping data: pivot_longer()
#    Wide -> long: stack several columns into a name column and a value column.
#    Long data is what ggplot wants when you map a variable to color or fill.
# -----------------------------------------------------------------------------

# Turn the reviews and rating columns into rows
airbnb %>%
  select(room_id, host_id, room_type, address, reviews, rating) %>%
  pivot_longer(
    cols = c(reviews, rating),            # columns to stack
    names_to = "rental_characteristics",  # new column holding old column names
    values_to = "values"                  # new column holding their values
  )


# -----------------------------------------------------------------------------
# 5. Reshaping data: pivot_wider()
#    Long -> wide: spread one column's values out into new columns.
#    Wide data is often easier for people to read in a table.
# -----------------------------------------------------------------------------

# Number of rentals by city, with one column per room type
airbnb %>%
  group_by(address, room_type) %>%
  summarise(number_of_rentals = n()) %>%
  pivot_wider(names_from = room_type, values_from = number_of_rentals)

# Mean temperature in four countries, with one column per year
climate %>%
  filter(
    country %in% c("Angola", "Ivory Coast", "Ethiopia", "Kenya") &
      year %in% c(1850, 1900, 1950, 2000)
  ) %>%
  group_by(country, year) %>%
  summarise(temp = mean(temp, na.rm = TRUE)) %>%
  pivot_wider(
    names_from = year,
    values_from = temp,
    names_sort = TRUE  # order the year columns from earliest to latest
  )
