test_that("Test the input for table names", {
  expect_error(
    get_unique_join(tibble_names = c("fake_snacn_ph_fu"),
                    join_type = "full_join",
                    by_cols = "Lopnr"), "Please input two tibbles' names in the argument `tibble_names`.")
})


test_that("Test the input for join_type", {
  expect_error(
    get_unique_join(tibble_names =  c("fake_snacn_ph_wave3", "fake_snacn_ph_fu"),
                    join_type = "join",
                    by_cols = "Lopnr"))
})



test_that("Test the input for by_cols", {
  expect_error(
    get_unique_join(tibble_names =  c("fake_snacn_ph_wave3", "fake_snacn_ph_fu"),
                    join_type = "left_join",
                    by_cols = "Lopnr = N1lopnr, age"), "Error: Single equal sign '=' detected.")
})
