test_that("Read all input CENTURY files", {

  # Path to files.
  path_in <- c(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))

  # Names and number of lines for each *.100 file.
  data("files_100")

  # Simple check that everything is ok.
  for (x in path_in) {
    for (y in names(files_100)) {
      if (file.exists(file.path(x, y))) expect_no_error(read_century_files(x, y, file_site = FALSE))
    }
  }



})
