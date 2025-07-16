#' Title
#'
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
check_overwrite <- function(path = path, filename = filename, remove = FALSE) {


  # Overwrite or not?
  if (file.exists(file.path(path, filename))) {
    if (remove) {
      unlink(file.path(path, filename))
    } else {
      stop(paste("File", filename, "already exists in folder. Should 'remove' be set to TRUE?"))
    }
  }


  return(fileout)

}
