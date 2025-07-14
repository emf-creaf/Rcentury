test_that("Checking fields of '.100' files", {

  # Path to files.
  path_in <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
                  system.file("extdata/3.plant_production",  package = "Rcentury"),
                  system.file("extdata/4.forest",  package = "Rcentury"))

  path_out <-  system.file("extdata/Example",  package = "Rcentury")

  # Names and number of lines for each *.100 file.
  data("files_100")

  # Check every single *.100 file.
  k <- 1
  for (i in path_in) {
    for (j in names(files_100)) {
      if (file.exists(file.path(i, j))) {
        y <- read_100(i, j)
        if (k != 3) {

          # These example files have problems.
          if (j %in% c("crop.100", "tree.100")) {
            expect_warning(check_fields(y, j))
          } else {

            # Let's introduce a wrong data.frame.
            expect_no_condition(check_fields(y, j))

            yy <- y
            yy[[1]]$df <- "asdf"
            expect_error(check_fields(yy, j))

          }
        } else {
          expect_no_condition(check_fields(y, j))

          yy <- y
          yy[[1]]$df <- "asdf"
          expect_error(check_fields(yy, j))
        }
      }
    }
    k <- k + 1
  }


})
