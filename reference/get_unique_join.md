# Get the unique join of two tables

This function joins 2 tibbles and generates unique columns to record
non-NA values when there are 2 identical column names.

## Usage

``` r
get_unique_join(tibble_names, join_type, by_cols)
```

## Arguments

- tibble_names:

  A vector of tibbles' names in your R environment.

- join_type:

  It should be one of 'full_join', 'left_join', 'inner_join'.

- by_cols:

  It should include the columns in a format that
  \`[`join_by`](https://dplyr.tidyverse.org/reference/join_by.html)\`
  can interpret.

## Value

A tibble contains unique columns to record non-NA values for identical
columns of two tables.

## Details

The motivation to create this function is that when Bolin extracts
SNAC-N variables, he finds that for wave 3, there is overlapping
information from different sources.

For example, for physician variables, there are 3 files:

- All wave 3 participants.

- Only cohort 1's follow-up at wave 3.

- Only cohort 2's baseline.

There are overlapping of both participants and variables. In addition,
for the same participant and same variable, some are NA in one file
whereas not NA in the other file. If only using a join function, the
common columns will be separated to '.x' and '.y'. And we have to use
`coalesce` to pick one without NA. And then we delete the '.x' and '.y'
columns.

To avoid repetitive work, Bolin wrote this function to integrate
information from different data files.

## Examples

``` r
if (FALSE) { # \dontrun{

## fake_snacn_ph_wave3 and fake_snacn_ph_fu contains same variable 'ph121'.
## but for some obs, in one file in NA, in the other file is not NA. E.g. Lopnr = 10

left_join(fake_snacn_ph_wave3, fake_snacn_ph_fu, by = join_by(Lopnr == N1lopnr, age))

## let's just combine the info and only keep the one without NA.


get_unique_join(tibble_names = c("fake_snacn_ph_wave3", "fake_snacn_ph_fu"),
               join_type = "full_join",
               by_cols = "Lopnr == N1lopnr, age")
} # }
```
