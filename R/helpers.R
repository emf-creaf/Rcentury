#' Title
#'
#' @param x
#' @param ndigits
#'
#' @returns
#'
#' @examples
check_length_digits <- function(x, ndigits) {

  nc <- nchar(x[1])
  nd <- ndigits + 2
  if (nc < nd) x[1] <- paste0(x[1], paste0(rep(" ", nd-nc), collapse = ""))
  return(x)

}
