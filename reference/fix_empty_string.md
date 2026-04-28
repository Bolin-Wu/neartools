# Fix the empty string in csv file

When importing the csv file to MySQL workbench, if there is a cell with
empty strings, the 'Wizard Import' function would skip that row. To fix
this problem, we need to replace the empty string with "NA" so that we
can import all records into MySQL.

## Usage

``` r
fix_empty_string(df_name)
```

## Arguments

- df_name:

  A tibble name in R. It should be a string.

## Value

A tibble with empty strings are replaced as 'NA'.

## Note

This replacement only applies to 'character' columns.

## Examples

``` r
if (FALSE) { # \dontrun{
fix_empty_string("baseline_example_Nurse_220504")
} # }
```
