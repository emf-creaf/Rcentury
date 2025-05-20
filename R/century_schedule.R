century_schedule <- function(x, fileout = fileout, wd = wd, overwrite = TRUE) {

  # Check correct paths and files.
  fn <- check_file(fileout, ".sch", wd)
  if (file.exists(fn)) {
    if (overwrite) unlink(fn) else stop(paste0("File ", fileout, " already exists. Set 'overwrite' to TRUE?"))
  }



}
