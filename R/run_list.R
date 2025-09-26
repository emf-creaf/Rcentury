#' Title
#'
#' @param pathname \code{character} string with valid path to a folder.
#' @param name_bin \code{character} string with the name of the '.bin' file to read.
#' @param name_lis \code{character} string with the name of the ASCII '.lis' file to create.
#' @param name_txt \code{character} string with the name of the ASCII file containing the name of the
#' fields to extract from 'name_lis'.
#'
#' @returns
#' Any message from the execution.
#'
#' @examples
#' # See example in \code{\link{century_run}}.
run_list <- function(pathname, name_bin, name_lis, name_txt) {

  wd_old <- getwd()
  setwd(pathname)

  # out <- system2("list100_47.exe", input = params, wait = TRUE, stderr = TRUE, stdout = FALSE) # Couldn't make it work.

  out <- system(paste("list100_47.exe", name_bin, name_lis, name_txt))
  setwd(wd_old)
  if (out != 0) warning(paste("Error", out, " in list100_47.exe execution"))

  return(out)
}
