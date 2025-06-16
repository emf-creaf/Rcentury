#' Check correctness of field names for a '.100' data set.
#'
#' @param x \code{list} containing the structure of a CENTURY '.100' file
#'
#' @returns
#' @export
#'
#' @examples
check_fields <- function(x) {


  # Input must be a list.
  if (!is.list(x)) cli::cli_abort("Input 'x' must be a list")
  if (length(x) == 0) cli::cli_abort("Input list 'x' must not be empty")


  # An element named 'filename' must exist and should be an actual file name.
  if (is.null(x[["filename"]])) cli::cli_abort("Element 'filename' could not be found in input list 'x'")
  data(files_100)
  if (!(x$filename %in% names(files_100))) cli::cli_abort(paste("Element 'filename' =", filename, "is wrong"))


  # Each element in list 'x' must be elements 'label', 'title' and 'df', and they should not be NULL.
  check_names <- sapply(2:length(x), function(i) {
    y <- x[[i-1]]
    !is.null(y$label) & !is.null(y$title) & !is.null(y$df)
  })
  if (!all(check_names)) cli::cli_abort("Each sublist in 'x' should have 3 elements names 'label', 'title' and 'df'")


  # Number of rows to be expected in each simulation in *.100 CENTURY files. We remove one because the
  # first should correspond to label and title.
  xx <- x
  xx[["filename"]] <- NULL
  n_rows <- files_100[x$filename]-1


  # Two cases: the number of lines in 'x' is exactly the corresponding number in files_100,
  # or a multiple of it. Multiple blocks should not happen in fix.100 files; in those cases,
  # it stops with a message.
  nblocks <- length(xx)
  if (x$filename == "fix.100") {
    if (nblocks != 1) cli::cli_abort("Wrong input list 'x' for 'filename' = 'fix.100'")
    if (nrow(x[[1]]$df) != n_rows) cli::cli_abort(paste0("Element 'df' in input list 'x' should have exactly ", n_rows, " lines"))
  } else {
    nr <- sapply(1:nblocks, function(i) nrow(xx[[i]]$df))
    if (!all(nr == n_rows)) cli::cli_abort("All elements 'df' in input list 'x' should have exactly ", n_rows, " lines")
  }




  # TODO:
  # # Check names in input list are correct.
  # data(data_100)
  # elements <- c("label", "title", data_100[[filename]]$Variable)
  #
  #
  # if (!all(sapply(x, function(y) {
  #   j <- 1
  #   for (y in x) {
  #     print(j)
  #     if (!all(elements %in% c(names(y[1:2]), y$df[, 2]))) browser()
  #     j <- j + 1
  #   }
  #   if (!all(elements %in% c(names(y[1:2]), y$df[, 2]))) browser()
  #   }))) {
  #   cli::cli_abort("Elements in input list 'x' have wrong names")
  # }



  return(x)

}
