#' @title get_pretty_template
#' @description Use the skeleton.Rmd for starting analysis. This function creates a new folder "rmd" at root of project and create an rmd file with nice-looking template there.
#' @param name name of rmd file. (no need to add suffix ".Rmd")
#' @param open should the file be opened after being created
#' @param output_file "word" or "html", by default it is "html"
#' @param ... arguments to be passed to \link[usethis]{use_template}
#' @importFrom usethis use_template
#' @importFrom here here
#' @examples
#' \dontrun{
#' neartools::get_pretty_template(name = "Reply to Prof")
#' }
#'
#' @export
get_pretty_template <-
  function(name = NULL,
           output_file = "html",
           open = interactive(),
           ...) {
    if (is.null(name)) {
      name <- "analysis.Rmd"
    } else {
      name <- paste0(name, ".Rmd")
    }

    # create a folder for Rmd
    subDir <- "rmd"
    if (dir.exists(subDir)) {
      message("'rmd' folder already exists.")
    } else {
      message("Create folder 'rmd'.")
      dir.create(subDir, showWarnings = FALSE)
    }

    # usethis::use_package("usethis")
    if (output_file == "html") {
      usethis::use_template("skeleton.Rmd",
        save_as = paste0("rmd/", name),
        data = list(),
        package = "neartools", ..., open = open
      )
    } else if (output_file == "word") {
      usethis::use_template("skeleton_word.Rmd",
        save_as = paste0("rmd/", name),
        data = list(),
        package = "neartools", ..., open = open
      )
    } else {
      stop("The 'output_file' should be 'html' or 'word'")
    }
  }
