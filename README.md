
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->
[![R-CMD-check](https://github.com/Bolin-Wu/neartools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Bolin-Wu/neartools/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Bolin-Wu/neartools/branch/master/graph/badge.svg)](https://app.codecov.io/gh/Bolin-Wu/neartools?branch=master)
<!-- badges: end -->

![](man/figures/country_map.jpeg)<!-- -->

![](man/figures/project_map_movie.gif)<!-- -->

# Motivation

There are many repetitive works when doing data harmonization and
keeping track of communication with database managers and researchers.

The goal of this package is to practice the “don’t repeat yourself”
(DRY) principle, making the daily work more handy.

# Installation

You can install the development version of neartools from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Bolin-Wu/neartools", force = TRUE)
```

# Tools

Example data:

``` r
library(neartools)
# read data
fake_snack_df <- fake_snack_df
fake_caide_df <- fake_caide_df
```

This package contains functions as follows:

## R markdown templates

- `get_pretty_template`: Automatically create & open an rmd file with a
  nice looking template. This facilitates the communication with
  researchers & tracking the records. User can choose output file to be
  word”, “pdf” or “html”. By default it complies an “word” file.

``` r
# create & open a rmd file
get_pretty_template(
  subDir = "Enquiry/db",
  name = "Data_inspection_db",
  output_file = "word"
)
```

## Data inspection

- `get_label_df`: Get the labels of a data frame. By filtering on the
  result, the users can quickly select the interested variables and
  check their missing value percentages.

``` r
# get the label of SPSS and STATA files imported in R
label_df <- get_label_df(df_w_label = fake_snack_df)
```

- `get_date_digit`: Inspect date in numeric digit form. Filter dates not
  having required form.

``` r
# get the date digits and find wrong ones
get_date_digit(
  df_arg = fake_snack_df,
  id_string = "Lop",
  date_string = "numeric_date",
  required_digits = 8,
  required_leading_num = 1
)
```

- `get_all_colnames`: Gather multiple data files and examine their
  columns’ names, labels and missing value percentages together.

``` r
# get columns of all interested data files
df_files <- c("fake_snack_df", "fake_caide_df")
get_all_colnames(df_name = df_files)
```

## Data import and export

- `export_sav_to_csv`: Convert all the SPSS data files (*.sav*) to csv
  files. This conversion is needed because the maelstrom harmonization
  package does not read *.sav* data. This function can prevent
  repetitive work of converting *.sav* to *.csv* one by one.

``` r
# convert SPSS files
export_sav_to_csv("original_data", "SNAC-K")
```

- `import_bulk`: Bulk import SPSS, STATA and MS Excel files to R global
  environment.

``` r
# bulk import
db_dir <- here("data", "raw", "SNAC-K")
# this import all csv, sav and dta files in the 'db_dir'
import_bulk(data_dir = db_dir)
# this import only a specific type files
import_bulk(data_dir = db_dir, file_type = "sav")
```

- *To be continued….*

## SQL database

- `fix_dup_id`: Check existence of ID duplication and pinpoint them.

``` r
# check ID duplication
fix_dup_id(df = baseline_example_Relative_220504, id_str = "lopnr")
```

# Changelog

Please check
[NEWS.md](https://github.com/Bolin-Wu/neartools/blob/master/NEWS.md) for
history updates.
