
# Description -------------------------------------------------------------

# Below is a basic workflow for creating a classifier model in R.
# In academia, glm() is very common for this sort of model. 
# Personally, I prefer the tidymodels library for implementing classifiers.
# tidymodels offers a wide array of capabilities that go beyond glm().
# Additionally, tidymodels implements glm() operations over explicit, 
# independent steps. As a result, the tidymodels workflow is easier to 
# troubleshoot if you encounter bugs. Each step (or function) in the workflow 
# performs a limited distinct task that you can address in a targeted way rather 
# than trying to solve for an error thrown by glm() which could be caused by 
# any one of the many modeling operations implemented by glm().
# You can read about tidymodels here: https://www.tidymodels.org/.

# Load libraries ----------------------------------------------------------
library(tidyverse)
library(tidymodels)

# Import data -------------------------------------------------------------
airbnb <- read_csv('https://bit.ly/3oadz2L') %>% 
  transmute(
    room_type = as.factor(room_type), # Converting the outcome variable to a factor is likely necessary
    accommodates,
    bedrooms,
    bathrooms,
    price
  ) %>%
  filter(
    complete.cases(.) # Removes any rows with NAs
    & room_type != "Shared room" # There are relatively few shared rooms, so I'm dropping them
    ) 

# Split data --------------------------------------------------------------
# I would use set.seed() in the beginning for the sake of reproducibility
set.seed(123)  

# Split data into train and test sets
data_split <- initial_split(airbnb, prop = 0.7) # More info here: https://rsample.tidymodels.org/reference/initial_split.html
train_data <- training(data_split)
test_data <- testing(data_split)

# Train model -------------------------------------------------------------
# Your formula
data_recipe <- recipe(room_type ~ ., data = train_data) %>% 
  step_scale()

# Your model
logistic_model <- logistic_reg() %>% # More info here: https://parsnip.tidymodels.org/reference/logistic_reg.html
  set_engine("glm")

# A basic workflow
# You can update the workflow to do lots of stuff
logistic_workflow <- workflow() %>% # More info here: https://workflows.tidymodels.org/
  add_model(logistic_model) %>% # logistic_model created above
  add_recipe(data_recipe) # data_recipe created above

# Train your model
logistic_fit <- logistic_workflow %>% 
  fit(data = train_data)

# Predict -----------------------------------------------------------------
# Apply the trained model to the test data
predictions <- logistic_fit %>% 
  predict(new_data = test_data) %>%
  # predict(new_data = test_data, type = "prob") %>% # Use instead of the predict() on the line above for probabilities
  bind_cols(test_data)

# Test performance --------------------------------------------------------
# See how well the model works
accuracy <- accuracy_vec(truth = predictions$room_type, estimate = predictions$.pred_class)
accuracy # Accuracy rate

# Compare actual and predicted values. 
predictions %>% 
  group_by(.pred_class, room_type) %>% 
  summarise(n = n(), .groups = 'drop') %>% 
  spread(.pred_class, n)

# Typical regression table output
tidy(logistic_fit)

