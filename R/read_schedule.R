read_schedule <- function(filename) {


  labels <- c("Starting year", "Last year", "Site file name", "Labeling type", "Labeling year",
              "Microcosm", "CO2 Systems", "pH shift", "Soil warming", "N input scalar option",
              "OMAD scalar option", "Climate scalar option", "Initial system", "Initial crop",
              "Initial tree", "Block #", "Last year", "Repeats # years", "Output starting year",
              "Output month", "Output interval", "Weather choice")


  # Read first 15 lines containing general information.
  header <- list()
  x <- readLines(filename)
  nr <- length(x)
  for (i in 1:15) {
    j <- regexpr(labels[i], x[i], ignore.case = TRUE)
    y <- trimws(substring(x[i], 1, j[1]-1))
    header[[labels[i]]] <- ifelse(!(i == 3 | i == 14 | i == 15), as.numeric(y), y)
  }


  # Next come an empty line (16th) and another line (17th) with the text "Year Month Option". After
  # this, we'll find one or several blocks of parameters, labelled "Block" each.
  i <- grep("Block #", x)
  stopifnot("There are no blocks in the schedule file" = length(i) > 0)


  # Split into blocks and read each.
  i_start <- i[-length(i)]
  i_end <- i[-1]-1
  y <- vector("list", length = length(i))
  for (j in 1:length(i_start)) {
    xx <- x[i_start[j]:i_end[j]]
    yy <- list()

    # First line may have a comment/description to its right.
    l <- regexpr(labels[16], xx[1], ignore.case = TRUE)
    xx1 <- as.numeric(trimws(substring(xx[1], 1, l[1]-1)))
    xx2 <- trimws(substring(xx[1], l[1]+7))
    yy$'Block #' <- setNames(xx1, xx2)


    # Lines 1 to 6 have particular info for this block.
    # Then, line 7 tells about the weather data.
    for (k in 2:7) {
      l <- regexpr(labels[15+k], xx[k], ignore.case = TRUE)
      z <- trimws(substring(xx[k], 1, l[1]-1))
      yy[[labels[15+k]]] <- ifelse(k == 7, z, as.numeric(z))
    }


    # If line 7 has an "F", the name of a weather file will be included in line 8.
    if (yy[[labels[15+k]]] == "F") {
      k <- 8
      yy[["Weather file"]] <- xx[k]
    }


    #



browser()

  }


browser()




}
