#' Check that path and name of the file with extension *.100 is correct
#'
#' @param path \code{character} string with valid path to a folder.
#' @param filename \code{character} string with an actual file name. It must include the extension '.100'.
#'
#' @returns
#'
#' @details
#' \code{check_100} does not check that file exists, only that it has a '.100' extension and
#' that folder exists. If 'check_site' is set to FALSE (default), it also checks that 'filename'
#' conforms to input file names used by CENTURY.
#'
#'
#' @examples
check_100 <- function(path = path, filename = filename) {


  # Are inputs there?
  if (missing(path) | missing(filename)) stop("Missing inputs 'path' or 'filename'")


  # Checks.
  if (!file.exists(path)) {
    stop(paste("Wrong path", path))
  }
  if (tools::file_ext(filename) != "100") {
    stop("File extension must be '.100'")
  }
  data(files_100)
  if (!(filename %in% names(files_100))) {
    stop(paste("File name", filename, "could not be matched to a valid input CENTURY '*.100' name. Is it a site file?"))
  }

}
