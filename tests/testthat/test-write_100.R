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

  # Wrong path.-out
  expect_error(write_100(x, paste0(path_out, "KK"), "cult.100", verbose = FALSE))

  # Wrong name.
  expect_no_condition(write_100(x, path_out, "cult.100", verbose = FALSE))
  expect_error(write_100(x, path_out, "dumb.100", verbose = FALSE))

  # Nothing is wrong.
  expect_no_error(write_100(x, path_out, "cult.100", verbose = FALSE))

  # Wrong inputs.
  xx <- x
  xx[[1]]$label <- NULL
  expect_error(check_fields(xx, "cult.100"))

  xx <- x
  xx[[1]]$title <- NULL
  expect_error(check_fields(xx, "cult.100"))

  expect_error(write_100(x, verbose = FALSE))


})
