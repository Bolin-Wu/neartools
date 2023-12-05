## code to prepare `snack_random` dataset goes here
library(tidyverse)
library(sjlabelled)
library(lubridate)

# read fake SNAC-K data
fake_snack_df <- haven::read_dta("data-raw/snack_random.dta")

# store the label names
label_names <- get_label(fake_snack_df)

# randomize the values again
fake_snack_df <- fake_snack_df %>%
  mutate(across(where(is.numeric), ~ rnorm(n = length(.)))) %>%
  mutate(across(where(is.Date), ~ sample(seq(as.Date("1700/01/01"), as.Date("1850/01/01"), by = "day"), size = length(.)))) %>%
  set_label(label = label_names)

# make Lopnr a random integer

fake_snack_df <- fake_snack_df %>%
  mutate(Lopnr = sample(1:10000, size = nrow(fake_snack_df), replace = FALSE)) %>%
  mutate(age_base = sample(1:100, size = nrow(fake_snack_df), replace = TRUE), .after = "Lopnr")

# generate dates in pure digits for get_date_digit function's example
fixed_digits <- 19
random_number <- sample(100000:999999, 2900)
eight_digit <- as.numeric(str_c(fixed_digits, random_number))
six_digit <- sample(100000:999999, 315)
four_digit <- sample(1000:9999, 85)
# Combine th vectors
combined_vector <- c(eight_digit, six_digit, four_digit)

numeric_date <- c(combined_vector, rep(NA, nrow(fake_snack_df) - length(combined_vector)))
# Shuffle the order of the elements
shuffled_vector <- sample(numeric_date)

fake_snack_df <- fake_snack_df %>%
  mutate(numeric_date = shuffled_vector)

# export the data
usethis::use_data(fake_snack_df, overwrite = TRUE)
