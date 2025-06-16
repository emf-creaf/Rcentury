test_that("Creating Century files", {

  # Path to files.
  path_out <-  system.file("extdata/Example",  package = "Rcentury")

  # Fake data.
  x <- list()

  df <- data.frame(runif(11), c(paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")")))
  colnames(df) <- NULL
  x[[1]] <- list(label = "E1", title = "Example1", df = df)

  df <- data.frame(runif(11), c(paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")")))
  colnames(df) <- NULL
  x[[2]] <- list(label = "E1", title = "Example1", df = df)

  x$filename <- "cult.100"

  # Wrong path.
  expect_error(write_100(x, paste0(path_out, "KK"), verbose = FALSE))

  # Wrong name.
  x$filename <- "cult.10"
  expect_error(write_100(x, path_out, verbose = FALSE))
  x$filename <- "dumb.100"
  expect_error(write_100(x, path_out, verbose = FALSE))

  # Nothing is wrong.
  x$filename <- "cult.100"
  expect_no_error(write_100(x, path_out, verbose = FALSE))

  # Wrong inputs.
  xx <- x
  xx[[1]]$label <- NULL
  expect_error(write_100(xx, path_out, verbose = FALSE))

  xx <- x
  xx[[1]]$title <- NULL
  expect_error(write_100(xx, path_out, verbose = FALSE))

  expect_error(write_100(x, verbose = FALSE))


})
