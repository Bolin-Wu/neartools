#' Find variables matching a pattern across multiple datasets
#'
#' This function searches for specific variable names (columns) across multiple data frames
#' in the global environment that match a certain naming pattern.
#'
#' @param dataset_pattern A string containing a regular expression to match the names of
#'   the datasets in the global environment. Use `dataset_pattern = ""` (the default) to
#'   search all objects. For more information on supported regular expressions, see
#'   \href{https://stat.ethz.ch/R-manual/R-devel/library/base/help/regex.html}{R's regex documentation}.
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
#' get_vars_by_pattern(dataset_pattern = "^fake_snacn_ph", var_pattern = "^ph")
#' }
#'
#' @export
get_vars_by_pattern <- function(dataset_pattern = "",
                                var_pattern = NULL) {
  if (missing(var_pattern) || is.null(var_pattern) || !nzchar(var_pattern)) {
    stop("`var_pattern` must be a non-empty string.", call. = FALSE)
  }

  objs <- ls(envir = .GlobalEnv, pattern = dataset_pattern)

  if (length(objs) == 0) {
    message("No datasets found matching pattern: ", dataset_pattern)
    return(NULL)
  }

  result <- list()

  for (name in objs) {
    df <- get(name, envir = .GlobalEnv)

    if (!is.data.frame(df)) next

    matches <- grep(var_pattern, names(df), value = TRUE)

    if (length(matches) > 0) {
      result[[name]] <- matches
    }
  }

  if (length(result) == 0) {
    message("No variables found matching pattern: ", var_pattern)
    return(NULL)
  }

  return(result)
}
