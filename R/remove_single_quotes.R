#' Removal of leading and end single quotation marks.
#'
#' @description
#' \code{remove_single_quotes} removes leading and trailing quotes in a character string if present.
#'
#' @param x \code{character} vector.
#'
#' @returns
#' A \code{character} vector of the same length as 'x' with all leading and end single quotation marks removed.
#' Input is unchanged if it is numeric.
#'
#' @examples
#' remove_single_quotes("'This leading quote will disappear, but not this 'one.")
remove_single_quotes <- function(x) {


  # Quotation mark removal.
  if (!is.numeric(x)) {
    i <- which(startsWith(x, "'"))
    if (sum(i) > 0) x[i] <- sub("^'", "", x[i])     # Remove leading single quote if present.
    i <- which(endsWith(x, "'"))
    if (sum(i) > 0) x[i] <- gsub("'$", "", x[i])    # Remove trailing single quote if present.
  }

  return(x)

}
