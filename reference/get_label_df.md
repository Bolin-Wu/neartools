# Get labels of a dataset

During work, many times we receive SPSS or STATA data files with labels.
This function is to extract the labels from the read-in data, turn them
in tibble format. This can help us to inspect data more conveniently.

## Usage

``` r
get_label_df(df_w_label)
```

## Arguments

- df_w_label:

  A data set with labels. One can read SPSS or STATA files with `haven`
  package.

## Value

A tibble with three columns:

- variable:

  The original variables' names.

- label_char:

  The variables corresponding labels.

- na_percent:

  Ratio of missing values.

## Examples

``` r
if (FALSE) { # \dontrun{
get_label_df(fake_snack_df)
} # }
```
