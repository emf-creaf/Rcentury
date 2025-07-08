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
read_century_files <- function(path = path, filename = filename, file_site = FALSE, remove_blanks = TRUE) {

  # Check path and file name are correct.
  x <- check_path_filename(path, filename, file_site = file_site)


  # Check that filename is correct. If not, it then checks if it is a <site>.100 file only if file_site = TRUE.
  ext <- tools::file_ext(filename)
  if (ext == "100") {
    data(files_100)
    if (!(filename %in% names(files_100))) {
      if (!file_site) {
        cli::cli_abort("Wrong file name. If it is a site file, set 'file_site' to TRUE")
      } else {
        ext <- "site"
      }
    }
  }


  # Read files.
  x <- switch(ext,
              "100" = read_100(path, filename, remove_blanks = remove_blanks),
              site  = read_site(path, filename),
              sch   = read_schedule(path, filename),
              wth   = read_weather(path, filename)
  )


  return(x)

}
