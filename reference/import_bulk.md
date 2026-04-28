# Bulk import SPSS(sav) and STATA(dta), MS Excel(csv) Rdata and RDS files into R

Many NEAR databases stroe data in SPSS or STATA and MS Excel. Therefore
chances are that we need to import many different files at a time in R
for further analysis. This function is to bulk import data files of
types mentioned above into R environment.

## Usage

``` r
import_bulk(data_dir = NULL, file_type = "all")
```

## Arguments

- data_dir:

  The folder storing data files.

- file_type:

  The data file type. Options could be 'sav' or 'dta', 'csv', 'Rdata' or
  'rds'. Default is 'all'.

  - sav uses `read_sav()` from 'haven' package.

  - dta uses `read_dta()` from 'haven' package.

  - csv uses [`read.csv()`](https://rdrr.io/r/utils/read.table.html)
    from 'utils' package.

  - xlsx uses `read_excel()` from 'readxl' package.

  - Rdata and rds uses
    [`readRDS()`](https://rdrr.io/r/base/readRDS.html) and
    [`load()`](https://rdrr.io/r/base/load.html) from R base.

  - The default 'all' imports all five kinds of data.

## Value

Two results as follows:

- Import SPSS files in `data_dir` to R global environment;

- List names of tables imported to R.

## Note

- `here` function is a fast and neat way of defining data directory
  `data_dir`.

- Be careful when importing the csv files. It could be messy since this
  function just uses default parameters of
  [`read.csv()`](https://rdrr.io/r/utils/read.table.html).

- For 'Rdata' files, it can read 'Rdata', 'RData', "rdata".

- For 'Rds' files, it can read 'Rds' or 'rds'.

## Examples

``` r
if (FALSE) { # \dontrun{
# Assume the data files are in path:'data/raw/SNAC-K'
db_dir <- here("data", "raw", "SNAC-K")

# this import all csv, sav and dta files in the 'db_dir'
import_bulk(data_dir = db_dir)

# this import only a specific type files
import_bulk(data_dir = db_dir, file_type = "sav")
} # }
```
