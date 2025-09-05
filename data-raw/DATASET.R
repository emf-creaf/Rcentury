# Labels in schedule *.sch files.
labels_schedule <- c("Starting year", "Last year", "Site file name", "Labeling type", "Labeling year",
                     "Microcosm", "CO2 Systems", "pH shift", "Soil warming", "N input scalar option",
                     "OMAD scalar option", "Climate scalar option", "Initial system", "Initial crop",
                     "Initial tree", "Block #", "Last year", "Repeats # years", "Output starting year",
                     "Output month", "Output interval", "Weather choice")
usethis::use_data(labels_schedule, overwrite = TRUE)


# Names of files with *.100 extension.
files_100 <- c(90, 12, 6, 215, 7, 5, 11, 12, 21, 127, 21)
names(files_100) <- paste0(c("crop", "cult", "fert", "fix", "harv", "irri", "omad", "graz", "fire", "tree", "trem"), ".100")
usethis::use_data(files_100, overwrite = TRUE)


# Data labels in *.100 files. There is an error in this Excel file. Parameter OCCLUD belongs to the
# "Mineral initial parameters" section, no to the "Water initial parameters" one.
filename <- ".//data-raw//Century47//Variables_Century4.7_June_2017.xlsx"
input_file <- paste0(c("crop", "cult", "fert", "fix", "harv", "irri", "omad", "<site>", "graz", "fire", "tree", "trem"), ".100")
data_100 <- sapply(input_file, function(x) {
  x <- suppressMessages(readxl::read_xlsx(filename, sheet = x, progress = FALSE))
  x$Variable <- tolower(x$Variable)
  x
})
data_100$`<site>.100`[225, ]$`Parameter type` <- "Mineral initial parameters"
usethis::use_data(data_100, overwrite = TRUE)


# Content of output file.
description_output <- data.frame(suppressMessages(readxl::read_xlsx(path, sheet = "output", progress = FALSE)))
usethis::use_data(description_output, overwrite = TRUE)


#
# # Description of contents of harvest file.
# description_harvest <- suppressMessages(readxl::read_xlsx(path, sheet = "harvest.csv", progress = FALSE))
# usethis::use_data(description_harvest, overwrite = TRUE)


# Parameter SORPMX, among some others, in <site> file may have wrong range.

# Save as internal dataset.
usethis::use_data(data100, databin, dataharvest, overwrite = TRUE)



###### EXAMPLE FILES.


# # Making data sets for forest example.
# path <- "C://Roberto//Proyectos europeos//CARDIMED - Pilar Andrés//Century 5 soil model download//Century+Examples//Century Examples//4.forest"
#
# sheet_names <- c("crop.100", "cult.100", "fire.100", "fix.100", "graz.100", "tree.100", "trem.100")
# dat <- list()
# for (x in sheet_names) {
#   df <- read.table(file.path(path, x), header = FALSE, sep = "", dec = ".")
#   dat[[x]] <- fill_list(df, x)
# }
#
# duke <- list(weather = read.table(file.path(path, "duke.wth"), header = FALSE, sep = "", dec = "."))
#
# # Reading a schedule file is more complicated.
#
# x <- readLines(file.path(path, "duke.sch"), n = 15)
#
#
#              schedule = read.table(file.path(path, "duke.sch"), header = FALSE, sep = "", dec = ".")


