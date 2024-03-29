% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fix_dup_id.R
\name{get_dup_id}
\alias{get_dup_id}
\title{Find replicated id in a data file}
\usage{
get_dup_id(df, id_str)
}
\arguments{
\item{df}{A tibble to be examined.}

\item{id_str}{A string that contains ID name. E.g. "lopnr".}
}
\value{
A list with examination results
\itemize{
  \item logic_rep: If df has replicated ID or not.
  \item replicated_id: Specific replicated ID. May need to report them to local DBM.
}
}
\description{
In NEAR, we use ID (lopnr) to identify a specific participant. If two people share the same ID, there must be a problem.
This function is used to:
\itemize{
  \item Check if a data file has replicated ID.
  \item If there is replicated id, find out which IDs are replicated.
}
}
\examples{
\dontrun{
neartools::get_dup_id(df_dup_id, id_str = "id")
}

}
