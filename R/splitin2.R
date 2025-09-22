#' Split character string in two parts
#'
#' @description
#' \code{splitin2} splints a \code{character} string into a two-element \code{data.frame}
#' containing a number and a string, in this order.
#'
#' @param x single \code{character} string.
#' @param input_type \code{character} string that can take two values: "data" or "title".
#' @param remove_quotes \code{logical}, if set to TRUE any single quotation marks will
#' be removed from the second element.
#'
#' @returns
#' A \code{data.frame} with one row and two columns.
#'
#' @details
#' Function \code{splitin2} has been written to allow splitting string from CENTURY files into
#' two parts. Input 'x' must be a single \code{character} string containing either a number and a
#' text (e.g. "45 dd")
#'
#' @examples
#' # See the difference when 'input_type' changes value.
#' str(splitin2("4.5 'This'", "data"))
#' str(splitin2("45 'This'", "title"))
#'
#' # We set 'remove_quotes' to FALSE.
#' str(splitin2("4.5 'This'", "data", FALSE))
#' str(splitin2("45 'This'", "title", FALSE))
#'
splitin2 <- function(x, input_type = input_type, remove_quotes = TRUE) {


  # Check input type.
  input_type = match.arg(input_type, c("data", "title"))


  # Input must be an ASCII vector of length = 1.
  stopifnot("Please supply an input argument 'x'" = !missing(x))
  stopifnot("Input 'x' must be a character vector of length = 1" = is.character(x) & length(x) == 1)


  # Split into two parts.
  y <- unlist(strsplit(x, "\\s+"))
  if (remove_quotes) y <- remove_single_quotes(y)
  y1 <- ifelse (input_type == "data", as.numeric(y[1]), y[1])
  df <- data.frame(y1, y[2], fix.empty.names = FALSE)


  # Return a data.frame without column names.
  return(df)
}
