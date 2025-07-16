test_that("Reading *.100 CENTURY files works", {

  # Path to files.
  path_in <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))

  path_out <-  system.file("extdata/Example",  package = "Rcentury")

  # Names and number of lines for each *.100 file.
  data("files_100")

  for (i in path_in) {
    for (j in names(files_100)) {
      if (file.exists(file.path(i, j))) {
        x <- read_100(i, j)
        write_100(x, path_out, j, overwrite = TRUE)
        y <- read_100(path_out, j)

        # Test.
        expect_identical(x, y)

        unlink(file.path(path_out, j))
      }
    }
  }

})
