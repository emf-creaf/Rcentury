#' Write *.100 input files for Century
#'
#' @description
#' \code{century_file} allows users to create input files (extension '.100') for the Century soil model.
#'
#' @param x \code{list} with as many elements as events as needed. Each event starts with a short label and a long title.
#' @param path directory to save '*.100' file.
#' @param filename \code{character} string with the name of the file to be created. Only names accepted by CENTURY are accepted.
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
write_100 <- function(x, path = path, filename = filename, ndigits = 3, check_values = FALSE, sep = "       ", verbose = TRUE) {


  # Check correct path and file, and remove previous file if overwrite has been set to TRUE.
  check_write(path, filename, overwrite = TRUE)


  # Check that name of the file with extension *.100 is correct.
  check_100(path, filename, check_site = FALSE)


  # Check that input 'x' is a list and has all the necessary variables.
  if (!is.list(x)) cli::cli_abort("Input object 'x' must be a list")
  if (length(x) == 0) cli::cli_abort("Input list 'x' must not be empty")


  # Translate variable names to lower case.
  x <- lapply(x, function(y) {
    names(y) <- tolower(names(y))
    y
  })


  # Check names in input list are correct.
  data(data_100)
  elements <- c("label", "title", data_100[[filename]]$Variable)


  if (!all(sapply(x, function(y) {
    j <- 1
    for (y in x) {
      print(j)
      if (!all(elements %in% c(names(y[1:2]), y$df[, 2]))) browser()
      j <- j + 1
    }
    if (!all(elements %in% c(names(y[1:2]), y$df[, 2]))) browser()
    }))) {
    cli::cli_abort("Elements in input list 'x' have wrong names")
  }


  # Convert into a data.frame with numbers as characters.
  for (i in 1:length(x)) {
    xx <- x[[i]]

    # Check label and title.
    if (xx$label == "" | xx$title == "") cli::cli_abort("Label and title cannot be empty")

    # Select elements
    df <- unlist(xx[elements[-c(1, 2)]])

    # Convert numbers to characters.
    df <- round(df, ndigits)
    df <- sapply(df, function(z) check_length_digits(z, ndigits))

    # Write data.frame to disk.
    df <- data.frame(names(df), unname(df))
    colnames(df) <- xx[c("label", "title")]
    suppressWarnings(write.table(df, file = file.path(path, filename), sep = sep,
                                 quote = FALSE, row.names = FALSE, col.names = TRUE,
                                 append = ifelse(i == 1, FALSE, TRUE)))
  }

}
