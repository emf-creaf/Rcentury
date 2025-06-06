read_100 <- function(path, filename) {


  # Checks.
  stopifnot("File does not exist" = file.exists(file.path(path, filename)))


  # Number of rows to be expected in *.100 CENTURY files.
  data("files_100")
  nr <- files_100[filename]


  # Read the file.
  x <- readLines(file.path(path, filename))


  # Two cases: the number of lines in 'x' is exactly the corresponding number in files_100,
  # or a multiple of it. Multiple blocks should not happen in fix.100 files; in those cases,
  # it stops with a message.
  if (filename == "fix.100") {
    if (length(x) != nr) cli::cli_abort(paste0("File fix.100 should have exactly ", nr, " lines"))
  }


  browser()

}
