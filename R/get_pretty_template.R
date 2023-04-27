#' @title get_pretty_template
#' @description Automatically create & open an rmd file with a nice looking template. This facilitates the communication with researchers & tracking the records. User can choose output file to be word”, “pdf” or “html”. By default it complies an “word” file.
#' @param name Name of rmd file. Please do not use '/' in the the file name (no need to add suffix ".Rmd").
#' @param subDir Name of the folder where rmd file will be created. Remember to connect sub-dir names with '/'. By default it is 'rmd'.
#' @param open Should the file be opened after being created
#' @param output_file The output file's type. It could be "word", "pdf" or "html", by default it is "word"
#' @param ... Arguments to be passed to \link[usethis]{use_template}
#' @importFrom usethis use_template
#' @importFrom here here
#' @examples
#' \dontrun{
#' neartools::get_pretty_template(
#'   subDir = "Enquiry/SNAC",
#'   name = "snac_k_inspection",
#'   output_file = "word"
#' )
#' }
#'
#' @export
get_pretty_template <-
  function(name = NULL,
           subDir = "rmd",
           output_file = "word",
           open = interactive(),
           ...) {
    if (is.null(name)) {
      name <- "analysis.Rmd"
    } else {
      name <- paste0(name, ".Rmd")
    }

    # create a folder for Rmd
    if (dir.exists(subDir)) {
      message("folder:", subDir, " already exists.")
    } else {
      message("Create folder: ", subDir, ".")
      dir.create(subDir, showWarnings = TRUE, recursive = TRUE)
    }

    # usethis::use_package("usethis")
    if (output_file == "html") {
      usethis::use_template("skeleton_html.Rmd",
        save_as = paste0(subDir, "/", name),
        data = list(),
        package = "neartools", ..., open = open
      )
    } else if (output_file == "word") {
      usethis::use_template("skeleton_word.Rmd",
        save_as = paste0(subDir, "/", name),
        data = list(),
        package = "neartools", ..., open = open
      )
    } else if (output_file == "pdf") {
      usethis::use_template("skeleton_pdf.Rmd",
        save_as = paste0(subDir, "/", name),
        data = list(),
        package = "neartools", ..., open = open
      )
    } else {
      stop("The 'output_file' should be 'html', 'pdf' or 'word'")
    }
  }
