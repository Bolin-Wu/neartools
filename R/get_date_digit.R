#' Inspect the a date column's digit
#'
#' When we received files with date variables, sometimes they are not in good 'date' format. Instead, they might be in pure numeric values with different digits.
#' In such case, we have to check if they are ideal eight-digit number or not. Some digits may just not make sense and have to ask DBM about them.
#' This function aims to make such inspection easier.
#'
#'
#' @param df_arg Input data frame.
#' @param id_string A string contained in ID's column name.
#' @param date_string A string contained in date's column name.
#' @param required_digits The expected date's digit.
#'
#' @details Given a data frame, strings containing ID and date columns' name, and required digits, users can find the observations with wrong digits.
#'
#' The \code{date_string} argument should lead to a unique date column. This function only supports inspect one date column at one time.
#'
#'
#' @import tibble
#' @importFrom magrittr %>%
#' @importFrom glue glue
#' @return A lit with two elements:
#'   \item{count_digit}{A tibble of ID, date and date's digits.}
#'   \item{wrong_digit}{A tibble of dates that do not have required digits.}
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' date_digit_info = get_date_digit(df_arg = fake_snack_df,
#' id_string = "Lop",
#' date_string = "numeric_date",
#' required_digits = 8)
#'
#' # get the digits
#' date_digit_info$count_digit
#'
#' # get the wrong dates
#' date_digit_info$wrong_digit
#'
#' }
#'
get_date_digit <- function(df_arg, id_string, date_string, required_digits) {
  if (is_tibble(df_arg)) {
    message(glue::glue("Checking the dataframe: {deparse(substitute(df_arg))}"))
    df <- df_arg
  } else if (is.character(df_arg)) {
    message(glue::glue("Checking the dataframe: {df_arg}"))
    df <- get(df_arg)
  } else {
    stop("Invalid argument. Must be either a data frame or a string representing a data frame name.")
  }
  num_date_with_string <- sum(grepl(date_string, colnames(df)))
  num_id_with_string <- sum(grepl(id_string, colnames(df)))
  if (num_date_with_string != 1) {
    stop(glue::glue("The '{date_string}' can not identify a unique date column."))
  }
  if (num_id_with_string != 1) {
    stop(glue::glue("The '{id_string}' can not identify a unique id column."))
  }
  df_digit <- df %>%
    select(contains({{ id_string }}), contains({{ date_string }})) %>%
    mutate(digits_count = nchar(as.character(.[[2]])))
  df_wrong_digit <- df_digit %>%
    filter(digits_count != required_digits)
  return(list(
    count_digit = df_digit,
    wrong_digit = df_wrong_digit
  ))
}
