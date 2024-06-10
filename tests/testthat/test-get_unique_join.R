test_that("Test the input for table names", {
  expect_error(
    get_unique_join(tibble_names = c("fake_snacn_ph_fu"),
                    join_type = "full_join",
                    by_cols = "Lopnr"), "Please input two tibbles' names in the argument `tibble_names`.")
})
