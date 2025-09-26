test_that("Write site files", {

  # Path to files.
  path <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))
  filename <- list(c("clay.100", "sandy.100", "low_ppt.100", "high_ppt.100", "XILIN.100"),
                   c("XILIN.100"),
                   c("duke.100", "harvard.100"))
  path_out <- tempdir()
  names(filename) <- path


  # Reading files.
  for (i in path) {
    for (j in filename[[i]]) {
      x <- read_site(i, j)
      write_site(x, path_out, j, overwrite = TRUE)
      y <- read_site(path_out, j)
      expect_identical(x, y)
    }
  }

  # Schedule path_out for deletion using `withr::defer()`
  withr::defer(unlink(file.path(path_out)), testthat::teardown_env())

})
