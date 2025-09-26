test_that("Reading *.100 CENTURY files works", {

  # Paths.
  path_in <- c(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))
  path_out <- tempdir()

  # File names.
  x <- c("cult.100", "crop.100", "fire.100", "fix.100", "graz.100", "tree.100", "trem.100")
  file_100 <- list(c(x, "fert.100", "harv.100", "irri.100", "omad.100"),
                   c(x, "fert.100", "harv.100", "irri.100", "omad.100"), x)
  names(file_100) <- path_in

  # Read, write, read again and check files are identical.
  for (i in path_in) {
    for (j in file_100[[i]]) {

      x <- read_100(i, j)
      write_100(x, path_out, j, overwrite = TRUE)
      y <- read_100(path_out, j)

      # Test.
      expect_identical(x, y)

      # Try to overwrite but file already exists.
      expect_error(write_100(x, path_out, j, overwrite = FALSE))

      file.remove(file.path(path_out, j))

    }
  }

  # Schedule path_out for deletion using `withr::defer()`
  withr::defer(unlink(file.path(path_out)), testthat::teardown_env())

})
