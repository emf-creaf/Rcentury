test_that("Creating Century files", {


  # Paths.
  path_in <- c(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))
  path_out <- tempdir()

  # Fake data.
  x <- list()

  df <- data.frame(runif(11), c(paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")")))
  colnames(df) <- NULL
  x[[1]] <- list(label = "E1", title = "Example1", df = df)

  df <- data.frame(runif(11), c(paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")")))
  colnames(df) <- NULL
  x[[2]] <- list(label = "E1", title = "Example1", df = df)

  # Wrong path.
  expect_error(write_100(x, paste0(path_out, "KK"), "cult.100"))

  # Wrong name.
  expect_no_condition(write_100(x, path_out, "cult.100", overwrite = TRUE))
  expect_error(write_100(x, path_out, "dumb.100"))

  # Nothing is wrong.
  expect_no_error(write_100(x, path_out, "cult.100", overwrite = TRUE))

  # Wrong inputs.
  xx <- x
  xx[[1]]$label <- NULL
  expect_error(check_fields(xx, "cult.100"))

  xx <- x
  xx[[1]]$title <- NULL
  expect_error(check_fields(xx, "cult.100"))

  expect_error(write_100(x, verbose = FALSE))

  # Read, write on disk and read again.
  x <- read_100(path_out, "cult.100")
  write_100(x, path_out, "cult.100", overwrite = TRUE)
  y <- read_100(path_out, "cult.100")
  expect_identical(x, y)

  # Remove.
  file.remove(file.path(path_out, "cult.100"))

})
