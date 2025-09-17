#' Title
#'
#' @param pathname
#' @param list_files
#' @param overwrite
#' @param verbose
#'
#' @returns
#' @export
#'
#' @examples
century_run <- function(pathname = pathname, schedule = schedule, name_output = name_output, overwrite = TRUE,
                        extended = FALSE, verbose = TRUE) {


  # Remove extensions and do checks.
  ext <- tools::file_ext(schedule)
  if (ext != "") {
    if (ext != "sch") stop("Name of schedule file should have extension '.ext' or none")
    check_path_file(pathname, schedule)
    schedule <- tools::file_path_sans_ext(schedule)
  } else {
    check_path_file(pathname, paste0(schedule, ".sch"))
  }

  ext <- tools::file_ext(name_output)
  if (ext != "") {
    if (ext != "bin") stop("Name of output file should have extension '.bin' or none")
    check_path_file(pathname, name_output)
    name_output <- tools::file_path_sans_ext(name_output)
  } else {
    check_path_file(pathname, paste0(name_output, ".bin"))
  }


  # Check that '*.exe' file can be found in folder.
  # x <- sapply(c("century_47.exe", "list100_47.exe"), function(x) file.exists(file.path(pathname, x)))
  # if (!all(x)) stop(paste("Either ''century_47.exe' or 'list100_47.exe' are missing from folder", pathname))

  if (!file.exists(file.path(pathname, "century_47.exe"))) stop(paste("Could not find 'century_47.exe' in folder", pathname))


  # # Check whether those files exist in folder 'pathname'.
  # x <- sapply(names(list_files), function(x) file.exists(file.path(pathname, x)))
  # if (!all(x)) stop(paste("Files from 'list_files' missing in folder", pathname))


  # Check whether the schedule file is in folder.
  # if (file.exists(file.path(pathname, list_files["schedule"])))

#
#   fsch <- check_path(schedule, ".sch", verbose = verbose)
#   fout <- check_path(fileout, ".bin", verbose = verbose)
#   stopifnot("Could not find 'schedule' file" = file.exists(fsch))
#   check_overwrite(fout, verbose = verbose)
#   stopifnot("Could not find 'century_47.exe'" = file.exists(file.path(wd, "century_47.exe")))
#
#   if (!file.exists(file.path(path, "century_47.exe"))) stop("Could not find 'century_47.exe' in directory")


  # Site and weather files are given with their extensions inside the schedule file.
  # We look for those names and make sure they exist on disk.

  # There should be a weather file (extension .wth) with the same as the file schedule.
  # WRONG. THE NAME OF THE SITE AND WEATHER FILES ARE INSIDE THE SCHEDULE FILE WITH .100 AND .wth EXTENSIONS. CHECK!!!!
  # fwth <- paste0(schedule, ".wth")
  # if (!is.null(wd)) fwth <- file.path(wd, fwth)
  # stopifnot("Could not find a valid weather file" = file.exists(fwth))

browser()
  # Move to directory, run century_47.exe and move back.
  wd_old <- getwd()
  setwd(path_out)
  args <- c(schedule, name_output, ifelse(extended, "Y", "N"), "")
  kk <- paste0(shQuote(path_out), shQuote("century_47.exe"))
browser()
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
