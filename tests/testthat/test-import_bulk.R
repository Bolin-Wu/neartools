test_that("Data directory can not be empty", {
  expect_error(import_bulk(),"There is no input for data directory.")
})

test_that("File type has to be one of then four pre-defined", {
  expect_error(import_bulk(data_dir = "/test",file_type = 'xls' ),"Invalid file type.")
})

