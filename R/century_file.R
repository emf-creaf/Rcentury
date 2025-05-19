#' Title
#'
#' @param x
#' @param file
#' @param wd
#' @param ndigits
#' @param overwrite
#'
#' @returns
#' @export
#'
#' @examples
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
#' century_file(x, "cult.100", wd = wd)
century_file <- function(x, file = "cult", wd = NULL, ndigits = 3, overwrite = TRUE) {


  # Check correct path and file.
  if (!is.null(wd)) stopifnot("Path 'wd' does not exist" = file.exists(wd))
  file <- match.arg(file, paste0(c("crop", "cult", "fert", "fix", "harv", "irri", "omad", "graz", "fire", "tree", "trem"), ".100"))
  if (!is.null(wd)) file <- file.path(wd, file)
  if (!overwrite) stopifnot("Output file already exists. Set 'overwrite' to TRUE?" = !file.exists(file))


  # Check that input 'x' is alist and has all the necessary variables.
  stopifnot("Input 'x' must be a list"= is.list(x))
  stopifnot("Input list 'x' must not be empty" = length(x) > 0)
print(file)
  elements <- c("label", "title", data100[[file]]$Variable)
  x <- elements_tolower(x)
  stopifnot("Elements in list 'x' have wrong names" = all(sapply(x, function(y) all(elements %in% names(y)))))

print(elements)


}
