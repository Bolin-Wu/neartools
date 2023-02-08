#' Get NA number of a dataset
#'
#' Given the data set and its label data frame, user can search for number of NA with strings in the variable names or labels.
#'
#' @param data_df The data frame, preferably tibble.
#' @param label_df The lable of data frame. Get it by \code{neartools::get_label_df(data_df)}.
#' @param keywords_label Keywords in the label.
#' @param keywords_variable Keywords in the column names.
#'
#' @return A list of related variables and their NA counts.
#' @details The \code{grepl()} function is doing the search for the two keywards arguments.
#'
#' @export
#'
#' @importFrom magrittr %>%
#' @import dplyr
#'
#' @examples
#' \dontrun{
#'
#' # create label dataframe from original data set
#' label_df <- get_label_df(fake_snack_df)
#'
#' # search by label
#' get_na_number(data_df = fake_snack_df, label_df = label_df, keywords_label = "dementia")
#'
#' # search by variable name
#' get_na_number(data_df = fake_snack_df, label_df = label_df, keywords_variable = "edu")
#' }
#'
get_na_number <- function(data_df, label_df = NULL, keywords_label = NULL, keywords_variable = NULL) {
  # label_df is a result from the label_tiff above
  # give error if both keywords arguments are NULL.
  if (is.null(keywords_label) & is.null(keywords_variable)) {
    stop("Please input keywards for label or variables." )
  }

  if (is.null(label_df)) {
    stop("Please input label dataframe.")
  }

  label_char <- colnames(label_df)[2]
  # only label key words available
  if (!is.null(keywords_label) & is.null(keywords_variable)) {
    message("Search for label key words: ", keywords_label)
    filter_x <- label_df %>% filter(grepl(pattern = keywords_label, label_char))
    # calculate the number of NAs
    NA_df <- data_df %>%
      summarise(across(filter_x %>%
        pull(variable), ~ sum(is.na(.))))
  }
  # only variable key words available
  if (!is.null(keywords_variable) & is.null(keywords_label)) {
    message("Search for variable key words: ", keywords_variable)

    filter_x <- label_df %>%
      filter(grepl(pattern = keywords_variable, variable))
    NA_df <- data_df %>%
      summarise(across(filter_x %>%
        pull(variable), ~ sum(is.na(.))))
  }
  # both variable and label key words available
  if (!is.null(keywords_variable) & !is.null(keywords_label)) {
    message("Search for variable key words: ", keywords_variable)
    message("Search for label key words: ", keywords_label)

    filter_x <- label_df %>%
      filter(grepl(pattern = keywords_variable, variable) & grepl(pattern = keywords_label, label_char))

    NA_df <- data_df %>%
      summarise(across(filter_x %>%
        pull(variable), ~ sum(is.na(.))))
  }

  return(list(
    "related_variables" = filter_x,
    "NA_number" = NA_df
  ))
}
