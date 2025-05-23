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
check_overwrite <- function(fileout = fileout, overwrite = TRUE, verbose = TRUE) {

  if (file.exists(fileout)) {
    if (overwrite) {
      if (verbose) cli::cli_alert_info(paste0("File ", fileout, " already exists. Deleting it..."))
      unlink(fileout)
      } else {
        # Fail because cannot decide whether or not to overwrite.
        cli::cli_abort(paste0("File ", fileout, " already exists. Set 'overwrite' to TRUE?"))
      }
  } else {
    if (verbose) cli::cli_alert_info(paste0("File ", fileout, " does not exist. No need to check for overwrite"))
  }

  return(fileout)

}
