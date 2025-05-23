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



#' Title
#'
#' @param x
#'
#' @returns
#' @export
#'
#' @examples
check_natural <- function(x) {
  stopifnot("Input must be a numeric vector" = is.vector(x, mode = "numeric"))
  stopifnot("Input must consist of positive integers only" = all((round(x) == x) & (x >= 0)))
  return(x)
}




#' Title
#'
#' @param file_search
#' @param wd
#' @param string
#'
#' @returns
#' @export
#'
#' @examples
find_extension <- function(file_search, wd = wd, extension = extension) {

  if (!is.null(wd)) {
    stopifnot("Path 'wd' does not exist" = file.exists(wd))
    fn <- file.path(wd, file_search)
  }
  stopifnot("Could not find input 'file_search' name" = file.exists(fn))
  stopifnot("Please provide a string to search" = !is.null(search_string))


  # Read file at once.
  x <- readLines(fn)

  # Look for search_string.
  y <- grepl(search_string, x)
  stopifnot("Could not find 'search_string' in file" = any(y))
  i <- which(y)
  stopifnot("There should not be more than one match of the 'search_string'" = length(i) == 1)
  y <- x[i]
  if (remove) y <- trimws(sub(search_string, "", y, ignore.case = TRUE))

  return(y)

}


#' Title
#'
#' @param x
#'
#' @returns
#'
#' @examples

list_elements <- function(elem_names, elem_num) {

  elements <- lapply(elem_names, function(x) {
    if (length(elem_num[[x]]) == 1) {
      paste0(x, "(", seq(1, elem_num[[x]], by = 1), ")")
    } else {
      dxy <- elem_num[[x]]
      y <- NULL
      for (i in 1:dxy[1]) {
        for (j in 1:dxy[2]) {
          y <- c(y, paste0(x, "(", i, ",", j, ")"))
        }
      }
      y
    }
  })
  return(elements)
}

