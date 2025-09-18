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
  if (!file.exists(file.path(pathname, "century_47.exe"))) stop(paste("Could not find 'century_47.exe' in folder", pathname))


  # Move to directory, run century_47.exe and move back.
  wd_old <- getwd()
  setwd(pathname)
  args <- c(schedule, name_output, ifelse(extended, "Y", "N"), "")
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
