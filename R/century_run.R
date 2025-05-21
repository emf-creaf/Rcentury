century_run <- function(schedule = schedule, fileout = fileout, wd = wd, extended = FALSE, overwrite = TRUE) {


  # Check correct paths and files.
  fsch <- century_check_path(schedule, ".sch", wd)
  fout <- century_check_path(fileout, ".bin", wd)
  stopifnot("Could not find 'schedule' file" = file.exists(fsch))
  if (file.exists(fout)) {
    if (overwrite) unlink(fout) else stop("Output file already exists. Set 'overwrite' to TRUE?")
  }
  stopifnot("Could not find 'century_47.exe'" = file.exists(file.path(wd, "century_47.exe")))


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
    cat("\n century_47.exe terminated with errors. Check the output below:\n\n\n")
    print(out)
    stop()
  }

}
