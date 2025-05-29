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
path <- ".//data-raw//Century47//Example files.xlsx"
sheet_names <- c("crop.100", "cult.100")
data_example <- lapply(sheet_names, function(x) {
  y <- suppressMessages(readxl::read_xlsx(path, sheet = x, progress = FALSE))
  y$V2 <- toupper(y$V2)
})

