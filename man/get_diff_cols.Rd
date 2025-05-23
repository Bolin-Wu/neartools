% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_diff_cols.R
\name{get_diff_cols}
\alias{get_diff_cols}
\title{Get the columns with different values}
\usage{
get_diff_cols(data_file, id_str, id_num)
}
\arguments{
\item{data_file}{A file contains duplicated IDs.}

\item{id_str}{A string that contains ID name. E.g. "lopnr".}

\item{id_num}{A specific ID that the user wants to examine.}
}
\value{
It returns a tibble with columns containing different values.
}
\description{
When we received data files, some rows contain duplicated IDs. This is a problem as ID should be unique.
This function finds the columns with different values by comparing the two records with the same ID.
\itemize{
  \item It is useful for deciding which row to keep when we find there are two duplicated IDs (e.g. after using \code{get_dup_id()}.
  \item This function conquers the problem 'NA' values when comparing the columns with the basic logical operators, e.g '==' and '!='. By default, they return 'NA' as long as there is any 'NA' value in the columns. However, we also want to know if the columns that one record gives "NA" and the other has values.
}
}
\note{
This function can only compare 2 rows. It does not work if an ID is duplicated for more than 2 rows.
}
\examples{
\dontrun{
dup_id <- get_dup_id(df = df_dup_id, id_str = "id")$replicated_id
get_diff_cols(data = df_dup_id, id_str = "id", id_num = dup_id[1])
}

}
