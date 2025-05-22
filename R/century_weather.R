century_weather <- function(df = df, file = file, wd = wd, overwrite = TRUE, verbose = verbose) {


  # Verbose?
  if (verbose) cli::cli_alert_info(paste0("Writing weather file ", file, "..."))


  # Check input data.frame.
  stopifnot("Input 'df' must be a data.frame" = is.data.frame(df))


  stopifnot("Wrong names in input data.frame" = c("month", "year", "prec", "tmin", "tmax") %in% colnames(df))


  # Check output file.
  file <- century_check_path(file, ".wth", wd)


  nyear <- df |> dplyr::count(year)
  stopifnot("There must be 12 months in each year" = all(nyear$n == 12))


  df_long <- df |>
    tidyr::pivot_longer(cols = c(prec, tmin, tmax), names_to = "variable", values_to = "value")
  df_wide <- df_long |>
    tidyr::pivot_wider(names_from = month, values_from = value) |>
    dplyr::arrange(year, variable) |>
    as.data.frame()
  colnames(df_wide) <- NULL



}
