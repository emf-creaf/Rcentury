test_that("Creating Century files", {

  # Path to files.
  path <- system.file("extdata/Example",  package = "Rcentury")

  # Fake data.
  x <- list()
  x[[1]] <- list("E1", "Example1")
  x[[1]] <- append(x[[1]], runif(11))
  names(x[[1]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))
  x[[2]] <- list("E1", "Example1")
  x[[2]] <- append(x[[2]], runif(11))
  names(x[[2]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))

  # Wrong path.
  expect_error(write_100(x, paste0(path, "KK"), "cult.100", verbose = FALSE))

  # Wrong name.
  expect_error(write_100(x, path, "cult.10", verbose = FALSE))
  expect_error(write_100(x, path, "dumb.100", verbose = FALSE))

  # Nothing is wrong.
  expect_no_error(write_100(x, path, "cult.100", verbose = FALSE))

  # Wrong inputs.
  xx <- x
  xx[[1]]$label <- NULL
  expect_error(write_100(x, path, "cult.100", verbose = FALSE))

  xx <- x
  xx[[1]]$title <- NULL
  expect_error(write_100(xx, path, "cult.100", verbose = FALSE))

  xx <- x
  xx[[1]]$`cultra(1)` <- "a"
  expect_error(write_100(xx, path, "cult", verbose = FALSE))

  xx <- list()
  expect_error(write_100(xx, "cult", verbose = FALSE))





})
