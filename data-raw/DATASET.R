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


# Making data sets for forest example.
path <- "C://Roberto//Proyectos europeos//CARDIMED - Pilar Andrés//Century 5 soil model download//Century+Examples//Century Examples//4.forest"

sheet_names <- c("crop.100", "cult.100", "fire.100", "fix.100", "graz.100", "tree.100", "trem.100")
dat <- list()
for (x in sheet_names) {
  df <- read.table(file.path(path, x), header = FALSE, sep = "", dec = ".")
  dat[[x]] <- fill_list(df, x)
}

duke <- list(weather = read.table(file.path(path, "duke.wth"), header = FALSE, sep = "", dec = "."))

# Reading a schedule file is more complicated.

x <- readLines(file.path(path, "duke.sch"), n = 15)


             schedule = read.table(file.path(path, "duke.sch"), header = FALSE, sep = "", dec = ".")


