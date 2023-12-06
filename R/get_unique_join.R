#' Get the unique join of multiple tables
#'
#' This function joins multiple tibbles and generates unique columns to record non-NA values when there are identical column names.
#'
#' The motivation to create this function is that when Bolin extract SNAC-N variables, he finds that for wave 3, there are overlapping information
#' from different sources.
#'
#' For example, for physician variables, there are 3 files:
#' \itemize{
#'   \item All wave 3 participants.
#'   \item Only cohort 1's follow-up at wave 3.
#'   \item Only cohort 2's baseline.
#' }
#'
#' There are overlapping of both participants and variables.
#' In addition, for the same participant and same variable, some are NA in one file whereas not NA in the other file.
#' If only using a join function, the common columns will be separated to '.x' and '.y'. And we have to use \code{coalesce()} to pick one without NA. And then we delete the '.x' and '.y'  columns.
#'
#' To avoid repetitive work, Bolin is writing this function to take in the information from different data files.
#'
#' @param tibble_names A vector of tibbles' names in your R environment.
#' @param join_type It should be one of 'full_join', 'left_join', 'inner_join'.
#' @param by_col The column that you would like join on. For example the ID column.
#'
#' @return A tibble contains unique columns to record non-NA values for identical column names.
#'
#' @importFrom stringr str_subset
#' @import tibble
#' @import dplyr
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' ## fake_snacn_ph_wave3 and fake_snacn_ph_fu contains same variable 'ph121'.
#' ## but for some obs, in one file in NA, in the other file is not NA. E.g. Lopnr = 10
#' ## let's just combine the info together and only keep the one without NA.
#'
#' get_unique_join(tibble_names = c("fake_snacn_ph_wave3", "fake_snacn_ph_fu"),
#'                 join_type = "full_join",
#'                 by_col = "Lopnr")
#' }
#'
get_unique_join <- function(tibble_names, join_type, by_col) {
  if (!join_type %in% c("full_join", "left_join", "inner_join")) {
    stop("The 'join_type' has to be one of 'full_join', 'left_join', 'inner_join'")
  }

  left_tibb <- get(tibble_names[1])

  for (i in 2:length(tibble_names)) {
    ## get the other tibble that are to be joined with the left_tibb
    tibb_2 <- tibble_names[i]
    common_columns <- intersect(names(left_tibb), names(get(tibb_2)))
    ## remove the id column, set the negate = T
    common_columns <- str_subset(string = common_columns, pattern = by_col, negate = T)
    ## use different join types
    if (join_type == "full_join") {
      unique_join_tibb <- left_tibb %>%
        full_join(get(tibb_2), by = {{ by_col }})
    } else if (join_type == "inner_join") {
      unique_join_tibb <- left_tibb %>%
        inner_join(get(tibb_2), by = {{ by_col }})
    } else if (join_type == "left_join") {
      unique_join_tibb <- left_tibb %>%
        left_join(get(tibb_2), by = {{ by_col }})
    }

    for (col_i in common_columns) {
      # print(col_i)
      ## define the duplicated names with suffix .x and .y
      dup_names <- c(paste0(col_i, ".x"), paste0(col_i, ".y"))
      unique_join_tibb <- unique_join_tibb %>%
        ## create a column as long as there is no NA
        mutate(!!col_i := coalesce(as.character(!!sym(dup_names[1])), as.character(!!sym(dup_names[2])))) %>%
        select(-all_of(dup_names))
    }
  }
  return(unique_join_tibb)
}
