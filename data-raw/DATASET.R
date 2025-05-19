path <- ".//data-raw//Century47//Variables_Century4.7_June_2017.xlsx"


# Content of input file.
input_file <- c("crop", "cult", "fert", "fix", "harv", "irri", "omad", "<site>", "graz", "fire", "tree", "trem")
data100 <- sapply(input_file, function(x) {
  suppressMessages(readxl::read_xlsx(path, sheet = paste0(x, ".100"), progress = FALSE))
})


# Content of output file.
databin <- suppressMessages(readxl::read_xlsx(path, sheet = "output", progress = FALSE))


# Harversting file.
dataharvest <- suppressMessages(readxl::read_xlsx(path, sheet = "harvest.csv", progress = FALSE))


# Save as internal dataset.
usethis::use_data(data100, databin, dataharvest, overwrite = TRUE)
