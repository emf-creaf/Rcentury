#' Title
#'
#' @param df
#'
#' @returns
#'
#' @examples
#' data(data100)
#' extract_range(data100$`<site>`)
extract_range <- function(df) {

  stopifnot("Column names are wrong" = all(c("Variable", "Range") %in% colnames(df)))


  # Split by "or", "to", ";"
  bounds <- lapply(df$Range, function(x) {
    if (grepl("to", x)) {
      y <- unlist(strsplit(x, "to"))
      c(min = check_numeric_character(y[1], "min"),
        max = check_numeric_character(y[2], "max"))
    } else if (grepl("or", x)) {
      factor(trimws(unlist(strsplit(x, "or"))))
    } else if (grepl(";", x)) {
      factor(trimws(unlist(strsplit(x, ";"))))
    } else if (is.na(x)) {
      NA
    }
  })


  # Name list elements.
  names(bounds) <- df$Variable


  return(bounds)

}
