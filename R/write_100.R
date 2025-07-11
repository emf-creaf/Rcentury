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
#' set.seed(100)
#' x <- list()
#' x[[1]] <- list("E1", "Example1")
#' x[[1]] <- append(x[[1]], runif(11))
#' names(x[[1]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))
#' x[[2]] <- list("E2", "Example2")
#' x[[2]] <- append(x[[2]], runif(11))
#' names(x[[2]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))
#'
#' # Fewer digits.
#' x[[1]]$`cultra(3)` <- 0.3
#'
#' # Create file locally.
#' wd <- ".//data-raw//example"
#' write_100(x, "cult", wd = wd)
#'
#' # Read one of the CENTURY example files included in the package.
#' path <- system.file("extdata/1.soil_texture_ppt",  package = "Rcentury")
#' x <- read_100(path, "harv.100")
#'
#'
write_100 <- function(x, path = path, filename = filename, ndigits = 4, sep = "    ", verbose = TRUE) {

  # Check that input list is correct. TODO!!!
  # x <- check_fields(x, filename)


  # Check correct path and file, and remove previous file if overwrite has been set to TRUE.
  check_write(path, filename, overwrite = TRUE)


  # Check that name of the file with extension *.100 is correct.
  check_100(path, filename, check_site = FALSE)


  # Convert into a data.frame with numbers as characters.
  for (i in 1:length(x)) {

    # Select elements and translate column with names to lower case.
    df <- x[[i]]$df
    df[, 2] <- paste0("'", toupper(df[, 2]), "'")


    # Write data.frame to disk.
    df[, 1] <- round(df[, 1], ndigits)
    colnames(df) <- c(x[[i]]$label, x[[i]]$title)
    suppressWarnings(write.table(df, file = file.path(path, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = TRUE,
                                 append = ifelse(i == 1, FALSE, TRUE)))
  }

}
