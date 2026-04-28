#' Find variables matching a pattern across multiple datasets
#'
#' This function searches for specific variable names (columns) across multiple data frames
#' in the global environment that match a certain naming pattern.
#'
#' @param data_pattern A string containing a regular expression to match the names of
#'   the datasets in the global environment. For more information on supported
#'   regular expressions, see \href{https://stat.ethz.ch/R-manual/R-devel/library/base/help/regex.html}{R's regex documentation}.
#' @param var_pattern A string containing a regular expression to match the variable
#'   names within those datasets.
#'
#' @return A named list where each element name is a dataset and the value is a
#'   character vector of matching variable names. Returns NULL if no datasets match.
#'
#' @examples
#' \dontrun{
#' # Load package data into global environment
#' data("fake_snacn_ph_fu")
#' data("fake_snacn_ph_wave3")
#'
#' # Search for variables starting with "ph" in SNAC-N physical datasets
#' get_vars_by_pattern(data_pattern = "^fake_snacn_ph", var_pattern = "^ph")
#' }
#'
#' @export
get_vars_by_pattern <- function(data_pattern = NULL,
                                var_pattern = NULL) {
  if (is.null(data_pattern)) {
    stop("Please specify data_pattern.")
  }

  if (is.null(var_pattern)) {
    stop("Please specify var_pattern.")
  }

  # Identify objects in the global environment matching the data_pattern
  objs <- ls(envir = .GlobalEnv, pattern = data_pattern)

  if (length(objs) == 0) {
    message("No datasets found matching pattern: ", data_pattern)
    return(NULL)
  }

  result <- list()

  for (name in objs) {
    df <- get(name, envir = .GlobalEnv)

    # Skip objects that are not data frames
    if (!is.data.frame(df)) next

    # Identify variable names matching the var_pattern
    matches <- grep(var_pattern, names(df), value = TRUE)

    if (length(matches) > 0) {
      result[[name]] <- matches
    }
  }

  if (length(result) == 0) {
    message("No variables found matching pattern: ", var_pattern)
  }

  return(result)
}
