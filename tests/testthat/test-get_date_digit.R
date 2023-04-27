test_that("Test illegal id string", {
  expect_error(get_date_digit(
    df_arg = fake_snack_df,
    id_string = "id",
    date_string = "numeric_date",
    required_digits = 8
  ))
})


test_that("Test illegal date string", {
  expect_error(get_date_digit(
    df_arg = fake_snack_df,
    id_string = "Lop",
    date_string = "Date",
    required_digits = 8
  ))
})
