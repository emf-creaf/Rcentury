#' Title
#'
#' @param x
#' @param input_type
#' element.
#'
#' @returns
#' A \code{data.frame} with one row and two columns.
#'
#' @examples
splitin2 <- function(x, input_type = match.arg(input_type, c("data", "title"))) {

  # Input must be an ASCII vector of length = 1.
  stopifnot("Please supply an input argument 'x'" = !missing(x))
  stopifnot("Input 'x' must be a character vector of length = 1" = is.character(x) & length(x) == 1)


  # Split into two parts.
  y <- unlist(strsplit(x, "\\s+"))
  y1 <- ifelse (input_type == "data", as.numeric(y[1]), y[1])
  df <- data.frame(y1, y[2], fix.empty.names = FALSE)


  # Return a data.frame without column names.
  return(df)
}
