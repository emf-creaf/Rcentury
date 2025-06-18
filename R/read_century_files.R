#' Title
#'
#' @param path
#' @param filename
#' @param check_site
#'
#' @returns
#' @export
#'
#' @examples
read_century_files <- function(path = path, filename = filename, file_site = FALSE, file_exists = TRUE, remove_blanks = TRUE) {

  # Check path and file name are correct.
  x <- check_path_filename(path, filename, file_site = file_site)


  # Read file. We use suppressWarnings to eliminate messages of incomplete final lines.
  x <- suppressWarnings(readLines(check_path_filename(path, filename, file_site = file_site)))


  # Read file. Check whether file is a <site>.100 file only if file_site = TRUE.
  ext <- tools::file_ext(filename)
  if (ext == "100") {
    data(files_100)
    if (filename %in% names(files_100)) {
      read_100(path, filename, remove_blanks = remove_blanks)
    } else if (file_site) {
        x <- read_site(path, filename)
      } else {
        cli::cli_abort("Wrong file name. If it is a site file, set 'file_site' to TRUE")
      }
  } else {
    x <- switch(ext,
                sch   = read_schedule(path, filename),
                wth   = read_weather(path, filename)
    )
  }




  return(x)

}
