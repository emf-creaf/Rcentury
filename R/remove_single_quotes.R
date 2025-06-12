#' Title
#'
#' @param x
#'
#' @returns
#'
#' @examples
remove_single_quotes <- function(x) {

  if (startsWith(x, "'")) x <- sub("^'", "", x)   # Remove leading single quote if present.
  if (endsWith(x, "'")) x <- gsub("'$", "", x)    # Remove end single quote if present.
  return(x)

}
