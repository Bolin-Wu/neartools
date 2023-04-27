#' Get labels of a dataset
#'
#' During work, many times we receive SPSS or STATA data files with labels. This function is to extract the labels from the read-in data, turn them in tibble format.
#' This can help us to inspect data more conveniently.
#'
#' @param df_w_label A data set with labels. One can read SPSS or STATA files with \code{haven} package.
#' @importFrom sjlabelled get_label
#' @importFrom glue glue
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr rename
#' @import tibble
#' @return A tibble with three columns:
#'   \item{variable}{The original variables' names.}
#'   \item{n_files}{The variables corresponding labels.}
#'   \item{na_percent}{Ratio of missing values.}
#'
#' @export
#' @examples
#' \dontrun{
#' get_label_df(fake_snack_df)
#' }
#'
get_label_df <- function(df_w_label) {
  if (is_tibble(df_w_label)) {
    df <- df_w_label
  } else if (is.character(df_w_label)) {
    df <- get(df_w_label)
  } else {
    stop("Invalid argument. Must be either a data frame or a string representing a data frame name.")
  }
  label_char <- sjlabelled::get_label(df)
  label_df <- tibble::rownames_to_column(as.data.frame(label_char), "variable")
  label_df <- tibble::as_tibble(label_df) %>% rename(
    variable = 1,
    label_char = 2
  )
  n_obs <- nrow(df_w_label)
  # get the NA ratio
  NA_df <- df_w_label %>%
    summarise(across(everything(), ~ sum(is.na(.)))) %>%
    pivot_longer(everything(),
      names_to = "variable", values_to = "na_count"
    ) %>%
    transmute(variable, na_percent = round(na_count / n_obs, 3))
  label_df <- label_df %>% left_join(NA_df, by = "variable")
  return(label_df)
}
