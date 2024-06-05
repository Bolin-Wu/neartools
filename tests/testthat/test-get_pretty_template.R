# Define a mock function for get_pretty_template
get_pretty_template <- function(output_file) {
  stop("The 'output_file' should be 'html', 'pdf' or 'word'")
}

# Your test code
test_that("Test rmd render type", {
  expect_error(get_pretty_template(output_file = "xyz"),
               "The 'output_file' should be 'html', 'pdf' or 'word'")
})
