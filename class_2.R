# =============================================================================
# Class 2: Data wrangling with dplyr
#   select(), rename(), mutate(), transmute(), filter(), group_by(), summarise()
# =============================================================================

# Load libraries ---------------------------------------------------------------
library(tidyverse)


# -----------------------------------------------------------------------------
# 1. Importing and exploring data
# -----------------------------------------------------------------------------

# MBA admissions data
mba <- read_csv("https://bit.ly/4evYpeW")

# How many applicants are international?
table(mba$international)["TRUE"]

# How many applicants come from each industry?
table(mba$work_industry)


# -----------------------------------------------------------------------------
# 2. select(): choose columns
#    General form: select(data, col1, col2, ...)
# -----------------------------------------------------------------------------

# Keep only the application ID and admission decision
admit <- select(mba, application_id, admission)

# Seattle-area Airbnb listings (col_types = cols() silences the column message)
airbnb <- read_csv("https://bit.ly/3oadz2L", col_types = cols())

select(airbnb, host_id, reviews, rating, price)

# Helper functions for selecting columns:
#   everything() - all remaining columns (handy for reordering)
#   contains()   - columns whose name includes a substring
#   all_of()     - columns named in a character vector; errors if any are missing
#   any_of()     - same as all_of(), but silently skips missing names
keep_vars <- c("bedrooms", "bathrooms")

select(airbnb, name, everything())           # move `name` to the front
select(airbnb, contains("room"))             # room_id, room_type, bedrooms, ...
select(airbnb, room_id, all_of(keep_vars))
select(airbnb, room_id, any_of(c(keep_vars, "not_a_column")))  # no error


# -----------------------------------------------------------------------------
# 3. The pipe |>
#    x |> f(y) is the same as f(x, y)
# -----------------------------------------------------------------------------

# These two lines are equivalent
select(airbnb, host_id, reviews, rating, price)

airbnb |>
  select(host_id, reviews, rating, price)

# Pipes let you chain steps and comment each one
airbnb |>
  # Keep four columns
  select(host_id, reviews, rating, price) |>
  # Reorder so price comes right after host_id
  select(host_id, price, everything())


# -----------------------------------------------------------------------------
# 4. rename(): change column names (new_name = old_name)
# -----------------------------------------------------------------------------

# Note: this is NOT saved back to `airbnb`, so later code still uses the
# original names (address, price, name)
airbnb |>
  rename(
    city        = address,
    cost        = price,
    description = name
  )


# -----------------------------------------------------------------------------
# 5. Comparison operators: == vs. %in%
# -----------------------------------------------------------------------------

city_1     <- "San Francisco"
city_2     <- "Portland"
california <- c("San Francisco", "Los Angeles", "San Diego")

city_1 == california   # element-wise: TRUE FALSE FALSE
city_1 %in% california # is city_1 anywhere in the vector? TRUE
city_2 %in% california # FALSE


# -----------------------------------------------------------------------------
# 6. mutate(): create or modify columns
# -----------------------------------------------------------------------------

airbnb_xy <- airbnb |>
  mutate(
    cost_per_guest  = price / accommodates,
    mean_price      = mean(price),  # one overall mean, repeated on every row
    seattle_address = if_else(address == "Seattle", "y", NA),
    large           = if_else(accommodates > 5, "y", NA)
  ) |>
  select(room_id, host_id, cost_per_guest, mean_price, seattle_address, large)

# Global city temperature data
climate <- read_csv("https://bit.ly/3kKErEb") |>
  mutate(
    high_uncertainty = if_else(uncertainty > 1.5, 1, 0),  # 1/0 indicator
    winter           = if_else(month %in% c(1, 2, 12), 1, 0)
  )

# A minus sign drops a column
climate |>
  select(-high_uncertainty)

# Look at only the new columns
climate |>
  select(country, city, high_uncertainty, winter)

# A logical test on its own already gives TRUE/FALSE, so if_else() isn't needed
climate |>
  mutate(winter = month %in% c(1, 2, 12))


# -----------------------------------------------------------------------------
# 7. transmute(): mutate() + keep only the named columns
#    (dplyr now prefers mutate(..., .keep = "none"), but transmute() still works)
# -----------------------------------------------------------------------------

bathrooms <- airbnb |>
  transmute(
    rental             = room_id,   # rename while keeping
    room_type,                      # keep as-is
    bathrooms,
    bathrooms_2_more   = bathrooms >= 2,
    price_per_bathroom = price / bathrooms
  )

head(bathrooms)

# transmute() can also rename and select in one step
airbnb |>
  transmute(
    city        = address,
    cost        = price,
    description = name
  )


# -----------------------------------------------------------------------------
# 8. filter(): keep rows that meet a condition
# -----------------------------------------------------------------------------

# Listings outside Seattle
airbnb |>
  filter(address != "Seattle") |>
  select(room_id, host_id, address)

# Entire homes priced between $50 and $100
airbnb_fair_price <- airbnb |>
  filter(price > 50 & price < 100 & room_type == "Entire home/apt")

# Colombian cities after 2000, with temperature converted to Fahrenheit
colombia <- climate |>
  filter(!is.na(temp) & year > 2000 & country == "Colombia") |>
  transmute(
    year,
    month,
    city,
    fahrenheit = (temp * 9 / 5) + 32
  )


# -----------------------------------------------------------------------------
# 9. group_by() + summarise(): summary statistics by group
# -----------------------------------------------------------------------------

# One number for the whole dataset
mean(airbnb$price)

# The same summary, broken out by city
airbnb |>
  group_by(address) |>
  summarise(
    mean_cost               = mean(price),
    num_listings            = n(),                      # rows per group
    num_accommodate_values  = n_distinct(accommodates), # unique values per group
    .groups = "drop"
  )

# Number of Kirkland listings by room type, flagged by whether there are fewer than 100
kirkland_deficit <- airbnb |>
  filter(address == "Kirkland") |>
  group_by(room_type, address) |>
  summarise(num_listings = n(), .groups = "drop") |>
  mutate(deficit = if_else(num_listings < 100, "<100", ">=100"))

# Quick check: pull() pulls out a column as a vector, then table() counts it
airbnb |>
  filter(address == "Kirkland") |>
  pull(room_type) |>
  table()

# Average monthly temperature in Shanghai (Fahrenheit)
climate |>
  filter(country == "China" & city == "Shanghai") |>
  mutate(fahrenheit = (temp * 9 / 5) + 32) |>
  group_by(city, month) |>
  summarise(mean_temp = mean(fahrenheit, na.rm = TRUE), .groups = "drop")