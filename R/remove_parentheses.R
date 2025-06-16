remove_parentheses <- function(x) {

  x <- gsub("\\(", "", x)
  x <- gsub("\\)", "", x)

  return(x)

}
