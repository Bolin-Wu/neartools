#' Get labels of a dataset
#'
#' During work, many times we receive SPSS or STATA data files with labels. This function is to extract the labels from the read-in data, turn them in tibble format.
#' This can help us to inspect data more conveniently.
#'
#' @param df_w_label A data set with labels. One can read SPSS or STATA files with \code{haven} package.
#' @importFrom sjlabelled get_label
#' @import tibble
#' @return A tibble with variable and label names
#'
#' @export
#' @examples
#' \dontrun{
#' get_label_df(fake_snack_df)
#' }
#'
get_label_df <- function(df_w_label) {
  message("The input df is: ", df_w_label)
  label_char <- sjlabelled::get_label(df_w_label)
  label_df <- tibble::rownames_to_column(as.data.frame(label_char), "variable")
  label_df <- tibble::as_tibble(label_df)
  return(label_df)
}
