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

  # There must be an extension.
  if (!is.character(ext)) stop("Input 'ext' must be a character string")
  if (tools::file_ext(filename) != ext) stop(paste0("File ", filename, " should have a '.", ext, "' extension"))


  # Valid extension?
  ext <- tools::file_ext(filename)
  if (!(ext %in% c("100", "sch", "wth", "lis", "bin"))) stop(paste("Wrong extension for file", filename))

}
