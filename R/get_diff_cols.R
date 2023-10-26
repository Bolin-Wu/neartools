#' Get the columns with different values
#'
#' When we received data files, some rows contain duplicated IDs. This is a problem as ID should be unique.
#' This function finds the columns with different values by comparing the two records with the same ID.
#' \itemize{
#'   \item It is useful for deciding which row to keep when we find there are two duplicated IDs (e.g. after using \code{get_dup_id()}.
#'   \item This function conquers the problem 'NA' values when comparing the columns. Most available functions by default returns 'NA' as long as there is any missing value in the columns. However, we also want to know the columns that one record gives "NA" and the other has values.
#' }
#'
#' @param data_file A file contain duplicated IDs.
#' @param id_str A string that contains ID name. E.g. "lopnr".
#' @param id_num A specific ID that the user want to examine.
#'
#' @return It returns a tibble with columns containing different values.
#'
#' @examples
#' \dontrun{
#' dup_id <- get_dup_id(df = df_dup_id, id_str = "id")$replicated_id
#' get_diff_cols(data = df_dup_id, id_str = "id", id_num = dup_id[1])
#' }
#'
#' @importFrom magrittr %>%
#' @importFrom purrr pmap_lgl
#' @importFrom dplyr filter_at
#' @importFrom dplyr all_of
#' @importFrom dplyr select
#'
#' @note This function can only compare 2 rows. It does not work if an ID is duplicated for more than 2 rows.
#'
#' @export
get_diff_cols <- function(data_file, id_str, id_num) {
  data_dupid <- data_file %>% dplyr::filter_at(vars(contains(id_str)), ~ . == id_num)
  ## Select the rows 1 and 2 and compare them
  ## for now it can only compare two rows
  row_i <- data_dupid[1, ]
  row_j <- data_dupid[2, ]

  ## Use pmap to compare rows element-wise
  differing_columns <- purrr::pmap_lgl(list(row_i, row_j), check_unequal)
  ## class(differing_columns) is logical

  ## Use select to filter differing columns
  result <- names(differing_columns[differing_columns])
  diff_col_name <- result[!is.na(result)] # drop NAs
  diff_col_tibb <- data_dupid %>% select(contains(id_str), dplyr::all_of(diff_col_name))

  return(diff_col_tibb)
}



# find differing columns --------------------------------------------------
## self-defined function that given a tibble and 2 row indexes i and j of that tibble,
## returns all the columns where these rows differ
check_unequal <- function(x, y) {
  case_when(
    ## if neither of x and y is NA, then compare them
    all(!is.na(x), !is.na(y)) ~ x != y,
    ## if only one of them is NA, then return TRUE (unequal)
    xor(is.na(x), is.na(y)) ~ TRUE,
    ## if both of them is NA, then return FALSE (equal)
    all(is.na(x), is.na(y)) ~ FALSE
  )
}
