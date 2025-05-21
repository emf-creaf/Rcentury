#' Title
#'
#' @param file
#' @param extension
#' @param wd
#'
#' @returns
#' @export
#'
#' @examples
century_check_path <- function(file = file, extension = NULL, wd = wd) {

  stopifnot("Please provide an extension for the file" = !is.null(extension))
  stopifnot("Extension string should have a dot, as in e.g. '.lis'" = grepl(".", extension))
  file <- paste0(file, extension)
  if (!is.null(wd)) {
    stopifnot("Path 'wd' does not exist" = file.exists(wd))
    file <- file.path(wd, file)
  }
  return(file)

}
