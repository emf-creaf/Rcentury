#' Write CENTURY weather file
#'
#' @description
#' \code{century_weather}
#'
#' @param df \code{data.frame} containing weather data (precipitation, maximum and minimum temperature).
#' @param fileout \code{character} string with the name (without extension) of the weather file to be created.
#' @param wd \code{character} string with the name of a valid directory to save the weather file. Default is the local folder.
#' @param overwrite \code{logical} indicating whether to overwrite 'fileout' if it already exists on disk. Default is 'TRUE'.
#' @param sep \code{character} string to separate columns by in 'fileout'. Default is an empty \code{character} string of length 7.
#' @param ndigits \code{numeric} indicating the number of decimal digits in output file. Default is 3.
#' @param verbose \code{logical} indicating whether to print out informative messages. Default is 'TRUE'.
#'
#' @details
#' The input \code{data.frame} is pivoted from long to wide format to fit CENTURY requirements.
#'
#' @returns
#' NULL is returned and fileout is written on disk.
#'
#' @export
#'
#' @examples
#' df<- data.frame(month = rep(1:12, 2),
#'   year = rep(c(2020, 2021), each = 12),
#'   prec = runif(24)*500 + 100,
#'   tmin = rnorm(24, mean = 5),
#'   tmax = rnorm(24, mean = 15))
#' century_weather(df, "nothing")
century_weather <- function(df = df, fileout = fileout, wd = "", overwrite = TRUE, sep = "      ", ndigits = 3, verbose = TRUE) {


  # Check input data.frame.
  stopifnot("Input 'df' must be a data.frame" = is.data.frame(df))
  stopifnot("Wrong column names in input data.frame" = c("month", "year", "prec", "tmin", "tmax") %in% colnames(df))
  nyear <- df |> dplyr::count(year)
  stopifnot("There must be 12 months in each year" = all(nyear$n == 12))
  stopifnot("There cannot be NA in weather values" = all(!is.na(df[, c("prec", "tmin", "tmax")])))
  stopifnot("Precipitation must always be positive" = all(df$prec >= 0))

browser()
  # Check output file.
  fileout <- check_path(fileout, ".wth", wd, verbose = verbose)
  fileout <- check_overwrite(fileout, overwrite = overwrite, verbose = verbose)
  ndigits <- check_natural(ndigits)


  # From long to wide format.
  df_long <- df |>
    tidyr::pivot_longer(cols = c(prec, tmin, tmax), names_to = "variable", values_to = "value")
  df_wide <- df_long |>
    tidyr::pivot_wider(names_from = month, values_from = value) |>
    dplyr::arrange(year, variable) |>
    as.data.frame()
  colnames(df_wide) <- NULL


  # Round to ndigits.
  df_wide[, -c(1, 2)] <- round(df_wide[, -c(1, 2)], digits = ndigits)


  # Save file on disk.
  if (verbose) cli::cli_alert_info(paste0("Writing weather file ", fileout, "..."))
  write.table(df_wide, file = fileout, sep = sep, quote = FALSE, row.names = FALSE, col.names = FALSE)

}
