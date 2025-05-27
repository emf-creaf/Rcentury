#' Split input string by a string.
#'
#' @param x
#' @param by \code{character} string to split the input string by.
#'
#' @returns
#' @details
#' If the input string cannot be splitted because either 'by' is at the beginning
#' or the end of the string, or it is absent, \code{split_string} returns the input
#' \code{character} string unmodified.
#'
#'
#' @examples
split_string <- function(x, by = "or") {
  stopifnot("Input vector 'x' must have a single element" = length(x) == 1)
  stopifnot("Input 'by' is empty or is not a character" = (by != "" & is.character(by)))
  y <- unlist(strsplit(x, by))
  if (length(y) > 1) {
    for (i in 1:length(y)) y <- ifelse()
  }



}
