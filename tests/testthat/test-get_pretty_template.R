test_that("Test rmd render type", {
  expect_error(
    get_pretty_template(output_file = "xyz"),
    "The 'output_file' should be 'html', 'pdf' or 'word'"
  )
})
