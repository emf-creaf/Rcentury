#' Title
#'
#' @param path
#' @param filename
#'
#' @returns
#' @export
#'
#' @examples
read_weather <- function(path = path, filename = filename) {


  # Checks.
  check_read(path, filename)
  if (tools::file_ext(filename) != "wth") stop(paste("File", filename, "should have '.wth' extension"))


  read.table()


}
