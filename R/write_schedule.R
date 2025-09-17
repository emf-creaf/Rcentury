#' Save to disk a *.sch CENTURY file
#'
#' @description
#' \code{write_schedule} writes to disk an ASCII *.sch file to be used by the CENTURY soil model.
#'
#' @param x \code{list} with content of the schedule file.
#' @param pathname valid path to write the file to.
#' @param filename \code{character} string with the actual file name. It must include the extension '.sch'.
#' @param overwrite \code{logical}, if set to TRUE and the file already exists, it will overwrite; if set to
#' FALSE and the file exists, it will stop with an error message.
#' @param verbose \code{logical},
#'
#' @returns
#' @export
#'
#' @examples
write_schedule <- function(x, pathname = pathname, filename = filename, overwrite = FALSE) {


  # Checks.
  check_path_file(pathname, filename)
  check_overwrite(pathname, filename, overwrite = overwrite)


  # Load labels for schedule files.
  data("labels_schedule")


  # Checks.
  if (!is.list(x)) {
    stop("Input 'x' must be a list")
  }
  if (!(all(c("header", "block_info") %in% names(x)))) {
    stop("Cannot find 'header' and 'block_info' elements in input list 'x'")
  }
  if (!(all(labels_schedule[1:15] %in% names(x$header)))) {
    stop("Elements in sub-list 'header' are wrong")
  }
  if (tools::file_ext(filename) != "sch") {
    stop("Filename must include extension 'sch'")
  }


  # Write header. A blank line is added, then a "Year Month Option" line.
  h <- character(0)
  for (i in 1:length(x$header)) {
    xx <- unlist(x$header[i])
    if (xx == "") xx[1] <- "   "
    h <- c(h, paste(xx, names(xx), sep = "      "))
  }
  h <- c(h, "")
  h <- c(h, "Year Month Option")
  write(h, file = file.path(pathname, filename))


  # Next we add the different blocks.
  for (i in 1:length(x$block_info)) {

    # Specific parameters for this block. If 'Weather choice' is equal to F, the name of
    # the weather file is added.
    xx <- x$block_info[[i]]
    h <- paste(xx$`Block #`, "Block #", names(xx$`Block #`), sep = "  ")
    for (j in 2:7) {
      lab <- labels_schedule[j+15]
      h <- c(h, paste(xx[[j]], lab, sep = "   "))
    }
    if (xx$`Weather choice` == "F") h <- c(h, xx$`Weather file`)

    # Block schedule.
    h <- c(h, apply(xx$Schedule, 1, function(z) paste(z, collapse = " ")))

    # End of block.
    h <- c(h, c("-999 -999 X"))


    write(h, file = file.path(pathname, filename), append = TRUE)
  }

}
