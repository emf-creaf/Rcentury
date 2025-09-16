#' Title
#'
#' @param pathname
#' @param fileout
#' @param overwrite
#'
#' @returns
#' @export
#'
#' @examples
#' write.table("Example", "example.txt")
#' check_overwrite("example.txt")
#' check_overwrite("example.txt", overwrite = FALSE)
#' check_overwrite("e.txt")
#' unlink("example.txt")
#'
#' # This will generate an error message
#' write.table("Example", "example.txt")
#' check_overwrite("example.txt", overwrite = FALSE)
#' unlink("example.txt")
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
