#' Check correctness of field names for a '.100' data set.
#'
#' @param x \code{list} containing the structure of a CENTURY '.100' file
#'
#' @returns
#' @export
#'
#' @examples
check_fields <- function(x, filename = filename) {

  # Are inputs there?
  if (missing(filename)) stop("Missing input 'filename'")


  # Input must be a list.
  if (!is.list(x)) stop("Input 'x' must be a list")
  if (length(x) == 0) stop("Input list 'x' must not be empty")


  # Each element in list 'x' must have elements 'label', 'title' and 'df'.
  check_names <- sapply(1:length(x), function(i) {
    !is.null(x[[i]]$label) & !is.null(x[[i]]$title) & !is.null(x[[i]]$df)
  })
  if (!all(check_names)) stop("Each sublist in 'x' should have 3 elements names 'label', 'title' and 'df'")


  # Number of rows to be expected in each simulation in *.100 CENTURY files. We remove one because the
  # first should correspond to label and title.
  data(files_100)
  n_rows <- files_100[filename]-1


  # Two cases: the number of lines in 'x' is exactly the corresponding number in files_100,
  # or a multiple of it. Multiple blocks should not happen in fix.100 files; in those cases,
  # it stops with a message.
  nblocks <- length(x)
  if (filename == "fix.100") {
    if (nblocks != 1) stop("Wrong input list 'x' for 'filename' = 'fix.100'")
    if (nrow(x[[1]]$df) != n_rows) stop(paste0("Element 'df' in input list 'x' should have exactly ", n_rows, " lines"))
  } else {
    nr <- sapply(1:nblocks, function(i) nrow(x[[i]]$df))
    if (!all(nr == n_rows)) stop("All elements 'df' in input list 'x' should have exactly ", n_rows, " lines")
  }


  # Check names in input list are correct.
  data(data_100)
  elements <- c("label", "title", data_100[[filename]]$Variable)
  q <- NULL
  for (y in x) {
    q <- elements %in% c(tolower(names(y[1:2])), tolower(y$df[, 2]))
    q <- c(q, q)
  }
  if (any(q == FALSE)) warning(paste("Elements in input list 'x' of", filename, "have wrong names"))


  return(x)

}
