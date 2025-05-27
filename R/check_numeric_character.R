#' Check whether input is equal to '?', numeric or a character string.
#'
#' @param y \code{character} string containing a number, a quotation mark '?' or text.
#' @param type \code{character}
#'
#' @returns
#' @export
#'
#' @examples
#' check_numeric_character("?")
#' check_numeric_character("?", "max")
#' check_numeric_character("a")
#' check_numeric_character("-5")
#' check_numeric_character("34.3")

check_numeric_character <- function(y, type = "min") {
  y <- trimws(y)
  stopifnot("Input 'type' must be equal to 'min' or 'max'" = type %in% c("min", "max"))
  if (y == "?") {
    z <- ifelse(type == "min", -Inf, Inf)
  } else {
    w <- tryCatch(as.numeric(y), warning = function(w) w)
    if ("warning" %in% class(w)) {
      z <- y # If it is a string, do nothing.
    } else {
      z <- as.numeric(y) # It is numeric, so convert it.
    }
  }
  return(z)
}
