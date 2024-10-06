
# Class 1


# Shortcuts ---------------------------------------------------------------

# shift + control + c shortcut to comment
# shift + control + r add section title 
# control + enter OR command + enter to run a line of code


# Installing tidyverse ----------------------------------------------------
# You only have to do this once
install.packages('tidyverse')


# Loading tidyverse -------------------------------------------------------
# You have to do this every time
library(tidyverse)


# Basics ------------------------------------------------------------------

# Example of how to create a variable.
# You'll see "a" in the Environment tab
a <- 1

# Example of using descriptive statistics functions and the na.rm argument
some_numbers <- c(1,2, NA, 4)

min(some_numbers)
mean(some_numbers)
max(some_numbers)
sd(some_numbers)
sum(some_numbers, na.rm = TRUE)

# Use help() to look at the local dictionary
help(lm)
help(min)


# Create a function with ChatGPT ------------------------------------------
# Just about all functions have a body, output, and arguments

# A function called sum_two_numbers that takes two arguments.
# Argument 'x' represents the first number to be added.
# Argument 'y' represents the second number to be added.

sum_two_numbers <- function(x, y) {
  # Calculate the sum of x and y and store it in the variable 'result'
  result <- x + y
  # Return the result as the output of the function
  return(result)
}

sum_two_numbers(x = 1, y = 4)


# Checking data types -----------------------------------------------------
# Checking data types is important. Functions often work with specific data
# types. The wrong data could result in the wrong output or an error.

states <- c('Washington', 'Oregon', 'Idaho')

class(states)
class(c('Washington', 'Oregon', 'Idaho'))

is.factor(states)


# Tibbles! ----------------------------------------------------------------
# Tibbles are like spreadsheets in Excel, but they also contain metadata.
# Specifically, they contain information about variable types and the dimensions
# of the 2x2 data

tibble(
  x = c(1:3)
  , y = c(4:6)
  , z = c('Washington', 'Oregon', 'Idaho')
)

# Note that the data frame does not include the tibble metadata
data.frame(
  x = c(1:3)
  , y = c(4:6)
  , z = c('Washington', 'Oregon', 'Idaho')
)



starwars[,1] # pulls name from starwars using the index. Still a tibble column.
starwars$name # pull name from starwars using $. Creates a string.
starwars[1:2,] # The first two rows of a tibble.


# Exercise 1 --------------------------------------------------------------

# Load data
airbnb <- read_csv('https://bit.ly/3oadz2L')

# See slides for questions and answers


# Functions to explore tibbles and vectors --------------------------------
# tibbles
head(airbnb)
tail(airbnb, n = 2)

arrange(airbnb, address)
arrange(.data = airbnb, address)
arrange(airbnb, desc(reviews))

airbnb$room_type

summary(airbnb)

head(arrange(airbnb, bathrooms), n = 4)

airbnb_asc_bathrooms <- arrange(airbnb, bathrooms)
head(airbnb_asc_bathrooms, n = 4)

airbnb
airbnb_asc_bathrooms

# dim(), nrow(), and ncol()
dim(airbnb)
nrow(airbnb)
ncol(airbnb)

# Vectors
length(airbnb$host_id)

sort(unique(airbnb$bedrooms))

