#' Title
#'
#' @param file
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
check_overwrite <- function(file = file, overwrite = TRUE, verbose = TRUE) {

  if (file.exists(file)) {
    if (overwrite) {
      if (verbose) cli::cli_alert_info(paste0("File ", file, " already exists. Deleting it..."))
      unlink(file)
      } else {
        cli::cli_abort(paste0("File ", file, " already exists. Set 'overwrite' to TRUE?"))
      }
  } else {
    cli::cli_alert_info(paste0("File ", file, " does not exist. No need to check for overwrite"))
  }

  return(file)

}
