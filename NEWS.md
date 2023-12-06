# neartools 0.1.0

## 2023-12-06

### New function `get_unique_join`:

* Joins multiple tibbles and generates unique columns to record non-NA values when there are identical column names.

## 2023-10-26

### New function `get_diff_cols`

* This function finds the columns with different values by comparing the two records with the same ID.


### Update `fix_dup_id`

* The function name now called `get_dup_id`.
* Remove the output of new id and data frame with new id. In the old version, the generation of the ID does not make sense, it's simpliy for the purpose of definining the primary syntax in MySQL. Now it is longer needed. Therefore these two outputs are deleted from the output list.

## 2023-10-12

### Update `import_bulk`

* Now it supports importing the 'rds' and 'Rdata' files.


## 2023-04-27

### Update `get_all_colnames`

* Now the metadata tibble has 'na_percent'.


### Update `export_sav_to_csv()`

* Add a new argument 'output_dir' argument.

## 2023-04-21

### Update `get_all_columns()`

* Add a new column 'label_char' to the result tibble.

## 2023-04-19

### Update `get_label_df()`

* Add a new column 'na_percent' to the result tibble.

## 2023-04-18

### Add new function `get_all_columns()`

* To gather several data files and examine all together.
