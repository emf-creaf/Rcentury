#' Read CENTURY '.lis' files
#'
#' @description
#' \code{read_lis} reads '.lis' files with results from CENTURY simulations
#'
#' @param pathname \code{character} string with valid path to a folder.
#' @param filename \code{character} string specifying the name of the file, which must include the extension '.100'.
#'
#' @returns
#' A \code{data.frame} with simulation results.
#'
#' @export
#'
#' @examples
#' # See example in \code{\link{century_run}}.
#'
read_lis <- function(pathname = pathname, filename = filename) {

  # Checks.
  if (tools::file_ext(filename) != "lis") stop(paste("Wrong extension for file", filename))
  check_path_file(pathname, filename)


  # Read file
  x <- readLines(file.path(pathname, filename))


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
