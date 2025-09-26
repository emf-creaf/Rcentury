#' Run CENTURY simulations and load results into the R session
#'
#' @description
#' \code{century_run}
#'
#' @param pathname \code{character} string with valid path to a folder.
#' @param schedule \code{character} string with name of a valid schedule file (with extension '.sch')
#' @param name_bin \code{character} string with name to give to output '.bin' file.
#' @param name_lis \code{character} string with name to give to output '.lis' ASCII file.
#' @param name_txt \code{character} string specifying the name of the ASCII text (with extension '.txt')
#' file that contains, in a single column, the name of the fields to extract from the results.
#' @param overwrite \code{logical}, if set to TRUE and the file already exists, it will overwrite; if set to
#' FALSE and the file exists, it will stop with an error message.
#' @param extended \code{character} flag "Y" or "N" to decide whether the computation corresponds to an extended
#' one (see CENTURY manual, section 6-1, for details).
#' @param erase_bin \code{logical}, if set to TRUE (default) the '.bin' file that results from the CENTURY
#' simulation will be erased after the calculations are done.
#' @param verbose \code{logical}, if set to TRUE (default) information about the execution is printed on screen.
#'
#' @returns
#' Nothing.
#'
#' @export
#'
#' @examples
#' # See vignette for details.
century_run <- function(pathname = pathname, schedule = schedule, name_bin = name_bin, name_lis = name_lis,
                        name_txt = name_txt, overwrite = TRUE, extended = FALSE, erase_bin = FALSE, verbose = TRUE) {

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
  if (verbose) message(paste("Running", file.path(pathname, "century_47.exe")))
  args <- c(schedule, name_bin, ifelse(extended, "Y", "N"), "")
  out <- run_cent(pathname, args)


  # There may not be any error message if the program does not find the weather or site files.
  # We check the output for an "STOP" string.
  if (any(grepl("STOP", out))) {
    cli::cli_abort(paste0("\n century_47.exe terminated with errors. Check the output below:\n\n\n"))
    print(out)
    stop()
  }


  # Now read the output ".bin" file and create an ASCII ".lis" file with results.
  if (verbose) message(paste("Running", file.path(pathname, "list100_47.exe")))
  out <- run_list(pathname, name_bin, name_lis, name_txt)


  # Read ".lis" file and load results into the R session.
  name_lis <- paste0(name_lis, ".lis")
  if (verbose) message(paste("Reading", file.path(pathname, name_lis)))
  df <- read_lis(pathname, name_lis)


  return(df)

}
