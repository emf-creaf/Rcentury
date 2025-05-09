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
#' x[[1]] <- list(label = "E", title = "Example", cultra = runif(7), clteff = runif(4))
#' names(x[[1]]$cultra) <- paste0("cultra(", 1:7, ")")
#' names(x[[1]]$clteff) <- paste0("clteff(", 1:4, ")")
#' x[[2]] <- list(label = "E", title = "Example", cultra = runif(7), clteff = runif(4))
#' names(x[[2]]$cultra) <- paste0("cultra(", 1:7, ")")
#' names(x[[2]]$clteff) <- paste0("clteff(", 1:4, ")")
#'
#' # Fewer digits.
#' x[[1]]$cultra[3] <- 0.3
#'
#' # Create file locally.
#' cult(x, ndigits = 4)

cult <- function(x, wd = NULL, ndigits = 3) {


  # Elements in 'x'.
  elements <- c("label", "title", "cultra", "clteff")
  cultra <- paste0("cultra(", 1:7, ")")
  clteff <- paste0("clteff(", 1:4, ")")


  # Check inputs.
  stopifnot("Input 'x' must be a list"= is.list(x))
  stopifnot("Elements in list 'x' have wrong names" = all(sapply(x, function(y) all(elements %in% names(y)))))
  stopifnot("Wrong element 'cultra' in input list 'x'" = all(sapply(x, function(y) cultra %in% names(y$cultra))))
  stopifnot("Wrong element 'clteff' in input list 'x'" = all(sapply(x, function(y) clteff %in% names(y$clteff))))

  if (!is.null(wd)) stopifnot("Path 'wd' does not exist" = file.exists(wd))

  stopifnot("Wrong 'ndigits' value" = all(ndigits > 0 & round(ndigits) == ndigits))
  if (ndigits > 8) warning("Input 'ndigits' value is probably too high")


  # Check values in 'x' are ok.
  stopifnot("Elements in 'cultra' element of 'x' must have values within interval [0, 1]" =
              all(sapply(x, function(y) all(y$cultra >= 0 & y$cultra <= 1))))
  stopifnot("Elements in 'clteff' element of 'x' must have values within interval [0, 1]" =
              all(sapply(x, function(y) all(y$clteff >= 0 & y$clteff <= 1))))


  # Round numbers.
  nx <- length(x)
  for (i in 1:nx) {
    x[[i]]$cultra <- round(x[[i]]$cultra, digits = ndigits)
    x[[i]]$clteff <- round(x[[i]]$clteff, digits = ndigits)
  }


  # We convert into a data.frame with numbers as characters.
  df <- NULL
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
  filnam <- "cult.100"
  if (!is.null(wd)) filnam <- file.path(wd, filnam)
  write.table(df, file = filnam, sep = "        ", quote = FALSE, row.names = FALSE, col.names = FALSE)

}
