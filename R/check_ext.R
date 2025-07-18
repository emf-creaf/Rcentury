#' Title
#'
#' @param filename
#' @param ext
#'
#' @returns
#' @export
#'
#' @examples
check_ext <- function(filename, ext) {

  if (!is.character(ext)) stop("Input 'ext' must be a character string")
  if (tools::file_ext(filename) != ext) stop(paste0("File ", filename, " should have a '.", ext, "' extension"))

}
