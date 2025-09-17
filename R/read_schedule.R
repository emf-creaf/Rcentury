#' @title title
#' Read *.sch CENTURY files.
#'
#' @description
#' \code{read_schedule} reads *.sch CENTURY soil model files and saves their content in a list.
#'
#' @param pathname \code{character} string containing a valid path to a *.sch file.
#' @param filename \code{character} string with the name of the schedule file. It must include the extension '.sch'.
#'
#' @returns
#' \code{list} with two elements named 'header' and 'block_inf', each one being also a \code{list}.
#' The former list includes basic schedule information that is common to all blocks and that is stored at the
#' beginning of the file. The latter list has as many elements as treatment blocks, and within each block there are some
#' info bits specific to that block and a three-column \code{data.frame}, stored in an element named 'Schedule', with the timing
#' of treatment. Columns are labelled 'year', 'month' and 'option'.
#' @export
#'
#' @examples
read_schedule <- function(pathname = pathname, filename = filename) {


  # Checks.
  check_path_file(pathname, filename)


  # Labels to be found inside *.sch CENTURY files.
  data("labels_schedule")


  # Read first 15 lines containing general information.
  header <- list()
  x <- readLines(file.path(pathname, filename))
  nr <- length(x)
  for (i in 1:15) {
    j <- regexpr(labels_schedule[i], x[i], ignore.case = TRUE)
    y <- trimws(substring(x[i], 1, j[1]-1))
    header[[labels_schedule[i]]] <- ifelse(!(i == 3 | i == 14 | i == 15), as.numeric(y), y)
  }


  # If either "Initial crop" or "Initial tree" are empty, add blanks.
  if (header[["Initial crop"]] == "") header[["Initial crop"]] <- "    "
  if (header[["Initial tree"]] == "") header[["Initial tree"]] <- "    "


  # Next come an empty line (16th) and another line (17th) with the text "Year Month Option". After
  # this, we'll find one or several blocks of parameters, labelled "Block" each.
  i <- grep("Block #", x)
  stopifnot("There are no blocks in the schedule file" = length(i) > 0)


  # Split into blocks and read each.
  block_list <- vector("list", length = length(i))
  for (j in 1:length(i)) {

    # Temporary list for block info.
    bck_info <- list()


    # Extract lines to facilitate workflow.
    xx <- x[i[j]:nr]


    # First line may have a comment/description on the right.
    l <- regexpr(labels_schedule[16], xx[1], ignore.case = TRUE)
    xx1 <- as.numeric(trimws(substring(xx[1], 1, l[1]-1)))
    xx2 <- trimws(substring(xx[1], l[1]+7))
    bck_info[["Block #"]] <- setNames(xx1, xx2)


    # Lines 1 to 6 have particular info for this block.
    # Then, line 7 tells about the weather data.
    for (k in 2:7) {
      l <- regexpr(labels_schedule[15+k], xx[k], ignore.case = TRUE)
      z <- trimws(substring(xx[k], 1, l[1]-1))
      bck_info[[labels_schedule[15+k]]] <- ifelse(k == 7, z, as.numeric(z))
    }


    # Line 3 specifies the name of the site file, but does it exist?
    stopifnot("Site file does not exist" = file.exists(file.path(pathname, filename)))


    # If line 7 has an "F", the name of a weather file will be included in line 8.
    # We also check that it exists.
    if (bck_info[[labels_schedule[15+k]]] == "F") {
      k <- 8
      bck_info[["Weather file"]] <- xx[k]
    }


    # Next comes the schedule as a three-column table: year, month, option.
    # It ends with a "-999 -999 X" line.
    df_sch <- data.frame(year = numeric(0), month = numeric(0), option = character(0))
    repeat {
      k <- k + 1
      z <- unlist(strsplit(trimws(xx[k]), " +"))
      if (length(z) == 4) z <- c(z[1:2], paste(z[-c(1, 2)], collapse = " "))
      if (all(z == c("-999", "-999", "X"))) break
      df_sch <- rbind(df_sch, data.frame(year = as.numeric(z[1]), month = as.numeric(z[2]), option = z[3]))
    }
    bck_info[["Schedule"]] <- df_sch


    # Save in list.
    block_list[[j]] <- bck_info

  }


  return(list(header = header, block_info = block_list))

}
