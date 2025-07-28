#' Title
#'
#' @param path
#' @param filename
#'
#' @returns
#' @export
#'
#' @examples
read_site <- function(path = path, filename = filename) {


  # Checks.
  check_read(path, filename)
  check_ext(filename, "100")


  # Sections in file.
  sections <- c("Climate", "Site and control", "External nutrient",
                "Organic matter", "Forest organic matter",
                "Mineral", "Water")


  # To check out fields in site file. We calculate how many parameters there should be in each
  # section of the file.
  data(data_100)
  num_rows <- table(data_100$`<site>.100`$`Parameter type`)


  # Read the file as a character vector. We wrap it in 'suppressWarnings'
  # in case it does not end with a new line.
  x <- suppressWarnings(readLines(file.path(path, filename)))


  # Find sections in file data. Result is a vector where NA indicates that pattern has not been found.
  # Sorting the indices makes sure they are in the same order as they appear in file.
  j <- sapply(sections, function(z) ifelse(length(grep(z, x))==0, NA, grep(z, x)))
  if (any(is.na(j))) stop("Site file does not contain all necessary sections")
  j <- sort(j)
  j <- c(j, EOF = length(x)+1)


  # Is the number of parameters correct?
  nr <- setNames(diff(j)-1, names(j)[-length(j)])
  k <- pmatch(names(nr), names(num_rows))
  if (any(all(num_rows[k] != nr))) stop("Number of parameters is wrong")


  # Get the indices of elements containing sections. There may be a descriptive title in first line.
  l <- list()
  if  (min(j) == 2) l$title <- x[1]
  names_j <- names(j)
  for (i in 1:(length(j)-1)) {
    y <- lapply(x[seq(j[i]+1, j[i+1]-1)], function(z) splitin2(z, "data"))
    l[[names_j[i]]]$df <- do.call(rbind, y)
  }

browser()




}
