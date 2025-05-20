century_run <- function(schedule = schedule, fileout = fileout, wd = wd, extended = FALSE, overwrite = TRUE) {


  # Check correct paths and files.
  fsch <- paste0(schedule, ".sch")
  fout <- paste0(fileout, ".bin")
  if (!is.null(wd)) {
    stopifnot("Path 'wd' does not exist" = file.exists(wd))
    fsch <- file.path(wd, fsch)
    fout <- file.path(wd, fout)
  }
  stopifnot("Could not find 'schedule' file" = file.exists(fsch))
  if (file.exists(fout)) {
    if (overwrite) unlink(fout) else stop("Output file already exists. Set 'overwrite' to TRUE?")
  }
  stopifnot("Could not find 'century_47.exe'" = file.exists(file.path(wd, "century_47.exe")))


  # Site and weather files are given with their extensions inside the schedule file.
  # We look for those names and make sure they exist on disk.

  # There should be a weather file (extension .wth) with the same as the file schedule.
  # WRONG. THE NAME OF THE SITE AND WEATHER FILES ARE INSIDE THE SCHEDULE FILE WITH .100 AND .wth EXTENSIONS. CHECK!!!!
  fwth <- paste0(schedule, ".wth")
  if (!is.null(wd)) fwth <- file.path(wd, fwth)
  stopifnot("Could not find a valid weather file" = file.exists(fwth))


  # Move to directory, run century_47.exe and move back.
  wd_old <- getwd()
  setwd(wd)
  args <- c(schedule, fileout, ifelse(extended, "Y", "N"), "")
  shell("century_47.exe", input = args, intern = TRUE, wait = TRUE)
  setwd(wd_old)


}
