# Export the SPSS data files to csv files

In Maelstrom harmonization package, there is a command
'mlstr_file_index_read()' to read all the study specific data sets. It
can read commonly used .csv, .dta files, but not .sav (SPSS) data.
Therefore this function can help the user to transform all sav data sets
to csv data, instead of using 'read_sav()' function to transform every
data set one by one manually.

## Usage

``` r
export_sav_to_csv(data_folder_name, db_name, out_dir = NULL)
```

## Arguments

- data_folder_name:

  The name of the folder where all the data are being stored.

- db_name:

  The name of specific database's folder, which is located in
  \`data_folder_name\`.

- out_dir:

  optional. The name of the output directory, instead of using
  \<data_folder_name\>/\<db_name\>/csv_format.

## Value

A folder called "csv_format" will be generated in the 'db_name's folder,
storing all the transformed csv files.

## Details

Assume you have a bunch of \`.sav\` files current working directory:
"original_data/SNAC-K". You may want to transform them to \`.csv\` files
so that they can be recognized by Maelstrom harmonization package.

After running this function, there should be a new folder "csv_format"
storing the transformed SNAC-K csv files at "original_data/SNAC-K".

## Note

Please make sure that the \`original_data\` folder is in your current
working directory.

## Examples

``` r
if (FALSE) { # \dontrun{
export_sav_to_csv("original_data", "SNAC_K")
} # }
```
