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
#' # Read one of the CENTURY example files included in the package.
#' path <- system.file("extdata/1.soil_texture_ppt",  package = "Rcentury")
#' x <- read_100(path, "harv.100")
#'
read_100 <- function(path = path, filename = filename, remove_blanks = TRUE) {


  # Checks.
  check_100(path, filename, check_site = FALSE)


  # Minimum number of rows to be expected in *.100 CENTURY files.
  data(files_100)
  nrows <- files_100[filename]


  # Read the file as a character vector. We wrap it in 'suppressWarnings'
  # in case file does not end with a new line.
  x <- suppressWarnings(readLines(file.path(path, filename)))


  # Sometimes the last lines of the file are filled with too many blanks.
  # if 'remove_blanks' is set to TRUE, we will remove them.
  if (remove_blanks) x <- x[which(trimws(x) != "")]


  # Two cases: the number of lines in 'x' is exactly the corresponding number in files_100,
  # or a multiple of it. Multiple blocks should not happen in fix.100 files; in those cases,
  # it stops with a message.
  if (filename == "fix.100") {
    if (length(x) != nrows) cli::cli_abort(paste0("File fix.100 should have exactly ", nrows, " lines"))
  }
  nblocks <- length(x) / nrows
  stopifnot("Wrong number of rows" = round(nblocks) == nblocks)


  # Split input list 'x' by factor.
  group_factor <- rep(1:nblocks, each = nrows, length.out = length(x))
  x <- split(x, group_factor)


  # Build a sublist in each list element.
  x <- lapply(x, function(y) {
    z <- splitin2(y[1], "title")            # First line includes a label and a title.
    l <- list(label = z[1, 1], title = z[1, 2])
    df <- data.frame(value = numeric(0), field = character(0))
    for (i in 2:nrows) df <- rbind(df, splitin2(y[i], "data"))
    l$df <- df
    l
  })


  return(x)

}
