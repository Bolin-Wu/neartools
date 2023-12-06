## code to prepare `fake_snacn_ph_wave3` dataset goes here

library(tidyverse)

n_obs = 1200

fake_snacn_ph_wave3 = tibble(Lopnr =sample(c(1:n_obs), size = n_obs, replace = FALSE),
                             age = sample(1:100, size = n_obs, replace = TRUE),
                             ph121 = sample(1:3, size = n_obs, replace = TRUE)) %>%
  arrange(Lopnr)

# Function to randomly set a proportion of values to NA in a vector
set_random_nas <- function(x, proportion) {
  nas <- sample(c(TRUE, FALSE), size = length(x), replace = TRUE, prob = c(proportion, 1 - proportion))
  ifelse(nas, NA, x)
}

# Set a proportion of rows to have NA values in the "age" column
proportion_of_nas <- 0.2  # Adjust this proportion as needed
fake_snacn_ph_wave3 <- fake_snacn_ph_wave3 %>%
  mutate(age = set_random_nas(age, proportion_of_nas),
         ph121 = set_random_nas(ph121, proportion_of_nas))


usethis::use_data(fake_snacn_ph_wave3, overwrite = TRUE)
