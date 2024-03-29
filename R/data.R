#' Example data frame
#'
#' A data frame to test the \code{get_dup_id} function in package.
#'
#' @format A data frame with 2 variables: \code{id}, \code{num}.
"df_dup_id"


#' Fake SNAC-K data
#'
#' A randomized SNAC-K data set, with metadata preserved.
#'
#' Random values are generated by \code{rnorm()} and \code{sample()}.
#'
#' @format A data frame with 15 variables and 3365 random obs.
"fake_snack_df"


#' Fake CAIDE data
#'
#' A randomized CAIDE data set, with meta data preserved.
#'
#' Random values are generated by \code{vroom::gen_tbl}.
#'
#' @format A data frame with 27 variables and 1000 random obs.
"fake_caide_df"


#' Fake SNAC-N data 'fake_snacn_ph_fu'
#'
#' Simulated SNAC-N wave 3 data, but only for cohort 1 follow-up. ID is up to 800.
#'
#' @format A data frame with 4 variables and 800 observations
"fake_snacn_ph_fu"

#' Fake SNAC-N data 'fake_snacn_ph_wave3'
#'
#' Simulated SNAC-N wave 3 data, but for the whole wave 3. ID is up to 1000.
#'
#' @format A data frame with 4 variables and 800 observations
"fake_snacn_ph_wave3"
