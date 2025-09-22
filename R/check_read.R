#' @title
#' Check path, file name and extension
#'
#' @description
#' \code{check_read} verifies that path name exists and that file name, together with extension,
#' has been correctly specified.
#'
#' @param pathname \code{character} string with valid path to a folder.
#' @param filename \code{character} string specifying the name of the file with its extension.
#'
#' @returns
#' If successful, it returns nothing.
#'
#' @examples
#'
#' # Create a silly example text file.
#' sink("example.100")
#' i <- 1:10
#' outer(i, i)
#' sink()
#'
#' # Check it exists and it has a valid CENTURY file extension.
#' check_read(getwd(), "example.100")
#'
#' # Remove the silly example text file.
#' invisible(file.remove("example.100"))
check_read <- function(pathname = pathname, filename = filename) {

  # Are inputs there?
  if (missing(pathname) | missing(filename)) stop("Missing inputs 'pathname' or 'filename'")

  # Checks.
  if (!file.exists(file.path(pathname))) stop(paste0("Folder", pathname, "does not exist"))
  if (!file.exists(file.path(pathname, filename))) stop(paste0("File", filename, "does not exist"))
  ext <- tools::file_ext(filename)
  if (!(ext %in% c("100", "sch", "wth", "lis", "bin"))) stop(paste("Wrong extension for file", filename))

}
