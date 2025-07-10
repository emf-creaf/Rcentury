test_that("Checking fields of '.100' files", {

  # Path to files.
  path_in <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
                  system.file("extdata/3.plant_production",  package = "Rcentury"),
                  system.file("extdata/4.forest",  package = "Rcentury"))

  path_out <-  system.file("extdata/Example",  package = "Rcentury")

  # Names and number of lines for each *.100 file.
  data("files_100")

  # Check every single *.100 file.
  for (i in path_in) {
    print("")
    print(i)
    for (j in names(files_100)[-1]) {
      if (file.exists(file.path(i, j))) {
        y <- read_100(i, j)
        print(j)
        if (i == path_in[[1]] & j == "crop.100") {
          expect_error(check_fields(y, j))
        } else {
          expect_no_error(check_fields(y, j))
        }
      }
    }
  }


})
