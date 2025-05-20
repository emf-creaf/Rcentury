century_data <- function(file = "") {

  # Check correct path and file.
  file <- fn <- match.arg(file, c("crop", "cult", "fert", "fix", "harv", "irri", "omad", "graz", "fire", "tree", "trem"))


  #
  data(data100)
  return(data100[[file]])

}
