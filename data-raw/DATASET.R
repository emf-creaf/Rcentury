path <- ".//data-raw//Century47//Variables_Century4.7_June_2017.xlsx"


# Content of input file.
input_file <- c("crop.100", "cult.100", "fert.100", "fix.100", "harv.100",
                "irri.100", "omad.100", "<site>.100", "graz.100", "fire.100",
                "tree.100", "trem.100")
data100 <- sapply(input_file, function(x) {
  suppressMessages(readxl::read_xlsx(path, sheet = x, progress = FALSE))
})


# Content of output file.
databin <- suppressMessages(readxl::read_xlsx(path, sheet = "output", progress = FALSE))


# Harversting file.
dataharvest <- suppressMessages(readxl::read_xlsx(path, sheet = "harvest.csv", progress = FALSE))


# Save as internal dataset.
usethis::use_data(data100, databin, dataharvest, overwrite = TRUE)
