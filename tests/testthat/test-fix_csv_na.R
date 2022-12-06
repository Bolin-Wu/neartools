test_that("input df has to be a string", {
  df = tibble(string = c("NA", " ",NULL, NA, NA, NA,1:4))
  expect_error(fix_empty_string(df))
})
