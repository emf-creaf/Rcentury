#' Title
#'
#' @param x
#' @param pathname
#' @param filename
#' @param overwrite
#'
#' @returns
#' @export
#'
#' @examples
write_site <- function(x, pathname = pathname, filename = filename, ndigits = 6, sep = "    ", overwrite = FALSE) {


  # Checks.
  check_path_file(pathname, filename)
  check_overwrite(pathname,filename, overwrite= overwrite)


  # To check out whether x has the required fields.
  data(data_100)
  num_rows <- table(data_100$`<site>.100`$`Parameter type`)
  sections <- names(num_rows)

  i <- pmatch(tolower(sections), tolower(names(x)))
  if (any(is.na(i))) stop("Fields in input list 'x' have wrong names")

  if (is.na(match("title", tolower(names(x))))) stop("Input list 'x' must contain a field called 'title'")


  # First, write title field.
  suppressWarnings(write.table(x$title, file = file.path(pathname, filename), sep = "",
                               quote = FALSE, row.names = FALSE, col.names = FALSE,
                               append = FALSE))


  # Convert into a data.frame with numbers as characters.
  for (i in names(x)[-match("title", names(x))]) {

    # Select elements and change formats.
    df <- x[[i]]$df
    df$value <- round(df$value, ndigits)
    df$field <- paste0("'", toupper(df$field), "'")


    # Write data.frame to disk.
    suppressWarnings(write.table(paste0("*** ", toupper(i)), file = file.path(pathname, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = FALSE,
                                 append = TRUE))
    suppressWarnings(write.table(df, file = file.path(pathname, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = FALSE,
                                 append = TRUE))
  }

}
