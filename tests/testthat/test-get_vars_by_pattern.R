test_that("get_vars_by_pattern works with matching datasets and variables", {
  # Create temporary data frames in the global environment
  assign("test_df_a", data.frame(ph_age = 1:3, other = 4:6, ph_bmi = 7:9),
         envir = .GlobalEnv)
  assign("test_df_b", data.frame(ph_weight = 10:12, height = 13:15),
         envir = .GlobalEnv)
  assign("test_not_df", list(a = 1), envir = .GlobalEnv)  # should be ignored

  on.exit({
    rm(list = c("test_df_a", "test_df_b", "test_not_df"), envir = .GlobalEnv)
  }, add = TRUE)

  result <- get_vars_by_pattern(dataset_pattern = "^test_df", var_pattern = "^ph")

  expect_type(result, "list")
  expect_named(result, c("test_df_a", "test_df_b"))
  expect_equal(result$test_df_a, c("ph_age", "ph_bmi"))
  expect_equal(result$test_df_b, "ph_weight")
})

test_that("get_vars_by_pattern returns NULL when no datasets match", {
  expect_message(
    result <- get_vars_by_pattern(dataset_pattern = "^nonexistent_xyz", var_pattern = "age"),
    "No datasets found matching pattern"
  )
  expect_null(result)
})

test_that("get_vars_by_pattern returns NULL when no variables match", {
  assign("test_df_c", data.frame(age = 1:3, bmi = 4:6), envir = .GlobalEnv)
  on.exit(rm("test_df_c", envir = .GlobalEnv), add = TRUE)

  expect_message(
    result <- get_vars_by_pattern(dataset_pattern = "^test_df_c", var_pattern = "^ph"),
    "No variables found matching pattern"
  )
  expect_null(result)
})

test_that("get_vars_by_pattern searches all objects when dataset_pattern is empty", {
  assign("test_df_d", data.frame(ph_score = 1:2), envir = .GlobalEnv)
  on.exit(rm("test_df_d", envir = .GlobalEnv), add = TRUE)

  result <- get_vars_by_pattern(dataset_pattern = "", var_pattern = "^ph")

  expect_true("test_df_d" %in% names(result))
  expect_equal(result$test_df_d, "ph_score")
})

test_that("get_vars_by_pattern errors when var_pattern is missing or empty", {
  expect_error(
    get_vars_by_pattern(dataset_pattern = "test"),
    "`var_pattern` must be a non-empty string"
  )

  expect_error(
    get_vars_by_pattern(dataset_pattern = "test", var_pattern = ""),
    "`var_pattern` must be a non-empty string"
  )

  expect_error(
    get_vars_by_pattern(dataset_pattern = "test", var_pattern = NULL),
    "`var_pattern` must be a non-empty string"
  )
})
