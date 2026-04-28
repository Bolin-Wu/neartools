# get_pretty_template

Automatically create & open an rmd file with a nice looking template.
This facilitates the communication with researchers & tracking the
records. User can choose output file to be word”, “pdf” or “html”. By
default it complies an “word” file.

## Usage

``` r
get_pretty_template(
  name = NULL,
  subDir = "rmd",
  output_file = "word",
  open = interactive(),
  ...
)
```

## Arguments

- name:

  Name of rmd file. Please do not use '/' in the the file name (no need
  to add suffix ".Rmd").

- subDir:

  Name of the folder where rmd file will be created. Remember to connect
  sub-dir names with '/'. By default it is 'rmd'.

- output_file:

  The output file's type. It could be "word", "pdf" or "html", by
  default it is "word"

- open:

  Should the file be opened after being created

- ...:

  Arguments to be passed to
  [use_template](https://usethis.r-lib.org/reference/use_template.html)

## Examples

``` r
if (FALSE) { # \dontrun{
neartools::get_pretty_template(
  subDir = "Enquiry/SNAC",
  name = "snac_k_inspection",
  output_file = "word"
)
} # }
```
