test_that("get_vars_by_pattern handles missing parameters and package data correctly", {
  # Setup: Ensure package datasets are in the global environment
  .GlobalEnv$fake_snacn_ph_fu <- neartools::fake_snacn_ph_fu
  .GlobalEnv$fake_snacn_ph_wave3 <- neartools::fake_snacn_ph_wave3

  # 1. Test error when parameters are missing
  expect_error(get_vars_by_pattern(var_pattern = "age"), "Please specify data_pattern")
  expect_error(get_vars_by_pattern(data_pattern = "^fake"), "Please specify var_pattern")

  # 2. Test finding variables across matching datasets
  res_age <- get_vars_by_pattern(data_pattern = "^fake_snacn_ph", var_pattern = "age")
  expect_type(res_age, "list")
  expect_true("age" %in% res_age$fake_snacn_ph_fu)
  expect_true("age" %in% res_age$fake_snacn_ph_wave3)

  # 3. Test behavior when data_pattern matches nothing
  expect_message(
    get_vars_by_pattern(data_pattern = "not_a_dataset", var_pattern = "age"),
    "No datasets found matching pattern"
  )

  # Cleanup Global Environment
  rm(fake_snacn_ph_fu, fake_snacn_ph_wave3, envir = .GlobalEnv)
})
