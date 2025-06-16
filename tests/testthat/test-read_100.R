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
        write_100(x, path_out)
        y <- read_100(path_out, j)

        # Tests.
        expect_identical(x$filename, y$filename)

        expect_identical(length(x), length(y))

        xx <- x
        xx$filename <- NULL
        yy <- y
        yy$filename <- NULL

        for (i in 1:length(xx)) expect_identical(xx[[i]]$label, yy[[i]]$label)

        for (i in 1:length(xx)) expect_identical(nrow(xx[[i]]$df), nrow(yy[[i]]$df))

        for (i in 1:length(xx)) expect_identical(ncol(xx[[i]]$df), ncol(yy[[i]]$df))

        for (i in 1:length(xx)) expect_identical(xx[[i]]$df[, 1], yy[[i]]$df[, 1])

        for (i in 1:length(xx)) expect_identical(xx[[i]]$df[, 2], yy[[i]]$df[, 2])
      }
    }
  }

})
