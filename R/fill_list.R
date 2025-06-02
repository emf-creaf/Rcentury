#' Create a list with simulations
#'
#' @param df \code{dataframe} or \code{tibble} with content of file.
#' @param type file name the data come from.
#'
#' @returns
#' A \code{list}.
#'
#' @examples
fill_list <- function(df, type = NULL) {


  # Checks.
  stopifnot("Please, specify which 'type' of file" = !is.null(type))


  # Number of rows for each type of file without titles and labels of simulations.
  np <- switch(type, crop.100 = 89, cult.100 = 11, fert.100 = 5, fix.100 = 214, harv.100 = 6,
               irri.100 = 4, omad.100 = 10, graz.100 = 11, fire.100 = 20, tree.100 = 126, trem.100 = 20)


  # Number of simulations.
  i <- sapply(df[, 1], function(z) is_numeric_string(z), USE.NAMES = FALSE)
  stopifnot("There must be at least one simulation with label and title" = any(i))
  i <- which(i)


  # Making the list 'x' with simulations.
  x <- vector("list", length(i))
  for (j in 1:length(i)) {
    df2 <- df[i[j]:(i[j]+np), ]
    label = df2[1, 1]
    title = df2[1, 2]
    df2 <- df2[-1, ]
    xx <- setNames(lapply(1:np, function(k) as.numeric(df2[k, 1])), toupper(df2[1:np, 2]))
    x[[j]] <- c(list(label = label, title = title), xx)
  }


  return(x)
}
