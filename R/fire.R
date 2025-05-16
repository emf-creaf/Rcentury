#' Schedules a fire in the current month
#'
#' @param x
#' @param wd
#' @param ndigits
#'
#' @returns
#' @export
#'
#' @examples
fire <- function(x, wd = NULL, ndigits = 3, overwrite = TRUE) {


  # Output file should not exist.
  fn <- "fire.100"
  if (!is.null(wd)) fn <- file.path(wd, fn)
  if (!overwrite) stopifnot("Output File already exists" = !file.exists(fn))


  # First we make a list with parameters that will go into the file.
  elem_names <- c("fdfrem", "fret", "fnue")
  elem_num <- setNames(list(4, c(3, 4), 2), elem_names)
  elements <- list_elements(elem_names, elem_num)
  elements <- c("flfrem", elements[c(1, 2)], "frtsh", elements[3])
  elements <- setNames(elements, c("flfrem", elem_names[c(1, 2)], "frtsh", elem_names[3]))
  elements <- c(list(label = NULL, title = NULL), elements)



  # Next we check that input list 'x' has them all.
  stopifnot("Input 'x' must be a list"= is.list(x))
  stopifnot("Input list 'x' must not be empty" = length(x) > 0)
  x <- lapply(x, function(y) {
    names(y) <- tolower(names(y))
    y
  })
  stopifnot("Elements in list 'x' have wrong names" = all(sapply(x, function(y) all(elements %in% names(y)))))


browser()
}
