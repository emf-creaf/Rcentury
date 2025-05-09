#' Read data from a CENTURY \code{list} file
#'
#' @param filename string, valid file name.
#' @param wd string, valid path name
#'
#' @returns
#' A \code{data.frame}
#'
#' @export
#'
#' @examples
read_lis <- function(filename, wd) {

  # Checks.
  if (!is.null(wd)) stopifnot("Path 'wd' does not exist" = file.exists(wd))
  filename <- paste0(wd, "/", filename)
  stopifnot("Cound not find 'filename' file in path 'wd'" = file.exists(filename))


  # Read file.
  x <- read.table(filename, header = TRUE, dec = ".", check.names = FALSE)

  return(x)

}
