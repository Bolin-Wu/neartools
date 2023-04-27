#' Fix the empty string in csv file
#'
#' When importing the csv file to MySQL workbench, if there is a cell with empty strings, the 'Wizard Import' function would skip that row.
#' To fix this problem, we need to replace the empty string with "NA" so that we can import all records into MySQL.
#'
#' @param df_name A tibble name in R. It should be a string.
#'
#' @note This replacement only applies to 'character' columns.
#'
#' @import dplyr
#' @importFrom magrittr %>%
#'
#' @return A tibble with empty strings are replaced as 'NA'.
#' @export
#'
#' @examples
#' \dontrun{
#' fix_empty_string("baseline_example_Nurse_220504")
#' }
fix_empty_string <- function(df_name) {
  df <- get(df_name)
  # replace the empty string (w/o space) as NA
  df <- df %>% mutate_if(is.character, list(~ na_if(., "")))
  return(df)
}
