# Inspect the a date column's digit

When we received files with date variables, sometimes they are not in
good 'date' format. Instead, they might be in pure numeric values with
different digits. In such case, we have to check if they are ideal
eight-digit number or not. Some digits may just not make sense and have
to ask DBM about them. This function aims to make such inspection
easier.

## Usage

``` r
get_date_digit(
  df_arg,
  id_string,
  date_string,
  required_digits,
  required_leading_digit = 2
)
```

## Arguments

- df_arg:

  Input data frame.

- id_string:

  A string contained in ID's column name.

- date_string:

  A string contained in date's column name.

- required_digits:

  The expected date's digit. Ideally it should be 8, i.e. yyyymmdd.

- required_leading_digit:

  The expected date's leading digit.

## Value

A list with three elements:

- count_digit:

  A tibble of ID, date and date's digits.

- wrong_digit:

  A tibble of dates that do not have required digits.

- leading_digit:

  A tibble of dates with required digits and their leading number.

## Details

Given a data frame, strings containing ID and date columns' name, and
required digits, users can find the observations with wrong digits. For
the dates with required digits, we can further check if they have
required numbers, which in most cases should be "1" or "2" for
eight-digit numbers.

The `date_string` argument should lead to a unique date column. This
function only supports inspect one date column at one time.

## Examples

``` r
if (FALSE) { # \dontrun{

date_digit_info <- get_date_digit(
  df_arg = fake_snack_df,
  id_string = "Lop",
  date_string = "numeric_date",
  required_digits = 8, required_leading_digit = 2
)

# get the digits
date_digit_info$count_digit

# get the wrong dates
date_digit_info$wrong_digit

# check if the leading number is as required
date_digit_info$leading_digit
} # }
```
