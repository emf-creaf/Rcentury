#' Removal of leading and end single quotation marks.
#'
#' @param x \code{character} vector.
#'
#' @returns
#' A \code{character} vector of the same length as 'x' with all leading and end single quotation marks removed.
#'
#' @examples
remove_single_quotes <- function(x) {

  # Checks.
  if (!is.character(x)) cli::cli_abort("Input 'x' must be of character type")

  # Quotation mark removal.
  i <- which(startsWith(x, "'"))
  if (sum(i) > 0) x[i] <- sub("^'", "", x[i])     # Remove leading single quote if present.
  i <- which(endsWith(x, "'"))
  if (sum(i) > 0) x[i] <- gsub("'$", "", x[i])    # Remove end single quote if present.3

  return(x)

}
