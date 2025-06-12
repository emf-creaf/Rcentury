#' Check that path and name of the file with extension *.100 is correct
#'
#' @param path \code{character} string with valid path to a folder.
#' @param filename \code{character} string with an actual file name. It must include the extension '.100'.
#' @param check_site \code{logical}, if set to TRUE \code{check_100} takes into account
#' that file may be a 'site' file, and thus its name may vary.
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
check_100 <- function(path, filename, check_site = FALSE) {

  if (!file.exists(path)) cli::cli_abort(paste("Wrong path", path))
  if (tools::file_ext(filename) != "100") cli::cli_abort("File extension must be '.100'")
  if (!check_site) {
    data(files_100)
    if (!(filename %in% names(files_100))) cli::cli_abort(paste("File name", filename, "is a wrong CENTURY '*.100' name"))
  }

}
