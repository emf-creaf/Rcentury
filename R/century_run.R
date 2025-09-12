#' Title
#'
#' @param schedule
#' @param fileout
#' @param wd
#' @param extended
#' @param overwrite
#' @param verbose
#'
#' @returns
#' @export
#'
#' @examples
century_run <- function(path = path, list = list_files, overwrite = TRUE, verbose = TRUE) {


  # Check path.
  if (!file.exists(file.path(path))) stop("Input 'path' is wrong")


  # Check whether file names in 'list_files' is

  # Check whether input files are there.
  if (file.exists(file.path(path, list_files["schedule"])))





  fsch <- check_path(schedule, ".sch", verbose = verbose)
  fout <- check_path(fileout, ".bin", verbose = verbose)
  stopifnot("Could not find 'schedule' file" = file.exists(fsch))
  check_overwrite(fout, verbose = verbose)
  stopifnot("Could not find 'century_47.exe'" = file.exists(file.path(wd, "century_47.exe")))

  if (!file.exists(file.path(path, "century_47.exe"))) stop("Could not find 'century_47.exe' in directory")



  # Site and weather files are given with their extensions inside the schedule file.
  # We look for those names and make sure they exist on disk.

  # There should be a weather file (extension .wth) with the same as the file schedule.
  # WRONG. THE NAME OF THE SITE AND WEATHER FILES ARE INSIDE THE SCHEDULE FILE WITH .100 AND .wth EXTENSIONS. CHECK!!!!
  # fwth <- paste0(schedule, ".wth")
  # if (!is.null(wd)) fwth <- file.path(wd, fwth)
  # stopifnot("Could not find a valid weather file" = file.exists(fwth))


  # Move to directory, run century_47.exe and move back.
  wd_old <- getwd()
  setwd(wd)
  args <- c(schedule, fileout, ifelse(extended, "Y", "N"), "")
  out <- system2("century_47.exe", input = args, wait = TRUE, stderr = TRUE, stdout = FALSE)
  setwd(wd_old)


  # There may not be any error message if the program does not find the weather or site files.
  # We check the output for an "STOP" string.
  if (any(grepl("STOP", out))) {
    cli::cli_abort(paste0("\n century_47.exe terminated with errors. Check the output below:\n\n\n"))
    print(out)
    stop()
  }

}
