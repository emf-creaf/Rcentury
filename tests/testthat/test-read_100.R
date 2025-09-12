test_that("Reading *.100 CENTURY files works", {

  # Paths.
  path_in <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
                  system.file("extdata/3.plant_production",  package = "Rcentury"),
                  system.file("extdata/4.forest",  package = "Rcentury"))
  path_out <- list(system.file("extdata/Example/1.soil_texture_ppt",  package = "Rcentury"),
                   system.file("extdata/Example/3.plant_production",  package = "Rcentury"),
                   system.file("extdata/Example/4.forest",  package = "Rcentury"))
  names(path_out) <- path_in

  # File names.
  x <- c("crop.100", "cult.100", "fire.100", "fix.100", "graz.100", "tree.100", "trem.100")
  file_100 <- list(c(x, "fert.100", "harv.100", "irri.100", "omad.100"),
                   c(x, "fert.100", "harv.100", "irri.100", "omad.100"), x)
  names(file_100) <- path_in

  # First we empty de Example/ directories. Only *.exe files will remain.
  for (i in path_out) {
    unlink(file.path(i, paste0("*.100")))
    unlink(file.path(i, paste0("*.sch")))
    unlink(file.path(i, paste0("*.wth")))
    unlink(file.path(i, paste0("*.bin")))
  }

  # Next we read files.
  for (i in path_in) {
    for (j in file_100[[i]]) {
print(j)
      x <- read_100(i, j)
      write_100(x, path_out[[i]], j, overwrite = FALSE)
      y <- read_100(path_out[[i]], j)
browser()
      # Test.

      # expect_identical(x, y)

      # Trye to overwrite but file already exists.
      # expect_error(write_100(x, path_out[[i]], j, overwrite = FALSE))

    }
  }

})
