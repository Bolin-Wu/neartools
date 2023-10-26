#' Bulk import SPSS(sav) and STATA(dta), MS Excel(csv) Rdata and RDS files into R
#'
#' Many NEAR databases stroe data in SPSS or STATA and MS Excel. Therefore chances are that we need
#' to import many different files at a time in R for further analysis.
#' This function is to bulk import data files of types mentioned above into R environment.
#'
#'
#' @param data_dir The folder storing data files.
#' @param file_type The data file type. Options could be 'sav' or 'dta', 'csv', 'Rdata' or 'rds'. Default is 'all'.
#' \itemize{
#'   \item sav uses \code{read_sav()} from 'haven' package.
#'   \item dta uses \code{read_dta()} from 'haven' package.
#'   \item csv uses \code{read.csv()} from 'utils' package.
#'   \item xlsx uses \code{read_excel()} from 'readxl' package.
#'   \item Rdata and rds uses \code{readRDS()} and \code{load()} from R base.
#'   \item The default 'all' imports all five kinds of data.
#' }
#' @note
#' * \code{here} function is a fast and neat way of defining data directory `data_dir`.
#' * Be careful when importing the csv files. It could be messy since this function just uses default parameters of \code{read.csv()}.
#' * For 'Rdata' files, it can read 'Rdata', 'RData', "rdata".
#' * For 'Rds' files, it can read 'Rds' or 'rds'.
#'
#'
#' @return Two results as follows:
#' * Import SPSS files in `data_dir` to R global environment;
#' * List names of tables imported to R.
#' @md
#'
#' @importFrom tools file_path_sans_ext
#' @importFrom utils write.csv read.csv
#' @importFrom haven read_sav read_dta
#' @importFrom here here
#' @importFrom readxl read_excel
#'
#' @examples
#' \dontrun{
#' # Assume the data files are in path:'data/raw/SNAC-K'
#' db_dir <- here("data", "raw", "SNAC-K")
#'
#' # this import all csv, sav and dta files in the 'db_dir'
#' import_bulk(data_dir = db_dir)
#'
#' # this import only a specific type files
#' import_bulk(data_dir = db_dir, file_type = "sav")
#' }
#'
#' @export
#'
#'

import_bulk <- function(data_dir = NULL, file_type = "all") {
  if (is.null(data_dir)) {
    stop("There is no input for data directory.")
  }
  if (!file_type %in% c("all", "sav", "dta", "csv", "xlsx", "Rdata", "rds")) {
    stop("Invalid file type. It has to be one of 'all','sav', 'dta', 'csv','xlsx', 'Rdata','rds'.")
  }
  if (file_type == "sav") {
    tb_name <- list.files(path = data_dir, pattern = "\\.sav$")
  }
  if (file_type == "dta") {
    tb_name <- list.files(path = data_dir, pattern = "\\.dta$")
  }
  if (file_type == "csv") {
    tb_name <- list.files(path = data_dir, pattern = "\\.csv$")
  }
  if (file_type == "xlsx") {
    tb_name <- list.files(path = data_dir, pattern = "\\.xlsx$")
  }
  if (file_type == "Rdata") {
    tb_name <- list.files(path = data_dir, pattern = "\\.[Rr][Dd]ata$")
  }
  if (file_type == "all") {
    tb_name <- list.files(path = data_dir, pattern = ".*(sav|dta|csv|xlsx|[Rr][Dd][at]*a|[Rr]ds)+$")
  }
  # report error if can not get any table
  stopifnot("Can not find relevant data files." = length(tb_name) > 0)
  # get rid of .sav extension when writing the csv file
  clean_name <- tools::file_path_sans_ext(tb_name)
  # replace space and '-' with underscore
  clean_name <- gsub(" |-", "_", clean_name)
  # import files
  for (i in 1:length(tb_name)) {
    if (grepl(".*sav$", tb_name[i])) {
      assign(clean_name[i],
        read_sav(here(data_dir, tb_name[i])),
        envir = .GlobalEnv
      )
    } else if (grepl(".*dta$", tb_name[i])) {
      assign(clean_name[i],
        read_dta(here(data_dir, tb_name[i])),
        envir = .GlobalEnv
      )
    } else if (grepl(".*csv$", tb_name[i])) {
      assign(clean_name[i],
        read.csv(here(data_dir, tb_name[i])),
        envir = .GlobalEnv
      )
    } else if (grepl(".*xlsx$", tb_name[i])) {
      assign(clean_name[i],
        read_excel(here(data_dir, tb_name[i]), sheet = 1),
        envir = .GlobalEnv
      )
    } else if (grepl(".*[Rr][Dd]ata$", tb_name[i])) {
      assign(clean_name[i],
        get(load(here(data_dir, tb_name[i]))),
        envir = .GlobalEnv
      )
    } else if (grepl(".*[Rr]ds$", tb_name[i])) {
      assign(clean_name[i],
        get(readRDS(here(data_dir, tb_name[i]))),
        envir = .GlobalEnv
      )
    }
  }
  return(list(tb_name = clean_name))
}
