# Get the columns with different values

When we received data files, some rows contain duplicated IDs. This is a
problem as ID should be unique. This function finds the columns with
different values by comparing the two records with the same ID.

- It is useful for deciding which row to keep when we find there are two
  duplicated IDs (e.g. after using
  [`get_dup_id()`](https://bolin-wu.github.io/neartools/reference/get_dup_id.md).

- This function conquers the problem 'NA' values when comparing the
  columns with the basic logical operators, e.g '==' and '!='. By
  default, they return 'NA' as long as there is any 'NA' value in the
  columns. However, we also want to know if the columns that one record
  gives "NA" and the other has values.

## Usage

``` r
get_diff_cols(data_file, id_str, id_num)
```

## Arguments

- data_file:

  A file contains duplicated IDs.

- id_str:

  A string that contains ID name. E.g. "lopnr".

- id_num:

  A specific ID that the user wants to examine.

## Value

It returns a tibble with columns containing different values.

## Note

This function can only compare 2 rows. It does not work if an ID is
duplicated for more than 2 rows.

## Examples

``` r
if (FALSE) { # \dontrun{
dup_id <- get_dup_id(df = df_dup_id, id_str = "id")$replicated_id
get_diff_cols(data = df_dup_id, id_str = "id", id_num = dup_id[1])
} # }
```
