#' @title get_pretty_template
#' @description Use rmd templates to start analysis in R. More specifically, it creates a new folder at root of project and create a nice-looking template there.
#' @param name Name of rmd file. Please do not use '/' in the the file name (no need to add suffix ".Rmd").
#' @param subDir Name of the folder where rmd file will be created. Remember to connect sub-dir names with '/'. By default it is 'rmd'.
#' @param open Should the file be opened after being created
#' @param output_file "word" or "html", by default it is "html"
#' @param ... Arguments to be passed to \link[usethis]{use_template}
#' @importFrom usethis use_template
#' @importFrom here here
#' @examples
#' \dontrun{
#'  neartools::get_pretty_template(subDir = 'Enquiry/SNAC',name = "missing_value_problems",output_file = "word")
#' }
#'
#' @export
get_pretty_template <-
  function(name = NULL,
           subDir = 'rmd',
           output_file = "html",
           open = interactive(),
           ...) {
    if (is.null(name)) {
      name <- "analysis.Rmd"
    } else {
      name <- paste0(name, ".Rmd")
    }

    # create a folder for Rmd
    if (dir.exists(subDir)) {
      message("folder:", subDir," already exists.")
    } else {
      message("Create folder: ", subDir, ".")
      dir.create(subDir,  showWarnings = TRUE, recursive = TRUE)
    }

    # usethis::use_package("usethis")
    if (output_file == "html") {
      usethis::use_template("skeleton_html.Rmd",
        save_as = paste0(subDir, "/",name),
        data = list(),
        package = "neartools", ..., open = open
      )
    } else if (output_file == "word") {
      usethis::use_template("skeleton_word.Rmd",
        save_as = paste0(subDir, "/",name),
        data = list(),
        package = "neartools", ..., open = open
      )
    } else {
      stop("The 'output_file' should be 'html' or 'word'")
    }
  }
