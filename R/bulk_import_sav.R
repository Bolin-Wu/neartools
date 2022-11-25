
#' Bulk import SPSS(sav) data into R
#'
#' Many NEAR databases stroe data in SPSS. Therefore chances are that we need
#' to import many SPSS files at a time in R for further analysis.
#'
#'
#' @param data_dir The folder storing SPSS files.
#' @note \code{here} function is a fast and neat way of defining data directory (*data_dir*).
#'
#'
#' @return 1. Import SPSS files in `data_dir` to R global environment;
#' 2. List names of tables imported to R.
#'
#' @importFrom tools file_path_sans_ext
#' @importFrom utils write.csv
#' @importFrom haven read_sav
#' @importFrom here here
#'

#'
#' \dontrun{
#' # assume data files are in folder 'data/raw/SNAC-K'
#' db_dir <- here("data", "raw","SNAC-K")
#' bulk_import_csv(data_dir = db_dir)
#' }
#'
#' @export
#'
#'
bulk_import_csv = function(data_dir = NULL){
  if (is.null(data_dir)) {
    stop("There is no input for data directory.")
  }

  tb_name <- list.files(path = data_dir, pattern = "\\.sav$")
  # get rid of .sav extension when writing the csv file
  clean_name <- tools::file_path_sans_ext(tb_name)
  # replace space and '-' with underscore
  clean_name = gsub(" |-", "_", clean_name)
  for (i in 1:length(tb_name)) {
    assign(clean_name[i],
           read_sav(here(data_dir,tb_name[i])),
           envir = .GlobalEnv)
  }
  return(list(tb_name = clean_name))
}
