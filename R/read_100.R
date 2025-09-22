#' Read *.100 files.
#'
#' @description
#' \code{read_100} reads all CENTURY files with extension '*.100' save for site files, which also have
#' a '.100' extension but have their own function to read them, called \code{\link{read_site}}.
#'
#' @param pathname \code{character} string with valid path to a folder.
#' @param filename \code{character} string specifying the name of the file, which must include the extension '.100'.
#' @param remove_blanks \code{logical}, if set to TRUE any blanks at the end of the file will be removed.
#'
#' @returns
#' A list with the contents of the file.
#'
#' @export
#'
#' @examples
#' # Read one of the CENTURY example files included in the package.
#' pathname <- system.file("extdata/1.soil_texture_ppt",  package = "Rcentury")
#' x <- read_100(pathname, "harv.100")
#'
read_100 <- function(pathname = pathname, filename = filename, remove_blanks = TRUE) {


  # Checks.
  check_path_file(pathname, filename)


  # Check that, if extension is '*.100', it is not a site file (which have a different structure).
  if (tools::file_ext(filename) == "100") {
    data(files_100)
    if (!(filename %in% names(files_100))) {
      warning(paste("Extension is '.100' but", filename, "could not be matched to a valid input CENTURY '*.100' name. Is it a site file?"))
    }
  }


  # Read the file as a character vector. We wrap it in 'suppressWarnings'
  # in case it does not end with a new line.
  x <- suppressWarnings(readLines(file.path(pathname, filename)))


  # Sometimes the last lines of the file are filled with blanks.
  # if 'remove_blanks' is set to TRUE, we will remove them.
  if (remove_blanks) x <- x[which(trimws(x) != "")]


  # Two cases: the number of lines in 'x' is exactly the corresponding number in files_100,
  # or a multiple of it. Multiple blocks should not happen in fix.100 files; in those cases,
  # it stops with a message.
  data(files_100)
  nrows <- files_100[filename]
  if (filename == "fix.100") {
    if (length(x) != nrows) stop(paste0("File fix.100 should have exactly ", nrows, " lines"))
  }


  # Number of rows to be expected in 'filename'.
  nblocks <- length(x) / nrows
  if (round(nblocks) != nblocks) stop(paste("Wrong number of rows in", filename))


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
