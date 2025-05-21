#' Title
#'
#' @param file
#' @param extension
#' @param wd
#'
#' @returns
#'
#' @examples
century_check_path <- function(file = file, extension = NULL, wd = wd, verbose = TRUE) {

  if (verbose) cli::cli_alert_info(paste0("Checking path for file ", file))

  stopifnot("Please provide an extension for the file" = !is.null(extension))
  stopifnot("Extension string should have a dot, as in e.g. '.lis'" = grepl(".", extension))
  file <- paste0(file, extension)
  if (!is.null(wd)) {
    stopifnot("Path 'wd' does not exist" = file.exists(wd))
    file <- file.path(wd, file)
  }
  return(file)

}
