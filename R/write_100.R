#' Write *.100 input files for Century
#'
#' @description
#' \code{write_100} allows users to create input files (extension '.100') for the CENTURY soil model.
#'
#' @param x \code{list} with as many elements as events as needed. Each event starts with a short label and a long title.
#' @param pathname \code{character} string with valid path to a folder.
#' @param filename \code{character} string specifying the name of the file with its extension.
#' @param ndigits \code{integer} specifying the number of digits to print for numeric values.
#' @param sep the field separator string. Values within each row of x are separated by this string.
#' @param overwrite \code{logical}, if set to FALSE (default), the code will stop if file already exists. If set to
#' TRUE, the previous file will be overwritten.
#'
#' @returns
#' Nothing. File is created on disk.
#'
#' @details
#' At this stage there are almost no checks as to whether fields are correctly specified. That's left as a researcher's task.
#'
#' @export
#'
#' @examples
#' # Example list with two elements.
#' x <- list()
#'
#' df <- data.frame(runif(11), c(paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")")))
#' colnames(df) <- NULL
#' x[[1]] <- list(label = "E1", title = "Example1", df = df)
#'
#' df <- data.frame(runif(11), c(paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")")))
#' colnames(df) <- NULL
#' x[[2]] <- list(label = "E1", title = "Example1", df = df)
#'
#' # Create temporary path.
#' path <- tempdir()
#' write_100(x, path, "cult.100")
#'
write_100 <- function(x, pathname = pathname, filename = filename, ndigits = 6, sep = "    ", overwrite = FALSE) {


  # Various checks.
  check_path_file(pathname, filename)
  check_overwrite(pathname, filename, overwrite = overwrite)


  # Check names.
  data(files_100)
  if (!(filename %in% names(files_100))) stop(paste0("File name", filename, " is not correct"))


  # Convert into a data.frame with numbers as characters.
  for (i in 1:length(x)) {

    # Select elements and translate column with names to lower case.
    df <- x[[i]]$df
    df[, 2] <- paste0("'", toupper(df[, 2]), "'")


    # Write data.frame to disk.
    df[, 1] <- round(df[, 1], ndigits)
    colnames(df) <- c(x[[i]]$label, x[[i]]$title)
    suppressWarnings(write.table(df, file = file.path(pathname, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = TRUE,
                                 append = ifelse(i == 1, FALSE, TRUE)))
  }

}
