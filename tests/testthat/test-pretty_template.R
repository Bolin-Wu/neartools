test_that("Test rmd render type", {
  expect_error(pretty_template(output_file = 'xyz'),
               "The 'output_file' should be 'html' or 'word'")
})


