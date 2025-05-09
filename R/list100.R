list100 <- function(wd, args = NULL) {

  if (!is.null(wd)) stopifnot("Path 'wd' does not exist" = file.exists(wd))
  stopifnot("Input 'args' cannot be empty" = !is.null(args))

}
