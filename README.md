
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->
[![R-CMD-check](https://github.com/Bolin-Wu/neartools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Bolin-Wu/neartools/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Bolin-Wu/neartools/branch/master/graph/badge.svg)](https://app.codecov.io/gh/Bolin-Wu/neartools?branch=master)
<!-- badges: end -->

![](man/figures/country_map.jpeg)<!-- -->

# Motivation

There are many repetitive works when doing data harmonization and
keeping track of communication with researchers.

The goal of this package is to practice the “don’t repeat yourself”
(DRY) principle, making the daily work more handy.

# Tools

This package contains functions as follows:

-   `get_label_df`: Get the labels of a dataframe. By filtering on the
    result, the users can quickly select the interested variables.

-   `get_na_number`: **An extension of `get_label_df()`**. It counts the
    number of NAs given a string snippet of variable or label names. It
    is useful to inspect the variables with unexpected number of NAs.

-   `get_pretty_template`: Automatically create & open an rmd file with
    a nice looking template. This facilitates the communication with
    researchers & tracking the records. By default it complies an *html*
    file.  
    For more information about R markdown please see
    [here](https://rmarkdown.rstudio.com).

-   `get_date_digit`: Get a date column’s digit and find dates not
    having required digits.

-   `fix_dup_id`: Check existence of ID duplication and pinpoint them.

-   `export_sav_to_csv`: Convert all the SPSS data files (*.sav*) to csv
    files. This conversion is needed because the maelstrom harmonization
    package does not read *.sav* data. This function can prevent
    repetitive work of converting *.sav* to *.csv* one by one.

-   `import_bulk`: Bulk import SPSS, STATA and MS Excel files to R
    global environment.

-   *To be continued….*

## Installation

You can install the development version of neartools from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Bolin-Wu/neartools", force = TRUE)
```

## Example

### The `get` family

``` r
# load the package
library(neartools)

# get the label of SPSS and STATA files imported in R
get_label_df(df_w_label = fake_snack_df)

# get the date digits and find wrong ones
get_date_digit(df_arg = fake_snack_df, 
               id_string = "Lop", 
               date_string = "numeric_date", 
               required_digits = 8)

# get NA counts from label data frame above
label_df <- get_label_df(fake_snack_df)
get_na_number(data_df = fake_snack_df, label_df = label_df, keywords_label = "dementia")

# create & open a rmd file 
get_pretty_template(name = "Reply to Prof XXX", output_file = "word")
```

### The `fix` family

``` r
# check ID duplication
fix_dup_id(df = baseline_example_Relative_220504, id_str = "lopnr")
```

### The `import` and `export` family

``` r
# convert SPSS files
export_sav_to_csv("original_data", "SNAC-K")

# bulk import
db_dir <- here("data", "raw","SNAC-K")
# this import all csv, sav and dta files in the 'db_dir'
import_bulk(data_dir = db_dir)
# this import only a specific type files
import_bulk(data_dir = db_dir, file_type = 'sav')
```
