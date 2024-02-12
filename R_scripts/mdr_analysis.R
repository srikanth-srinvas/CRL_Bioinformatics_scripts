mdr_summary <- mdro(
  x = whole_data,
  guideline = "CMI2012",
  col_mo = "Species",  # Enclose the column name in quotes
  info = interactive(),
  pct_required_classes = 0.5,
  combine_SI = TRUE,
  verbose = FALSE,
  only_sir_columns = FALSE
)
summary(mdr_summary)

