test_that("Read and write schedule files", {

  # Files.
  path_in <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))
  files <- list(c("clay.sch", "high_ppt.sch", "low_ppt.sch", "sandy.sch", "XILI.sch"),
                c("G1.sch", "G3.sch", "G4.sch", "G5.sch"),
                c("duke.sch", "harvard.sch"))
  names(files) <- path_in

  path_out <- system.file("extdata/Example",  package = "Rcentury")


  # In case files have not been deleted.
  for (i in path_in) {
    for (j in files[[i]]) {
      unlink(file.path(path_out, paste0("delete_", j)))
    }
  }

  # Test that it will not overwrite if overwrite is FALSE and file already exists.
  for (i in path_in) {
    for (j in files[[i]]) {
      x <- read_schedule(i, j)
      expect_no_error(write_schedule(x, path_out, paste0("delete_", j), overwrite = FALSE))
    }
  }


  # Test with overwrite = TRUE
  for (i in path_in) {
    for (j in files[[i]]) {
      x <- read_schedule(i, j)
      expect_no_error(suppressWarnings(write_schedule(x, path_out, paste0("delete_", j), overwrite = TRUE)))
      unlink(file.path(path_out, paste0("delete_", j)))
    }
  }

  # Read, write and read again.
  for (i in path_in) {
    for (j in files[[i]]) {
      x <- read_schedule(i, j)
      write_schedule(x, path_out, paste0("delete_", j), overwrite = FALSE)
      y <- read_schedule(path_out, paste0("delete_", j))
      expect_equal(x, y)
    }
  }

})
