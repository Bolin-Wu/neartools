#' Get all columns of several input data frames
#'
#' This functions gathers columns of several data files to examine them all together.
#'
#'
#' @import tibble
#' @importFrom magrittr %>%
#' @importFrom dplyr bind_rows
#'
#' @param df_name A vector of data files' names. It has to be strings.
#'
#' @return A list with two elements:
#'   \item{names}{A tibble of files' names, index and their columns.}
#'   \item{n_files}{A tibble of column number for each data file.}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # read data to the global environment
#' fake_snack_df <- neartools::fake_snack_df
#' fake_caide_df <- neartools::fake_caide_df
#'
#' # put these two files together and check their columns
#' df_files <- c("fake_snack_df", "fake_caide_df")
#' neartools::get_all_colnames(df_name = df_files)
#'
#' # One can also use ls() and str_subset() function to
#' # extract interested data files from the global environment
#' # for example if you want to take patterns like
#' "SNAC_K_BMI_baseline", "SNAC_K_BMI_FU1","SNAC_K_BMI_FU2":
#' df_files <- str_subset(ls(), "^SNAC_K.*_(FU|baseline)*[1-9]*$")
#' }
get_all_colnames <- function(df_name = NULL) {
  if (is.null(df_name)) {
    stop("Please specify df_name.")
  }
  # stopifnot("At least 1 object in the df_name does not exist in the global environment." = df_name %in% ls())
  if (!all(df_name %in% ls(envir = .GlobalEnv))) {
    stop("At least 1 object in the df_name does not exist in the global environment.")
  }
  # check if the input is string type
  if (!is.character(df_name)) {
    stop("Invalid argument. 'df_name' must be a string.")
  }
  # n = number of columns in a df
  n <- 0
  # col_name stores the columns' names in a df
  col_name <- c()
  # tibble_meta collects index, df_name and col_name
  meta_tibble <- tibble(file_name = character(), index = numeric(), col_name = character())
  for (i in 1:length(df_name)) {
    df <- get(df_name[i])
    n <- ncol(df)
    col_name <- colnames(df)
    tibble_i <- tibble(file_name = df_name[i], index = 1:n, col_name = col_name)
    meta_tibble <- meta_tibble %>% bind_rows(tibble_i)
  }
  n_files <- meta_tibble %>%
    count(file_name) %>%
    rename(col_count = n)
  return(list(
    names = meta_tibble,
    n_files = n_files
  ))
}