test_that("Data directory can not be empty", {
  expect_error(bulk_import(),"There is no input for data directory.")
})

test_that("File type has to be one of then four pre-defined", {
  expect_error(bulk_import(data_dir = "/test",file_type = 'xlsx' ),"Invalid file type.")
})

