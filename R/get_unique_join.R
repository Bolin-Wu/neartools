#' Get the unique join of two tables
#'
#' This function joins 2 tibbles and generates unique columns to record non-NA values when there are 2 identical column names.
#'
#' The motivation to create this function is that when Bolin extracts SNAC-N variables, he finds that for wave 3, there is overlapping information
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
#' If only using a join function, the common columns will be separated to '.x' and '.y'. And we have to use \code{\link{coalesce}} to pick one without NA. And then we delete the '.x' and '.y'  columns.
#'
#' To avoid repetitive work, Bolin wrote this function to integrate information from different data files.
#'
#' @param tibble_names A vector of tibbles' names in your R environment.
#' @param join_type It should be one of 'full_join', 'left_join', 'inner_join'.
#' @param by_cols It should include the columns in a format that `\code{\link[dplyr]{join_by}}` can interpret.
#'
#' @return A tibble contains unique columns to record non-NA values for identical columns of two tables.
#'
#' @importFrom stringr str_subset
#' @import tibble
#' @importFrom rlang parse_expr
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
#'
#' left_join(fake_snacn_ph_wave3, fake_snacn_ph_fu, by = join_by(Lopnr == N1lopnr, age))
#'
#' ## let's just combine the info and only keep the one without NA.
#'
#'
#' get_unique_join(tibble_names = c("fake_snacn_ph_wave3", "fake_snacn_ph_fu"),
#'                join_type = "full_join",
#'                by_cols = "Lopnr == N1lopnr, age")
#' }
#'
get_unique_join <- function(tibble_names, join_type, by_cols) {
  if (!join_type %in% c("full_join", "left_join", "inner_join")) {
    stop("The 'join_type' has to be one of 'full_join', 'left_join', 'inner_join'")
  }

  if (grepl("(?<![=])=(?![=])", by_cols, perl = TRUE)) {
    stop("Error: Single equal sign '=' detected. Please use double equal signs '==' for comparisons in the argument `by_cols`.")
  }

  if (length(tibble_names) != 2) {
    stop("Please input two tibbles' names in the argument `tibble_names`.")
  }

  left_tibb <- get(tibble_names[1])
  right_tibb <- get(tibble_names[2])

  common_columns <- intersect(names(left_tibb), names(right_tibb))
  # by_cols = "Lopnr = Lopnr, age"
  by_vecnames <- strsplit(by_cols, ",|==|=")[[1]]
  by_vecnames <- unique(trimws(by_vecnames)) # Remove any extra spaces

  ## remove the columns to be joined on
  common_columns <- common_columns[!common_columns %in% by_vecnames]
  # Dynamically select the join function
  join_function <- match.fun(join_type)

  # Construct the join_by expression dynamically
  join_by_expr <- parse_expr(paste0("join_by(", by_cols, ")"))
  # Evaluate the join_by expression
  by <- eval(join_by_expr)

  unique_join_tibb <- left_tibb %>%
    join_function(right_tibb, by = by)

  for (col_i in common_columns) {
    # print(col_i)
    ## define the duplicated names with suffix .x and .y
    dup_names <- c(paste0(col_i, ".x"), paste0(col_i, ".y"))
    unique_join_tibb <- unique_join_tibb %>%
      ## create a column as long as there is no NA
      mutate(!!col_i := coalesce(as.character(!!sym(dup_names[1])), as.character(!!sym(dup_names[2])))) %>%
      select(-all_of(dup_names))
  }
  return(unique_join_tibb)
}
