#' Check that path exists and that file name, together with extension, has been correctly specified
#'
#' @param path
#' @param filename
#' @param extension
#' @param verbose
#'
#' @returns
#'
#' @examples
check_path <- function(path = path, filename = filename, extension = NULL, verbose = TRUE) {

  if (is.null(extension)) cli::cli_abort("Please provide an extension for the file")
  if (!grepl(".", extension)) cli::cli_abort("Extension character string should have a dot, as in e.g. '.lis'")
  file <- paste0(file, extension)
  if (verbose) cli::cli_alert_info(paste("Checking path"))
  if (path != "") {
    if (!file.exists(path)) cli::cli_abort(paste0("Folder ", path, " does not exist"))
    file <- file.path(wd, file)
  }
  return(file)

}
