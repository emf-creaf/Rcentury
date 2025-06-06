#' Write *.100 input files for Century
#'
#' @description
#' \code{century_file} allows users to create input files (extension '.100') for the Century soil model
#'
#'
#' @param x \code{list} with as many elements as events as needed. Each event starts with a short label and a long title.
#' @param file \code{character} string with the name of the file to be created. Only names accepted by CENTURY are accepted.
#' @param wd directory to save '*.100' file.
#' @param ndigits number of digits for numeric values.
#' @param overwrite \code{logical}, if set to TRUE file will be overwritten if it already exists on disk.
#'
#' @returns
#' Nothing. File is created on disk.
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
write_100 <- function(x, fileout = "", wd = NULL, ndigits = 3, check_values = FALSE, overwrite = TRUE, sep = "       ", verbose = TRUE) {


  # Check correct path and file.
  fileout <- fn <- match.arg(fileout, c("crop", "cult", "fert", "fix", "harv", "irri", "omad", "graz", "fire", "tree", "trem"))
  fileout <- check_path(fileout, ".100", wd, verbose = verbose)
  fileout <- check_overwrite(fileout, overwrite = overwrite, verbose = verbose)


  # Check that input 'x' is a list and has all the necessary variables.
  stopifnot("Input 'x' must be a list"= is.list(x))
  stopifnot("Input list 'x' must not be empty" = length(x) > 0)

  data("data100")
  elements <- c("label", "title", data100[[fn]]$Variable)
  x <- lapply(x, function(y) {
    names(y) <- tolower(names(y))
    y
  })
  stopifnot("Elements in list 'x' have wrong names" = all(sapply(x, function(y) all(elements %in% names(y)))))


  # We convert into a data.frame with numbers as characters. We also add empty spaces to number column to align them.
  df <- data.frame()
  for (i in 1:length(x)) {
    xx <- x[[i]]
    y <- unlist(xx[elements[-c(1, 2)]])
    y <- round(y, ndigits)
    y <- sapply(y, function(z) check_length_digits(z, ndigits))
    y <- rbind(c(xx$label, xx$title), cbind(y, elements[-c(1, 2)], deparse.level = 0), make.row.names = FALSE)
    df <- rbind(df, y, make.row.names = FALSE, deparse.level = 0)
  }
  df$V2 <- paste0("'", toupper(df$V2), "'")


  # Save file on disk.
  write.table(df, file = fileout, sep = sep, quote = FALSE, row.names = FALSE, col.names = FALSE)

}
