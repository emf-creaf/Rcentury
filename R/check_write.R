#' Title
#'
#' @param path \code{character} string with valid path to a folder.
#' @param filename \code{character} string with an actual file name.
#' @param overwrite \code{logical}, see 'Details'.
#'
#' @details
#' \code{check_write} does nothing if 'filename' does not exist on disk.
#' If it does, then if 'overwrite' is set to TRUE (default), 'filename' is deleted from disk, and if set to FALSE,
#' execution stops with a message.
#'
#' @returns
#' Nothing.
#'
#' @examples
check_write <- function(path = path, filename = filename, overwrite = TRUE) {

  # Are inputs there?
  if (missing(path) | missing(filename)) stop("Missing inputs 'path' or 'filename'")


  # Overwrite or not?
  if (file.exists(file.path(path, filename))) {
    if (overwrite) {
      unlink(file.path(path, filename))
    } else {
      stop(paste("File", filename, "already exists in folder. Should 'overwrite' be set to TRUE?"))
    }
  }

}
