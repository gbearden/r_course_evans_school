# ==============================================================================
# R Class 1 Notes: R basics, data types, loading data, and exploring data
# ==============================================================================


# ------------------------------------------------------------------------------
# 1. Setup: install and load packages
# ------------------------------------------------------------------------------

# Install packages ONCE per machine (comment these out after the first run)
install.packages("tidyverse")   # dplyr, readr, ggplot2, and friends
install.packages("tidycensus")  # access to US Census / ACS data

# Load packages EVERY session
library(tidyverse)
library(tidycensus)

# Comments can go on their own line, or at the end of a line like this one.

# Store your Census API key as an environment variable.
# Replace the placeholder with your own key; install = TRUE saves it to
# your .Renviron so you only need to do this once.
census_api_key("PASTE-YOUR-KEY-HERE", install = TRUE)


# ------------------------------------------------------------------------------
# 2. Vectors and functions
# ------------------------------------------------------------------------------

# c() combines values into a vector. It is a function too!
some_numbers <- c(1, 2, 4)

# min(), mean(), max(), and sd() are functions that summarize a vector.
# Assigning with <- saves the result; without it, R just prints the result.
min_value <- min(some_numbers)  # saved to an object
mean(some_numbers)              # printed to the console
max(some_numbers)
sd(some_numbers)

# Use help() to learn more about any function (or ?min as a shortcut)
help(min)
help(lm)


# ------------------------------------------------------------------------------
# 3. Data types and classes
# ------------------------------------------------------------------------------

# starwars is a built-in dataset that ships with dplyr (part of tidyverse)
starwars
as.data.frame(starwars)  # convert from a tibble to a base R data frame

# class() tells you what kind of object something is
class(starwars)      # a tibble / data frame
class(some_numbers)  # numeric

# Use $ to pull a single column out of a data frame
sw_height <- starwars$height

class(sw_height)
is.integer(sw_height)    # FALSE: height is stored as numeric (double)
is.character(sw_height)  # FALSE: it is not text

# Converting to character first turns the numbers into text, so mean() cannot
# compute an average. R returns NA with a warning. Lesson: check your classes.
mean(as.character(sw_height), na.rm = TRUE)

# The correct way to average a numeric column with missing values:
mean(sw_height, na.rm = TRUE)


# ------------------------------------------------------------------------------
# 4. Loading data
# ------------------------------------------------------------------------------

# read_csv() imports data; write_csv() exports it
# getwd() prints your current working directory (where relative paths start)
getwd()

# Bring your own data (BYOD): swap in your own file path
# byod_df <- read_csv("data/[my_file].csv")

# FiveThirtyEight political lean data, read directly from a URL
byod_df <- read_csv("http://bit.ly/48Ru0Ip")

# Airbnb listings data
airbnb <- read_csv("https://bit.ly/3oadz2L")

# Climate data
climate <- read_csv("https://bit.ly/3kKErEb")

# Census data via tidycensus: median income and population by WA county
wa_counties <- get_acs(
  geography = "county",
  state     = "WA",
  variables = c(median_income = "B19013_001", population = "B01003_001"),
  year      = 2024,
  output    = "wide"  # one row per county, with E (estimate) and M (margin of error) columns
)


# ------------------------------------------------------------------------------
# 5. Exploring a data frame
# ------------------------------------------------------------------------------

# Column names, alphabetized (names() is the more common way to list columns)
sort(names(wa_counties))

head(wa_counties, n = 3)  # first 3 rows
summary(wa_counties)      # quick summary of every column

# Treating GEOID as a factor gives a count per unique value
summary(as.factor(wa_counties$GEOID))

# Sort counties by median income, highest first
arrange(wa_counties, desc(median_incomeE))

# Size of a data frame: dim() returns c(rows, columns)
dim(airbnb)[1]  # number of rows
help(nrow)      # nrow(airbnb) does the same thing more directly

summary(airbnb)


# ------------------------------------------------------------------------------
# 6. Selecting columns and saving data
# ------------------------------------------------------------------------------

# Keep only the columns you need
airbnb_reviews <- select(airbnb, room_id, reviews)

# Write the result to a CSV in your working directory
write_csv(airbnb_reviews, "airbnb_review.csv")


# ------------------------------------------------------------------------------
# 7. Counting and unique values
# ------------------------------------------------------------------------------

# table() counts how many times each value appears
table(starwars$eye_color)

# Number of distinct values in a column
length(unique(starwars$hair_color))
length(unique(airbnb$address))

# unique() returns the distinct values themselves
unique(airbnb$address)

# Sort the distinct host IDs, then look at the first few
head(sort(unique(airbnb$host_id)))

# Square brackets [ ] pick out elements by position: here, the 3rd smallest ID
sort(unique(airbnb$host_id))[3]


# ------------------------------------------------------------------------------
# 8. Equivalence checks
# ------------------------------------------------------------------------------

# == compares element by element: returns one TRUE/FALSE per room type
"yurt" == unique(airbnb$room_type)

# %in% asks one question: is "yurt" anywhere in the vector? (single TRUE/FALSE)
"yurt" %in% unique(airbnb$room_type)


# ------------------------------------------------------------------------------
# 9. Pipes and counting by category
# ------------------------------------------------------------------------------

# The pipe (%>%) passes the result on the left into the function on the right.
# Read it as "and then". This selects the year and month columns of climate.
climate %>%
  select(year, month)

# A vector of text values
two_countries <- c("Spain", "Japan")

# table() output can be indexed by position: here, the count for the 2nd country
table(climate$country)[2]

# Use %in% with the vector above to keep only rows for those two countries
climate %>%
  filter(country %in% two_countries)