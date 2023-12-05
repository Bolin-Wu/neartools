## code to prepare `dta_exp` dataset goes
types <- "ddddddddddddddddddDDddddddd"

fake_caide_df <- vroom::gen_tbl(rows = 1000, col_types = types, missing = 0.1)

colnames(fake_caide_df) <- c(
  "time","age_base", "terv48", "fu1_age", "fu2_age", "terv45", "terv46",
  "q67", "q68a", "q69", "sys1", "sys2", "f_systo1", "f_systo2",
  "f_diasto1", "f_terve60", "f_terve61", "f_terve63", "f_terve64",
  "fu1_date", "fu2_date", "fup", "women", "edu_yrs", "id", "base_date", "dem_incl_regs"
)


fake_caide_df = fake_caide_df %>%
  mutate(Lopnr = sample(1:nrow(fake_snack_df), size = nrow(fake_caide_df), replace = FALSE), .before = "time")
usethis::use_data(fake_caide_df, overwrite = TRUE)
