test_that("Read/writing/reading weather files", {


  # Files.
  path <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))
  files <- list(c("low_ppt.wth", "low_ppt.wth", "xival.wth"),
                c("xival.wth"),
                c("duke.wth", "harvard.wth"))
  names(files) <- path

  path_out <- system.file("extdata/Example",  package = "Rcentury")

  for (i in path) {
    for (j in files[[i]]) {
      x <- read_weather(i, j)

      # Check that ecolumns are named "year", "month", "prec", "tmin" and "tmax".
      expect_true(all(colnames(x) %in% c("year", "month", "prec", "tmin", "tmax")))

      # Check that there are 12 rows per year.
      expect_true(all(table(x$year == 12)))

      # Write to disk.
      write_weather(x, path_out, j, overwrite = TRUE)

      # Read again.
      y <- read_weather(i, j)

      # Check they are the same.
      expect_identical(x, y)

    }
  }




})
