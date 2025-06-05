test_that("Read and write schedule files", {

  path <- paste0("..//..//data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  path <- paste0(".//data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  filename <- list()
  filename[[path[1]]] <- c("clay.sch", "high_ppt.sch", "low_ppt.sch", "sandy.sch", "XILI.sch")
  filename[[path[2]]] <- c("G1.sch", "G3.sch", "G4.sch", "G5.sch")
  filename[[path[3]]] <- c("duke.sch", "harvard.sch")

  # Test that it will not overwrite if overwrite is FALSE and file already exists.
  for (i in path) {
    for (j in filename[[i]]) {
      x <- read_schedule(i, j)
      (write_schedule(x, i, paste0("delete_", j), overwrite = FALSE, verbose = FALSE))
    }
  }


  # Test with overwrite = TRUE
  # for (i in path) {
  #   for (j in filename[[i]]) {
  #     x <- read_schedule(i, j)
  #     expect_no_error(write_schedule(x, i, paste0("delete_", j), overwrite = TRUE, verbose = FALSE))
  #     unlink(file.path(i, paste0("delete_", j)))
  #   }
  # }



})
