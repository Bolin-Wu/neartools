# Find replicated id in a data file

In NEAR, we use ID (lopnr) to identify a specific participant. If two
people share the same ID, there must be a problem. This function is used
to:

- Check if a data file has replicated ID.

- If there is replicated id, find out which IDs are replicated.

## Usage

``` r
get_dup_id(df, id_str)
```

## Arguments

- df:

  A tibble to be examined.

- id_str:

  A string that contains ID name. E.g. "lopnr".

## Value

A list with examination results

- logic_rep: If df has replicated ID or not.

- replicated_id: Specific replicated ID. May need to report them to
  local DBM.

## Examples

``` r
if (FALSE) { # \dontrun{
neartools::get_dup_id(df_dup_id, id_str = "id")
} # }
```
