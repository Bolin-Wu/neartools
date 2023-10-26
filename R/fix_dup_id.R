#' Find replicated id in a data file
#'
#' In NEAR, we use ID (lopnr) to identify a specific participant. If two people share the same ID, there must be a problem.
#' This function is used to:
#' \itemize{
#'   \item Check if a data file has replicated ID.
#'   \item If there is replicated id, find out which IDs are replicated. Generate new distinct new id & append it before the original ID column.
#' }
#' The new ID can be temporarily used as primary key when importing data to MySQL.
#'
#' @param df A tibble to be examined.
#' @param id_str A string that should contain ID name. E.g. "lopnr".
#'
#' @return A list with examination results
#' \itemize{
#'   \item logic_rep: If df has replicated ID or not.
#'   \item replicated_id: Specific replicated ID. May need to report them to local DBM.
#' }
#' @export
#'
#' @importFrom magrittr %>%
#' @importFrom stringr str_detect
#' @import dplyr
#' @import tibble
#'
#'
#' @examples
#' \dontrun{
#' neartools::get_dup_id(df_fix_dup_id, id_str = "id")
#' }
#'
get_dup_id <- function(df, id_str) {
  Freq <- NULL # make 'Freq' to be a function specific variable.
  df_name <- deparse(substitute(df))
  df_colnames <- colnames(df)
  # check the existance of id_str
  check_id_str <- stringr::str_detect(df_colnames, id_str)
  if (!any(check_id_str)) {
    stop(paste0("Can not find id column contains: ", id_str))
  }
  # check only one column contains id_str
  if (length(df_colnames[check_id_str]) > 1) {
    stop(paste("There are more than 1 columns contain string: ", id_str))
  }
  # select the column of id
  id_nr <- df_colnames[check_id_str]

  if (any(is.na(df[[id_nr]]))) {
    stop("There is NA in ID column.")
  }

  if (length(unique(df[[id_nr]])) == length(df[[id_nr]])) {
    stop("There is no duplicated id!")
  } else {
    message(paste0("There is duplicated id in the file: ", df_name))
  }
  # freq table of column contains "lopnr"
  n_occur <- data.frame(table(
    df %>%
      select(all_of(id_nr))
  ))
  colnames(n_occur) <- c("id", "Freq")

  # filter out replicated id
  freq_tab <- n_occur[n_occur$Freq > 1, ]
  # find the replicated id
  rep_id <- freq_tab$id
  # store new lopnr
  new_lopnr <- c()
  i <- 1
  while (i <= nrow(df)) {
    id_check <- as.numeric(df[i, id_nr])
    if (!id_check %in% rep_id) {
      new_lopnr[i] <- id_check
      i <- i + 1
    } else if (id_check %in% rep_id) {
      rep_freq <-
        freq_tab %>%
        filter(id == id_check) %>%
        pull(Freq)
      i <- i + rep_freq
    }
  }
  # convert rep_id from factor to numeric
  rep_id = as.numeric(as.character(rep_id))
  return(list(
    logic_rep = !length(unique(df[[id_nr]])) == length(df[[id_nr]]),
    replicated_id = rep_id
  ))
}
