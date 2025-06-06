test_that("Read and write schedule files", {

  path1 <- paste0("..//..//data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  path2 <- paste0("..//..//data-raw//Example simulations//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  filename <- list()
  filename[[1]] <- c("clay.sch", "high_ppt.sch", "low_ppt.sch", "sandy.sch", "XILI.sch")
  filename[[2]] <- c("G1.sch", "G3.sch", "G4.sch", "G5.sch")
  filename[[3]] <- c("duke.sch", "harvard.sch")

  # Test that it will not overwrite if overwrite is FALSE and file already exists.
  for (i in 1:3) {
    pa1 <- path1[[i]]
    pa2 <- path2[[i]]
    for (j in filename[[i]]) {
      x <- read_schedule(pa1, j)
      expect_no_error(write_schedule(x, pa2, paste0("delete_", j), overwrite = FALSE, verbose = FALSE))
    }
  }


  # Test with overwrite = TRUE
  for (i in 1:3) {
    pa1 <- path1[[i]]
    pa2 <- path2[[i]]
    for (j in filename[[i]]) {
      x <- read_schedule(pa1, j)
      expect_no_error(suppressWarnings(write_schedule(x, pa2, paste0("delete_", j), overwrite = TRUE, verbose = FALSE)))
      unlink(file.path(pa2, paste0("delete_", j)))
    }
  }



})
