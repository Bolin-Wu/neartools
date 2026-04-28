# Find variables matching a pattern across multiple datasets

This function searches for specific variable names (columns) across
multiple data frames in the global environment that match a certain
naming pattern.

## Usage

``` r
get_vars_by_pattern(data_pattern = NULL, var_pattern = NULL)
```

## Arguments

- data_pattern:

  A string containing a regular expression to match the names of the
  datasets in the global environment. For more information on supported
  regular expressions, see [R's regex
  documentation](https://stat.ethz.ch/R-manual/R-devel/library/base/help/regex.html).

- var_pattern:

  A string containing a regular expression to match the variable names
  within those datasets.

## Value

A named list where each element name is a dataset and the value is a
character vector of matching variable names. Returns NULL if no datasets
match.

## Examples

``` r
if (FALSE) { # \dontrun{
# Load package data into global environment
data("fake_snacn_ph_fu")
data("fake_snacn_ph_wave3")

# Search for variables starting with "ph" in SNAC-N physical datasets
get_vars_by_pattern(data_pattern = "^fake_snacn_ph", var_pattern = "^ph")
} # }
```
