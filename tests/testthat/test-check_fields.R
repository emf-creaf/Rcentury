test_that("multiplication works", {

  # Path to files.
  path_in <- list(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
                  system.file("extdata/3.plant_production",  package = "Rcentury"),
                  system.file("extdata/4.forest",  package = "Rcentury"))

  path_out <-  system.file("extdata/Example",  package = "Rcentury")

  # Names and number of lines for each *.100 file.
  data("files_100")

  # Check every single *.100 file.
  x <- list()
  k <- 1
  for (i in path_in) {
    for (j in names(files_100)) {
      print(j)
      if (file.exists(file.path(i, j))) {
        y <- read_100(i, j)
        x[[k]] <- list(path = i, filename = j, df = check_fields(y))
        k <- k + 1
      }
    }
  }

  nl <- lapply(x, function(y) {
    list(path = y$path,
         filename = y$filename,
         nl = sapply(y$df, function(z) {
      sum(!z$df$name_is_correct)
    })
    )
  })

})
