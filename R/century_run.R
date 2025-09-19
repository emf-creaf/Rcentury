#' Title
#'
#' @param pathname
#' @param schedule
#' @param name_bin
#' @param name_lis
#' @param name_txt
#' @param overwrite
#' @param extended
#' @param verbose
#'
#' @returns
#' @export
#'
#' @examples
century_run <- function(pathname = pathname, schedule = schedule, name_bin = name_bin, name_lis = name_lis,
                        name_txt = name_txt, overwrite = TRUE, extended = FALSE, verbose = TRUE) {

  # First checks.
  if (tools::file_ext(schedule) != "sch") stop("Extension of schedule file should be '.sch'")
  if (tools::file_ext(name_bin) != "bin") stop(paste("Extension of", name_bin, "file should be '.bin'"))
  if (tools::file_ext(name_lis) != "lis") stop(paste("Extension of", name_lis, "file should be '.lis'"))
  if (tools::file_ext(name_txt) != "txt") stop(paste("Extension of", name_txt, "file should be '.txt'"))


  # Are all files there?
  if (!file.exists(file.path(pathname))) stop("Wrong path")
  if (!file.exists(file.path(pathname, schedule))) stop(paste("Could not find", schedule, "file"))
  if (!file.exists(file.path(pathname, "century_47.exe"))) stop(paste("Could not find 'century_47.exe' in folder", pathname))
  if (!file.exists(file.path(pathname, "list100_47.exe"))) stop(paste("Could not find 'list100_47.exe' in folder", pathname))


  # Now, remove extensions to file names.
  schedule <- tools::file_path_sans_ext(schedule)
  name_bin <- tools::file_path_sans_ext(name_bin)
  name_lis <- tools::file_path_sans_ext(name_lis)


  # Move to directory, run century_47.exe and move back.
  wd_old <- getwd()
  setwd(pathname)
  args <- c(schedule, name_bin, ifelse(extended, "Y", "N"), "")
  out <- system2("century_47.exe", input = args, wait = TRUE, stderr = TRUE, stdout = FALSE)
  setwd(wd_old)


  # There may not be any error message if the program does not find the weather or site files.
  # We check the output for an "STOP" string.
  if (any(grepl("STOP", out))) {
    cli::cli_abort(paste0("\n century_47.exe terminated with errors. Check the output below:\n\n\n"))
    print(out)
    stop()
  }


  # Now read the output ".bin" file and load results into the R session.
  wd_old <- getwd()
  setwd(pathname)
  params <- c(name_bin, name_lis, name_txt)
  # out <- system2("list100_47.exe", input = params, wait = TRUE, stderr = TRUE, stdout = FALSE) # Couldn't make it work.
  out <- system(paste("list100_47.exe", name_bin, name_lis, name_txt))
  setwd(wd_old)


}
