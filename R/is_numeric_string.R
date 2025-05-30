#' Check if argument is numeric or not.
#'
#' @param a \code{vector} object.
#'
#' @returns
#' A logical \code{vector}.
#'
#' @examples
is_numeric_string <- function(s) {
  stopifnot("Input must be a vector" = is.vector(s))
  is.na(suppressWarnings(as.numeric(s)))
}
