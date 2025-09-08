#' Title
#'
#' @param x
#' @param path
#' @param filename
#' @param overwrite
#'
#' @returns
#' @export
#'
#' @examples
write_site <- function(x, path = path, filename = filename, ndigits = 6, sep = "    ", overwrite = FALSE) {


  # Checks.
  check_write(path, filename, overwrite = overwrite)
  check_ext(filename, "100")


  # To check out whether x has the required fields.
  data(data_100)
  num_rows <- table(data_100$`<site>.100`$`Parameter type`)
  sections <- names(num_rows)

  i <- pmatch(tolower(sections), tolower(names(x)))
  if (any(is.na(i))) stop("Fields in input list 'x' have wrong names")

  if (is.na(match("title", tolower(names(x))))) stop("Input list 'x' must contain a field called 'title'")


  # First, write title field.
  suppressWarnings(write.table(x$title, file = file.path(path, filename), sep = "",
                               quote = FALSE, row.names = FALSE, col.names = FALSE,
                               append = FALSE))


  # Convert into a data.frame with numbers as characters.
  for (i in names(x)[-match("title", names(x))]) {

    # Select elements and change formats.
    df <- x[[i]]$df
    df$value <- round(df$value, ndigits)
    df$field <- paste0("'", toupper(df$field), "'")


    # Write data.frame to disk.
    suppressWarnings(write.table(paste0("*** ", toupper(i)), file = file.path(path, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = FALSE,
                                 append = TRUE))
    suppressWarnings(write.table(df, file = file.path(path, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = FALSE,
                                 append = TRUE))
  }

}
