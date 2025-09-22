#' Title
#'
#' @description
#' \code{check_overwrite}
#'
#' @param pathname \code{character} string with valid path to a folder.
#' @param filename \code{character} string specifying the name of the file with its extension.
#' @param overwrite \code{logical}, see 'Details'.
#'
#' @returns
#' Nothing.
#'
#' @export
#'
#' @examples
#' # Create a silly example text file.
#' sink("example.100")
#' i <- 1:10
#' outer(i, i)
#' sink()
#'
#' # Checks.
#' check_overwrite("", "example.txt")
#' check_overwrite("", "example.txt", overwrite = FALSE)
#' check_overwrite("", "e.txt")
#'
#' # Remove the silly example text file.
#' invisible(file.remove("example.100"))
#'
check_overwrite <- function(pathname = pathname, filename = filename, overwrite = FALSE) {

  # Overwrite or not?
  if (file.exists(file.path(pathname, filename))) {
    if (overwrite) {
      file.remove(file.path(pathname, filename))
    } else {
      stop(paste("File", filename, "already exists in folder. Should 'overwrite' be set to TRUE?"))
    }
  }

}
