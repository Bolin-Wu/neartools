test_that("Test null in both keywords arguments", {
  label_df <- get_label_df(fake_snack_df)
  expect_error(get_na_number(data_df = fake_snack_df, label_df = label_df))
})
