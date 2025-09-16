#' @title Check path, file name and extension
#'
#'
#' @description
#' Check that path exists and that file name, together with extension, has been correctly specified
#'
#' @param path \code{character} string indicating the path to the folder.
#' @param filename \code{character} string specifying the name of the file with its extension.
#'
#' @returns
#'
#' @examples
check_read <- function(path = pathname, filename = filename) {

  # Are inputs there?
  if (missing(pathname) | missing(filename)) stop("Missing inputs 'path' or 'filename'")


  # Checks.
  if (!file.exists(file.path(pathname))) stop(paste0("Folder", pathname, "does not exist"))
  if (!file.exists(file.path(pathname, filename))) stop(paste0("File", filename, "does not exist"))
  ext <- tools::file_ext(filename)
  if (!(ext %in% c("100", "sch", "wth", "lis", "bin"))) stop(paste("Wrong extension for file", filename))

}
