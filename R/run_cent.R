#' Run century_47.exe
#'
#' @param pathname \code{character} string with valid path to a folder.
#' @param args \code{character} vector with 3 elements, containing the name of the schedule file,
#' the name of the '.bin' file (without the '.bin' extension) to save the result in, and a
#' flag "Y" or "N" to decide whether the computation corresponds to an extended one (see CENTURY manual
#' for details).
#'
#' @returns
#' Any message from the execution.
#'
#' @examples
#' # See example in \code{\link{century_run}}.
run_cent <- function(pathname, args) {
  wd_old <- getwd()
  setwd(pathname)
  out <- system2("century_47.exe", input = args, wait = TRUE, stderr = TRUE, stdout = FALSE)
  setwd(wd_old)
  if (length(out) > 0) warning(paste("Error", out, " in century_47.exe execution"))

  return(out)
}
