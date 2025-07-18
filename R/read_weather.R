#' Read '*.wth' CENTURY files
#'
#' @description
#' \code{read_weather} reads '*.wth' weather CENTURY files and gives a
#' wide-format data.frame
#'
#' @param path \code{character} string containing a valid path to a *.sch file.
#' @param filename \code{character} string with the name of the weather file.
#' It must include the extension '.wth'.
#'
#' @returns
#' A \code{data.frame} containing the monthly climatic data for the site.
#'
#' @details
#' The output \code{data.frame} is presented in wide format with 5 columns,
#' namely 'year', 'month', 'prec', 'tmax' and 'tmin'. Columns are sorted in ascending
#' order by year and month.
#'
#' @export
#'
#' @examples
read_weather <- function(path = path, filename = filename) {


  # Checks.
  check_read(path, filename)
  check_ext(filename, "wth")


  df_wide <- read.table(file.path(path, filename))
  colnames(df_wide)[1:2] <- c("climate", "year")

  # From wide to long format.
  df_long <- reshape(df_wide,
    varying = paste0("V", 3:14),
    v.names = "value",
    timevar = "month",
    times = 1:12,
    idvar = c("year", "climate"),
    direction = "long"
  )
  rownames(df_long) <- NULL


  # From long to wide but with three columns for prec, tmin and tmax.
  df_wide <- reshape(
    df_long,
    timevar = "climate",
    idvar = c("year", "month"),
    direction = "wide"
  )


  # Eliminate "value." prefix and reorder by year and month.
  colnames(df_wide)[3:5] <- sub("^value\\.", "", colnames(df_wide)[3:5])
  df_wide <- df_wide[order(df_wide$year, df_wide$month), ]
  rownames(df_wide) <- NULL


  return(df_wide)

}
