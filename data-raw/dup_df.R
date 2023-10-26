## code to prepare `DATASET` dataset goes here
df_dup_id <- tibble(
  id = rep(1:5, each = 2), # Create duplicated IDs
  NumericColumn1 = c(10, 10, 30, 40, 50, 60, 70, 80, 90, 100), # Numeric values
  NumericColumn2 = c(5.5, 7.7, 9.9, 9.9, 13.3, 15.5, 17.7, 19.9, 22.2, 24.4), # Numeric values
  CharacterColumn1 = c("A", "B", "C", "D", "E", "F", "G", "G", "I", "J"), # Character values
  CharacterColumn2 = c("Apple", "Apple", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Grape", "Iris", "Jackfruit") # Character values
)

usethis::use_data(df_dup_id, overwrite = TRUE)
