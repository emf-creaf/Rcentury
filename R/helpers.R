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


check_elements <- function() {

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



elements_tolower <- function(x) {
  x <- lapply(x, function(y) {
    names(y) <- tolower(names(y))
    y
  })
  return(x)
}
