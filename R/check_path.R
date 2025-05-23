#' Title
#'
#' @param file
#' @param extension
#' @param wd
#' @param verbose
#'
#' @returns
#'
#' @examples
check_path <- function(file = file, extension = NULL, wd = "", verbose = TRUE) {

  if (verbose) cli::cli_alert_info(paste0("Checking path for file ", file))

  if (is.null(extension)) cli::cli_abort("Please provide an extension for the file")
  if (!grepl(".", extension)) cli::cli_abort("Extension string should have a dot, as in e.g. '.lis'")
  file <- paste0(file, extension)
  if (wd != "") {
    if (!file.exists(wd)) cli::cli_abort(paste0("Folder ", file, " does not exist"))
    file <- file.path(wd, file)
  }
  return(file)

}
