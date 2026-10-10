
# ctrl + enter, cmd + return - run a line of code or highlighted code

# My first comment
1+1

# install package
install.packages("tidyverse")

# load the tidyverse
library(tidyverse)

# Basic summary functions

some_numbers <- c(1, 2, 4)
# min(), mean(), max(), and sd() are functions. c() is a function too!

min(some_numbers)
mean(some_numbers)
max(some_numbers)
sd(some_numbers)
  
# Use help to learn more about functions
help(min)

some_numbers <- c(1, 2, 4)
min(some_numbers, na.rm = TRUE)
mean(some_numbers)
max(some_numbers)
sd(some_numbers)

# alternate mean function

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

compute_mean(some_numbers)

some_numbers
new_numbers <- c("1", "11", "2")

max(some_numbers)
max(new_numbers)

# What type of data are the variables/data objects?

class(some_numbers)
class(new_numbers)

is.character(new_numbers)
is.character(some_numbers)

new_numbers2 <- as.integer(new_numbers)
max(new_numbers2)

# is.character(), is.numeric(), is.integer(), is.factor()
# factors = labelled numbers

# Tibble vs. data frame
starwars

as.data.frame(starwars)

# Save heights from starwars
height_sw <- starwars$height

max(height_sw, na.rm = TRUE)

# Using indices
starwars[,10]

# Import Airbnb dataset
airbnb <- read_csv('https://bit.ly/3oadz2L')

# Compute fewest # of bathrooms
min(airbnb$bathrooms, na.rm = TRUE)

tail(starwars, 3)

summary(starwars)

hair_color <- as.factor(starwars$hair_color)

summary(hair_color)

table(starwars$homeworld)['Bespin']

length(unique(starwars$homeworld))

rows_and_cols <- dim(airbnb)
rows_and_cols[1]

sort(unique(airbnb$host_id))[1:3]

unique(airbnb$room_type) == "Yurt"
