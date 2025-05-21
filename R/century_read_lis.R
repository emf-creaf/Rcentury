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
century_read_lis <- function(file = file, wd = wd, verbose = verbose) {


  # Checks.
  file <- century_check_path(file, ".lis", wd, verbose)


  # Read file
  x <- readLines(file.path(wd, paste0(file, ".lis")))


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
