#' Title
#'
#' @param df
#'
#' @returns
#'
#' @examples
#' data(data100)
#' check_range(data100$cult)
check_range <- function(df) {

  stopifnot("Column names are wrong" = all(c("Variable", "Range") %in% colnames(df)))

  v <- df$Variable
  r <- df$Range

  # Split by "or", "to", ";"
  x_or <- lapply(strsplit(df$Range, "or", fixed = TRUE), trimws)
  x_to <- lapply(strsplit(df$Range, "to", fixed = TRUE), trimws)
  x_se <- lapply(strsplit(df$Range, ";", fixed = TRUE), trimws)


  # USE A FACTOR FOR ORDINAL OR CATEGORICAL VALUES AND A VECTOR WITH TWO COMPONENTS FOR A BOUNDED INTERVAL!!

  # How many elements?
  n_or <- sapply(x_or, length)
  n_to <- sapply(x_to, length)
  n_se <- sapply(x_se, length)


  # Select split.
  xlimits <- lapply(1:length(df$Range), function(i) {
    if (n_or[i] == 2) {
      x_or[[i]]
    } else if (n_to[i] == 2) {
      x_to[[i]]
    } else if (n_se[i] > 1) {
      x_se[[i]]
    } else NA
  })


  # Decide limits.
  xbounds <- lapply(1:length(df$Range), function(i) {
    if (all(!is.na(xlimits[[i]]))) {
      c(min = check_numeric_character(xlimits[[i]][1], "min"),
        max = check_numeric_character(xlimits[[i]][1], "max"))
    } else NA
  })
browser()

  minmax_or <- lapply(x_or, function(z) {
    c(min = check_numeric_character(z[1], "min"),
      max = check_numeric_character(z[2], "max"))
  })
  minmax_to <- lapply(x_to, function(z) {
    c(min = check_numeric_character(z[1], "min"),
      max = check_numeric_character(z[2], "max"))
  })




browser()

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
