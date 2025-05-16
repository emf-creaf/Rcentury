#' Write 'cult.100' file on disk
#'
#' @description
#' \code{cult} writes on disk a file named 'cult.100' onto disk.
#'
#' @param x \code{list} containing...
#' @param wd string with valid file path.
#' @param ndigits number of digits with which to round.
#'
#' @returns
#' Nothing. A file names 'cult.100' is written on disk.
#'
#' @details
#' Straightforward. Default value is zero for all elements.
#'
#' @export
#'
#' @examples
#'
#' # Example list with two elements.
#' x <- list()
#' x[[1]] <- list("E1", "Example1")
#' x[[1]] <- append(x[[1]], runif(11))
#' names(x[[1]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))
#' x[[2]] <- list("E1", "Example1")
#' x[[2]] <- append(x[[2]], runif(11))
#' names(x[[2]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))
#'
#' # Fewer digits.
#' x[[1]]$`cultra(3)` <- 0.3
#'
#' # Create file locally.
#' wd <- ".//data-raw//example"
#' cult(x, wd, ndigits = 2)

cult <- function(x, wd = NULL, ndigits = 3, overwrite = TRUE) {


  # Check correct path and file.
  if (!is.null(wd)) stopifnot("Path 'wd' does not exist" = file.exists(wd))
  fn <- "cult.100"
  if (!is.null(wd)) fn <- file.path(wd, fn)
  if (!overwrite) stopifnot("Output File already exists" = !file.exists(fn))


  # Check that input 'x' has all the necessary variables, plus 'label' and 'title'.
  stopifnot("Input 'x' must be a list"= is.list(x))
  stopifnot("Input list 'x' must not be empty" = length(x) > 0)
  elements <- c("label", "title", data100$cult.100$Variable)
  x <- lapply(x, function(y) {
    names(y) <- tolower(names(y))
    y
  })
  stopifnot("Elements in list 'x' have wrong names" = all(sapply(x, function(y) all(elements %in% names(y)))))


  # Check digits for numerical results.
  stopifnot("Wrong 'ndigits' value" = all(ndigits > 0 & round(ndigits) == ndigits))
  if (ndigits > 8) warning("Input 'ndigits' value is probably too high")
  for (i in 1:length(x)) x[[i]][-c(1, 2)] <- round(unlist(x[[i]][-c(1, 2)]), digits = ndigits)
browser()
  # Check 'x' are ok.
  # stopifnot("Elements in 'cultra' element of 'x' must have values within interval [0, 1]" =
  #             all(sapply(x, function(y) all(y$cultra >= 0 & y$cultra <= 1))))
  # stopifnot("Elements in 'clteff' element of 'x' must have values within interval [0, 1]" =
  #             all(sapply(x, function(y) all(y$clteff >= 0 & y$clteff <= 1))))


  # We convert into a data.frame with numbers as characters.
  df <- NULL

  # as.data.frame(unname(unlist(x[[1]][-c(1, 2)])))
  for (i in 1:length(x)) {
    xx <- x[[i]]
    df <- rbind(df, c(xx$label, xx$title))
    for (j in 1:7) {
      df <- rbind(df, c(xx$cultra[j], paste0("'", cultra[j], "'"), use.names = FALSE))
    }
    for (j in 1:4) {
      df <- rbind(df, c(xx$clteff[j], paste0("'", clteff[j], "'"), use.names = FALSE))
    }
  }


  # Add empty spaces to number column to align them.
  df[, 1] <- sapply(df[, 1], function(y) check_length_digits(y, ndigits))


  # Save file on disk.

  write.table(df, file = fn, sep = "        ", quote = FALSE, row.names = FALSE, col.names = FALSE)

}
