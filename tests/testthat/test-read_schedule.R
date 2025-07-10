test_that("Reading schedule files", {

  # Files.
  path <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
                  system.file("extdata/3.plant_production",  package = "Rcentury"),
                  system.file("extdata/4.forest",  package = "Rcentury"))
  files <- list(c("clay.sch", "high_ppt.sch", "low_ppt.sch", "sandy.sch", "XILI.sch"),
                c("G1.sch", "G3.sch", "G4.sch", "G5.sch"),
                c("duke.sch", "harvard.sch"))
  names(files) <- path


  # Read them.
  for (i in path) {
    for (j in files[[i]]) {
      x <- read_schedule(i, j)
    }
  }




})
