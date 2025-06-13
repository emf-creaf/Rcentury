#' Check correctness of field names for a '.100' data set.
#'
#' @param x \code{list} containing the structure of a CENTURY '.100' file
#' @param filename \code{character} string (with extension '.100') specifying the file type 'x' corresponds to.
#'
#' @returns
#' Same as 'x' where each \code{data.frame} has a new \code{logical} column labelled 'name_is_correct' showing
#' TRUE/FALSE if name of the field is correct/wrong.
#'
#' @export
#'
#' @examples
check_fields <- function(x, filename = filename) {


  # Sometimes the last lines of the file are filled with blanks.
  # if 'remove_blanks' is set to TRUE, we will remove them.
  x <- x[which(trimws(x) != "")]


  # Minimum number of rows to be expected in *.100 CENTURY files.
  data(files_100)
  nrows <- files_100[filename]


  # Two cases: the number of lines in 'x' is exactly the corresponding number in files_100,
  # or a multiple of it. Multiple blocks should not happen in fix.100 files; in those cases,
  # it stops with a message.
  # This is also tested in 'read_100.R'.
  if (filename == "fix.100") {
    if (length(x) != nrows) cli::cli_abort(paste0("File fix.100 should have exactly ", nrows, " lines"))
  }
  nblocks <- length(x) / nrows
  stopifnot("Wrong number of rows" = round(nblocks) == nblocks)


  # Look for line with label and title, plus lines with data information.
  l_big <- list()
  k <- 0
  for (i in 1:nblocks) {
    k <- k + 1

    # Label and title.
    z <- splitin2(x[k], "title")
    l_small <- list(label = remove_single_quotes(z[[1]]), title = remove_single_quotes(z[[2]]))

    # Data set for as many rows as 'nrows' minus 1.
    df <- data.frame(value = numeric(0), field = character(0))
    for (j in 2:nrows) {
      k <- k + 1
      y <- splitin2(x[k], "data")
      df <- rbind(df, data.frame(value = y[[1]], field = remove_single_quotes(y[[2]])))
    }

    # To lower case.
    df[, 2] <- tolower(df[, 2])

    # Save into big list.
    l_small$df <- df
    l_big[[i]] <- l_small
  }


  # Check names in input list are correct.
  data(data_100)
  elements <- c("label", "title", data_100[[filename]]$Variable)
  l_compare <- lapply(l_big, function(x) {
    list(label = l_small$label, title = l_small$title, df = data.frame(x$df, name_is_correct = x$df[, 2] %in% elements))
  })


  # Return.
  return(l_compare)

}
