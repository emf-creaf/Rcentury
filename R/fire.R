#' Schedules a fire in the current month
#'
#' @param x
#' @param wd
#' @param ndigits
#'
#' @returns
#' @export
#'
#' @examples
fire <- function(x, wd = NULL, ndigits = 3) {


  # Elements in 'x'.
  elem_names <- c("fdfrem", "fret", "fnue")
  elem_num <- setNames(list(4, c(3, 4), 2), elem_names)
  elements <- lapply(elem_names, function(x) {
    if (length(elem_num[[x]]) == 1) {
      paste0(x, "(", seq(1, elem_num[[x]], by = 1), ")")
    } else {
      dxy <- elem_num[[x]]
      y <- NULL
      for (i in 1:dxy[1]) {
        for (j in 1:dxy[2]) {
          y <- c(y, paste0(x, "(", i, ",", j, ")"))
        }
      }
      y
    }
  })

  elements <- c("flfrem", elements[c(1, 2)], "frtsh", elements[3])

  flfrem <- paste0("cultra(", 1:7, ")")
  clteff <- paste0("clteff(", 1:4, ")")


  elements <- c("label", "title", elements)
}
