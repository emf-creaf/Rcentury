#' Title
#'
#' @param wd
#' @param filename
#'
#' @returns
#' @export
#'
#' @examples
#' wd <- ".//data-raw//example"
#' params <- list(simulation ="duke",
#'   output = "out",
#'   start_time = 1,
#'   end_time = 100,
#'   args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc"))
#' list100(wd, params)
#' df <- read_lis(wd, "out")
read_lis <- function(wd, filename) {


  # Checks.
  if (!is.null(wd)) stopifnot("Path 'wd' does not exist" = file.exists(wd))


  # Read lines. These .lis files are blank-separated and the second line is empty.
  fn <- file.path(wd, paste0(filename, ".lis"))
  x <- readLines(fn)


  # If second line is empty, remove.
  if (x[2] == "") x <- x[-2]


  # Split strings.
  z <- sapply(x, function(y) strsplit(y, "\\s+"))
  names(z) <- NULL


  # Does it always have the same number of elements?
  nr <- sapply(z, length)
  stopifnot("Number of columns per row in 'filename' are wrong" = length(unique(nr)) == 1)


  # Convert into data.frame and rearrange it.
  df <- do.call(rbind, z) |> data.frame()
  df <- df[, -1]
  colnames(df) <- df[1, ]
  df <- df[-1, ]
  df <- sapply(df, as.numeric) |> data.frame()


  return(df)
}
