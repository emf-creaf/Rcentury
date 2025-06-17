check_path_filename <- function(path = path, filename = filename, file_site = FALSE) {

  # Check path is correct.
  if (!is.character(path)) cli::cli_abort("Input 'path' must be of character type")
  if (length(path) != 1) cli::cli_abort("Input 'path' must be a character vector with only one element")
  if (!file.exists(path)) cli::cli_abort(paste("Path", path, "does not exist"))


  # Check filename is correct.
  if (!is.character(filename)) cli::cli_abort("Input 'filename' must be of character type")
  if (length(filename) != 1) cli::cli_abort("Input 'filename' must be a character vector with only one element")


  # More obvious checks.
  if (!is.logical(file_site)) cli::cli_abort("Input 'file_site' must be of logical type")
  if (length(file_site) != 1) cli::cli_abort("Input 'file_site' must be a logical vector with only one element")


  # Check file extension.
  ext <- tools::file_ext(filename)
  if (ext == "") cli::cli_abort("File extension is required")
  if (!(ext %in% c("100", "wth", "sch"))) cli::cli_abort("File extension must be '100', 'sch' or 'wth'")


  # If extension is '.100', file is either an input file or a site file.
  # If it is an input file, everything is correct and nothing is done.
  # If not an input file, it issues an error message file_site is set to FALSE.
  if (ext == "100") {
    data(files_100)
    x <- filename %in% names(files_100)
    if (!x) {
      if (!file_site) {
        cli::cli_abort(paste("File name", filename, "is a wrong CENTURY '*.100' file name"))
      }
    }
  }


  return(TRUE)

}
