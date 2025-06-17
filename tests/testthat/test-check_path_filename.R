test_that("multiplication works", {

  # Path to files.
  path_in <- c(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))

  # Names and number of lines for each *.100 file.
  data("files_100")

  # Simple check that everything is ok.
  for (x in path_in) {
    for (y in names(files_100)) {
      expect_no_error(check_path_filename(x, y, file_site = FALSE))
    }
  }

  # Check that a generic site file called "dumb" does not exist.
  for (x in path_in) expect_error(check_path_filename(x, "dumb.100", file_site = FALSE))

  # Opposite.
  for (x in path_in) expect_no_error(check_path_filename(x, "dumb.100", file_site = TRUE))

  # Wrong extensions, correct filename.
  for (x in path_in) expect_error(check_path_filename(x, "crop.xxx"))

  # Wrong path.
  for (x in path_in) expect_error(check_path_filename(paste0(x, "dummy"), "crop.100"))


})
