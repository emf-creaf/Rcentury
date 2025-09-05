#' Title
#'
#' @param x
#' @param path
#' @param filename
#' @param overwrite
#'
#' @returns
#' @export
#'
#' @examples
write_site <- function(x, path = path, filename = filename, overwrite = FALSE) {


  # Checks.
  # check_write(path, filename, overwrite = overwrite)
  # check_ext(filename, "100")


  # To check out fields in x. We calculate how many parameters there should be in each
  # section of the file.
  data(data_100)
  num_rows <- table(data_100$`<site>.100`$`Parameter type`)
  sections <- names(num_rows)
  i <- pmatch(tolower(sections), tolower(names(x)))
  if (any(is.na(i))) stop("Input 'x' has wrong names")

browser()

}
