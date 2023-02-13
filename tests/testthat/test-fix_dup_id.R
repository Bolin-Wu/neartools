test_that("Test 'NA' in ID", {
  df <- tibble(id = c(1:5, rep(NA, 3), 6:7))
  expect_error(fix_dup_id(df, id_str = "ID"))
})


test_that("Test it_str search", {
  df <- tibble(id = c(rep(1, 3), 3:10))
  expect_error(fix_dup_id(df, id_str = "ID"))
})



test_that("Test creation of new_lopnr", {
  df <- tibble(id = c(rep(1, 3), 3:10))
  column_name <- colnames(suppressMessages(fix_dup_id(df, id_str = "id")$df_update))
  expect_equal(column_name, c("new_lopnr", "id"))
})


test_that("Test no duplicated id", {
  df <- tibble(id = c(rep(1:10)))
  expect_error(fix_dup_id(df, id_str = "id"), regexp = "There is no duplicated id!")
})
