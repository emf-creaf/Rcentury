#' Title
#'
#' @param path
#' @param filename
#' @param overwrite
#'
#' @details
#' \code{check_write} checks that a) path to folder exists and that b) file is removed if 'overwrite' is set to TRUE (default).
#' This clears the way for functions that write CENTURY files to folders.
#'
#' @returns
#' Nothing.
#'
#' @examples
check_write <- function(path, filename, overwrite = TRUE) {

  if (!file.exists(path)) cli::cli_abort(paste("Wrong path", path))
  if (file.exists(file.path(path, filename))) {
    if (!overwrite) {
      cli::cli_abort(paste("File", filename, "already exists in folder. Should 'overwrite' be set to TRUE?"))
    } else {
      unlink(file.path(path, filename))
    }
  }

}
