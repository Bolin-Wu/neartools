#' Export the SPSS data files to csv files
#'
#' In Maelstrom harmonization package, there is a command 'mlstr_file_index_read()' to read all the study specific data sets.
#' It can read commonly used .csv, .dta files, but not .sav (SPSS) data.
#' Therefore this function can help the user to transform all sav data sets to csv data, instead of
#' using 'read_sav()' function to transform every data set one by one manually.
#'
#'
#' @note Please make sure that the `original_data` folder is in your current working directory.
#'
#' @details Assume you have a bunch of `.sav` files current working directory: "original_data/SNAC-K".
#' You may want to transform them to `.csv` files so that they can be recognized by Maelstrom harmonization package.
#'
#' After running this function, there should be a new folder "csv_format" storing the transformed SNAC-K csv files at "original_data/SNAC-K".
#'
#' @param data_folder_name The name of the folder where all the data are being stored.
#' @param db_name The name of specific database's folder, which is located in `data_folder_name`.
#' @param out_dir optional. The name of the output directory, instead of using <data_folder_name>/<db_name>/csv_format.
#'
#' @return A folder called "csv_format" will be generated in the 'db_name's folder, storing all the transformed csv files.
#'
#' @importFrom tools file_path_sans_ext
#' @importFrom utils write.csv
#' @importFrom haven read_sav
#' @importFrom here here
#' @importFrom glue glue
#'
#' @examples
#' \dontrun{
#' export_sav_to_csv("original_data", "SNAC_K")
#' }
#'
#' @export
#'
#'
#'
#'

export_sav_to_csv <- function(data_folder_name, db_name, out_dir = NULL) {
  db_dir <- here::here(data_folder_name, db_name)
  tb_name <- list.files(path = db_dir, pattern = "\\.sav$")
  # get rid of .sav extension when writing the csv file
  clean_name <- file_path_sans_ext(tb_name)
  # replace space with underscore
  clean_name <- gsub(" ", "_", clean_name)

  # depending on optional user argument output_folder, the function can write to output_folder instead of csv_format
  # use file.path to create a file path that is compatible on different OS.
  if (!is.null(out_dir)) {
    output_dir <- out_dir

    if (!dir.exists(output_dir)) {
      # create a folder to store the transformed csv format files
      dir.create(output_dir)
    } else {
      warning(glue("output_dir {output_dir} already exists!"))
    }
  } else {
    output_dir <- file.path(data_folder_name, db_name, "csv_format")

    if (!dir.exists(output_dir)) {
      # create a folder to store the transformed csv format files
      dir.create(output_dir)
    } else {
      warning("'csv_format' folder already exists!")
    }
  }



  for (i in 1:length(tb_name)) {
    # data = read_sav(paste0(data_folder_name,'/',db_name,'/',tb_name[i]))
    data <- read_sav(file.path(db_dir, tb_name[i]))
    write.csv(data, file = file.path(output_dir, paste0(clean_name[i], ".csv")), row.names = FALSE)
  }
}
