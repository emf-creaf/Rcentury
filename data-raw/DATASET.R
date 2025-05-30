path <- ".//data-raw//Century47//Variables_Century4.7_June_2017.xlsx"


###### DEFINITIONS FOR VARIABLES.

# Content of input file.
input_file <- c("crop", "cult", "fert", "fix", "harv", "irri", "omad", "<site>", "graz", "fire", "tree", "trem")
data100 <- sapply(input_file, function(x) {
  suppressMessages(readxl::read_xlsx(path, sheet = paste0(x, ".100"), progress = FALSE))
})


# Content of output file.
databin <- suppressMessages(readxl::read_xlsx(path, sheet = "output", progress = FALSE))


# Harversting file.
dataharvest <- suppressMessages(readxl::read_xlsx(path, sheet = "harvest.csv", progress = FALSE))


# Parameter SORPMX, among some others, in <site> file may have wrong range.

# Save as internal dataset.
usethis::use_data(data100, databin, dataharvest, overwrite = TRUE)



###### EXAMPLE FILES.

# NOT FINISHED! READING cult.100 GIVES ERROR MESSAGES BECAUSE WE MUST SEPARATE BETWEEN TREATMENTS.




# Reading Excel file.
path <- ".//data-raw//Century47//Example forest files.xlsx"
sheet_names <- c("crop.100", "cult.100")
data_example <- lapply(sheet_names, function(x) {
  y <- data.frame(suppressMessages(readxl::read_xlsx(path, sheet = x, col_names = FALSE, progress = FALSE)))
  browser()
  if (x == "cult.100") {
    i <- which(sapply(y[, 1], function(z) is_numeric_string(z), USE.NAMES = FALSE))
    yy <- vector("list", length(i))
    for (j in 1:length(i)) {
      yy[[j]] <- vector("list", 11)
      yy[[j]] <- lapply(1:11, function(k) yy[[j]][[k]] <- as.numeric(y[i[j]+k, 1]))
      names(yy[[j]]) <- toupper(y[2:12, 2])
      yy[[j]]$label = y[i[j], 1]
      yy[[j]]$title = y[i[j], 2]
    }
  }
})

