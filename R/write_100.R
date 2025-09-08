#' Write *.100 input files for Century
#'
#' @description
#' \code{century_file} allows users to create input files (extension '.100') for the Century soil model.
#'
#' @param x \code{list} with as many elements as events as needed. Each event starts with a short label and a long title.
#' @param path directory to save '*.100' file.
#' @param ndigits number of digits for numeric values.
#'
#' @returns
#' Nothing. File is created on disk.
#'
#' @details
#' File is overwritten.
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
write_100 <- function(x, path = path, filename = filename, ndigits = 6, sep = "    ", overwrite = FALSE) {


  # checks.
  check_write(path, filename, overwrite = overwrite)
  check_ext(filename, "100")


  # Convert into a data.frame with numbers as characters.
  for (i in 1:length(x)) {

    # Select elements and translate column with names to lower case.
    df <- x[[i]]$df
    df[, 2] <- paste0("'", toupper(df[, 2]), "'")


    # Write data.frame to disk.
    df[, 1] <- round(df[, 1], ndigits)
    colnames(df) <- c(x[[i]]$label, x[[i]]$title)
    suppressWarnings(write.table(i, file = file.path(path, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = TRUE,
                                 append = ifelse(i == 1, FALSE, TRUE)))
    suppressWarnings(write.table(df, file = file.path(path, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = TRUE,
                                 append = ifelse(i == 1, FALSE, TRUE)))
  }

}
