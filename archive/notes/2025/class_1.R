# Write comments like this.
# Everything that follow the hash is a comment in an R script.

# Short-cut to run code
# command + return

# Install tidyverse or any package with install.packages()
install.packages("tidyverse")

# Load library
library(tidyverse)

# Built-in datasets
cars
starwars # dataset that ships with tidyverse

# Import data with read_csv()
# Here we import data from a URL. You can also import a local file.
airbnb <- read_csv('https://bit.ly/3oadz2L')

# Import climate data
climate <- read_csv('https://bit.ly/3kKErEb')

# Use help to learn more about functions
help(c)

# Create a data object with `<-`
some_numbers <- c(1, 2, 4)

# min(), mean(), max(), and sd() are functions. c() is actually a function too!
# Compute descriptive statistics
min(some_numbers)
mean(some_numbers, na.rm = TRUE)
max(some_numbers)
sd(some_numbers)

# My custom mean function
# All functions have a body and an output
# Functions are created using function() 
compute_mean <- function(x) { 
  # Calculate the sum of all values in `x`
  x_sum <- sum(x, na.rm = TRUE)
  # We'll learn more about the ! operator later
  # Just know that the code below used to create `x_clean` removes NA values
  x_clean <- x[!is.na(x)]
  # Count the number of values in `x`
  x_len <- length(x_clean)
  # Divide `x_sum` by `x_len`
  x_mean <- x_sum / x_len
  # `return` is used to tell R the output of the function
  return(x_mean)
}

compute_mean(x = some_numbers)


pnw <- c('Washington', 'Oregon', 'Idaho')
class(pnw)
class(c('Washington', 'Oregon', 'Idaho'))

# Create a tibble with the tibble() function
tibble(
  x = c(1:3)
  , y = c(4:6)
  , z = c('Washington', 'Oregon', 'Idaho')
)

# Refer to specific variable in a tibble with $ or the index like starwars[,1]
# Continue my comment here.
max(starwars$height, na.rm = TRUE)
starwars[,1]

# Coerce characters into factors when using summary
summary(as.factor(starwars$homeworld))
table(starwars$homeworld)["Iridonia"]

# See names of columns with ls()
ls(starwars)
ls(airbnb)

# Count the number of variables in the data
num_vars <- length(ls(airbnb))

# Sort alphabetically the values in a string
sort(starwars$name)


