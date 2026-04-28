# Get all columns of several input data frames

This functions gathers columns of several data files to examine them all
together.

## Usage

``` r
get_all_colnames(df_name = NULL)
```

## Arguments

- df_name:

  A vector of data files' names. It has to be strings.

## Value

A list with two elements:

- metadata:

  A tibble of files' names, index and variables' names, labels and their
  missing values' percentage.

- n_files:

  A tibble of column number for each data file.

## Examples

``` r
if (FALSE) { # \dontrun{

# read data to the global environment

fake_snack_df <- neartools::fake_snack_df
fake_caide_df <- neartools::fake_caide_df

# put these two files together and check their columns

df_files <- c("fake_snack_df", "fake_caide_df")
neartools::get_all_colnames(df_name = df_files)

# One can also use ls() and str_subset() function to
# extract interested data files from the global environment
# for example if you want to take patterns like
# "SNAC_K_BMI_baseline", "SNAC_K_BMI_FU1","SNAC_K_BMI_FU2":

df_files <- str_subset(ls(), "^SNAC_K.*_(FU|baseline)*[1-9]*$")
} # }
```
