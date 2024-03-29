% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_pretty_template.R
\name{get_pretty_template}
\alias{get_pretty_template}
\title{get_pretty_template}
\usage{
get_pretty_template(
  name = NULL,
  subDir = "rmd",
  output_file = "word",
  open = interactive(),
  ...
)
}
\arguments{
\item{name}{Name of rmd file. Please do not use '/' in the the file name (no need to add suffix ".Rmd").}

\item{subDir}{Name of the folder where rmd file will be created. Remember to connect sub-dir names with '/'. By default it is 'rmd'.}

\item{output_file}{The output file's type. It could be "word", "pdf" or "html", by default it is "word"}

\item{open}{Should the file be opened after being created}

\item{...}{Arguments to be passed to \link[usethis]{use_template}}
}
\description{
Automatically create & open an rmd file with a nice looking template. This facilitates the communication with researchers & tracking the records. User can choose output file to be word”, “pdf” or “html”. By default it complies an “word” file.
}
\examples{
\dontrun{
neartools::get_pretty_template(
  subDir = "Enquiry/SNAC",
  name = "snac_k_inspection",
  output_file = "word"
)
}

}
