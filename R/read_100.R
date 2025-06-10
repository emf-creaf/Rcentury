#' Read *.100 files.
#'
#' @description
#' \code{read_100} reads almost all CENTURY files with extension '*.100'.
#' The only *.100 files that cannot be read with \code{read_100} are site files.
#'
#'
#' @param path \code{character} string with valid path to write the file to.
#' @param filename \code{character} string with the actual file name. It must include the extension '.100'.
#' @param remove_blanks \code{logical}, if set to TRUE any blanks at the end of the file will be removed.
#'
#' @returns
#' A list with the contents of the file.
#'
#' @export
#'
#' @examples
read_100 <- function(path, filename, remove_blanks = TRUE) {


  # Checks.
  stopifnot("File does not exist" = file.exists(file.path(path, filename)))


  # *.sch and *.wth files are not read with this function.
  ext <- tools::file_ext(filename)
  stopifnot("Only files with extension '.100' are read with this function" = ext == "100")


  # Site files, which also have a *.100 extension, should not be read with this function.
  data(files_100)
  stopifnot("This file cannot be read with this function. Is it a 'site' file?" = filename %in% names(files_100))


  # Minimum number of rows to be expected in *.100 CENTURY files.
  data("files_100")
  nrows <- files_100[filename]


  # Read the file.
  x <- readLines(file.path(path, filename))


  # Sometimes the last lines of the file are filled with blanks.
  # if 'remove_blanks' is set to TRUE, we will remove them.
  x <- x[which(trimws(x) != "")]


  # Two cases: the number of lines in 'x' is exactly the corresponding number in files_100,
  # or a multiple of it. Multiple blocks should not happen in fix.100 files; in those cases,
  # it stops with a message.
  if (filename == "fix.100") {
    if (length(x) != nrows) cli::cli_abort(paste0("File fix.100 should have exactly ", nrows, " lines"))
  }
  nblocks <- length(x) / nrows
  stopifnot("Wrong number of rows" = round(nblocks) == nblocks)


  # Look for line with label and title plus lines with data information.
  l_big <- list()
  k <- 0
  for (i in 1:nblocks) {
    k <- k + 1
    l_small <- list()
    z <- splitin2(x[k], "title")
    l_small$label <- unlist(z[1])
    l_small$title <- unlist(z[2])
    df <- data.frame(numeric(0), character(0))
    for (j in 2:nrows) {
      k <- k + 1
      df <- rbind(df, splitin2(x[k], "data"))
    }
    l_small$df <- df
    l_big[[i]] <- l_small
  }


  return(l_big)

}
