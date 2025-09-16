#' Check path and files are correct
#'
#' @description
#' \code{check_path_file} just checks that path and file names are correct, and that the former
#' corresponds to a valid path.
#'
#' @param path \code{character} string with path name.
#' @param filename \code{character} string with file name.
#'
#' @returns
#' Nothing.
#' @export
#'
#' @examples
#'
check_path_file <- function(pathname = pathname, filename = filename) {


  # Are inputs there?
  if (missing(pathname) | missing(filename)) stop("Missing inputs 'pathname' or 'filename'")


  # Only one character path and filename, please.
  if (!is.character(pathname) | !is.character(filename)) stop("Inputs 'pathname' or 'filename' must be of character type")
  if (length(pathname) != 1 | length(filename) != 1) stop("Input 'pathname' or 'filename' must be single strings")


  # Directory to read/write to must be valid.
  if (!file.exists(pathname)) stop(paste("Folder", pathname, "does not exist"))


  # Extension must be one of those accepted for CENTURY files.
  ext <- tools::file_ext(filename)
  if (!(ext %in% c("100", "sch", "wth", "lis", "bin"))) stop(paste("Wrong extension for file", filename))

}
