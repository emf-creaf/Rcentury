#' Title
#'
#' @param df
#'
#' @returns
#'
#' @examples
check_range <- function(df) {

  stopifnot("Column names are wrong" = all(c("Variable", "Range") %in% colnames(df)))

  v <- df$Variable
  r <- df$Range

  # Split by "or", "to", ";"?
  x_or <- strsplit(df$Range, "or", fixed = TRUE)
  x_to <- strsplit(df$Range, "to", fixed = TRUE)
  x_qu <- strsplit(df$Range, "?", fixed = TRUE)
  x_se <- strsplit(df$Range, ";", fixed = TRUE)




  f2 <- function(y)

  df$range <- NA
  for (i in 1:length(x_or)) {
print(i)
    if (length(x_or[[i]]) == 2) {
      x <- f1(x_or[[i]])
    } else if (length(x_to[[i]]) == 2 ) {
      x <- f1(x_to[[i]])
    } else if (length(x_qu[[i]]) == 2) {
      x <- f1(x_qu[[i]])
    } else if (length(x_se[[i]]) > 1) {
      x <- as.numeric(x_se[[i]])
    } else if (is.na(df$Range[i])) {
      x <- NA
    } else {
      browser()
      stop("Could not find how to split")
    }
    df$range[i] <- list(x)
  }

  browser()



}
