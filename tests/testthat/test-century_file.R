test_that("Creating Century files", {

  # Example input.
  wd <- "..//..//data-raw//example"

  x <- list()
  x[[1]] <- list("E1", "Example1")
  x[[1]] <- append(x[[1]], runif(11))
  names(x[[1]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))
  x[[2]] <- list("E1", "Example1")
  x[[2]] <- append(x[[2]], runif(11))
  names(x[[2]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))

  # Nothing is wrong.
  expect_no_error(century_file(x, "cult", wd))

  # Wrong inputs.
  xx <- x
  xx[[1]]$label <- NULL
  expect_error(century_file(xx, "cult", wd = wd))

  xx <- x
  xx[[1]]$title <- NULL
  expect_error(century_file(xx, "cult", wd = wd))

  xx <- x
  xx[[1]]$`cultra(1)` <- "a"
  expect_error(century_file(xx, "cult", wd = wd))

  xx <- list()
  expect_error(century_file(xx, "cult", wd = wd))

  expect_error(century_file(x, "dumb", wd = wd))

  expect_error(century_file(x, "cult", wd = "./dummy"))


})
