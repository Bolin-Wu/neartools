## code to prepare `snack_random` dataset goes here
library(tidyverse)
library(sjlabelled)
library(lubridate)

# read fake SNAC-K data
fake_snack_df = haven::read_dta("data-raw/snack_random.dta")

# store the label names
label_names <- get_label(fake_snack_df)

# randomize the values again
fake_snack_df <- fake_snack_df %>%
  mutate(across(where(is.numeric), ~ rnorm(n = length(.)))) %>%
  mutate(across(where(is.Date), ~ sample(seq(as.Date("1700/01/01"), as.Date("1850/01/01"), by = "day"), size = length(.)))) %>%
  set_label(label = label_names)


usethis::use_data(fake_snack_df, overwrite = TRUE)
