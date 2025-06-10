splitin2 <- function(x, input_type = match.arg(input_type, c("data", "title"))) {

  # Input must be an ASCII vector of length = 1.
  stopifnot("Please supply an input argument 'x'" = !missing(x))
  stopifnot("Input 'x' must be a character vector of length = 1" = is.character(x) & length(x) == 1)


  # Split into two parts.
  y <- unlist(strsplit(x, "\\s+"))
  y1 <- y[1]
  if (input_type == "data") y1 <- as.numeric(y1)


  # Return a data.frame without column names.
  return(data.frame(y1, y[2], fix.empty.names = FALSE))
}
