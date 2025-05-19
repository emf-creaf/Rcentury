test_that("Creating Century files", {


  x <- list()
  x[[1]] <- list("E1", "Example1")
  x[[1]] <- append(x[[1]], runif(11))
  names(x[[1]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))
  x[[2]] <- list("E1", "Example1")
  x[[2]] <- append(x[[2]], runif(11))
  names(x[[2]]) <- c("label", "title", paste0("cultra(", 1:7, ")"), paste0("clteff(", 1:4, ")"))

  # Fewer digits.
  x[[1]]$`cultra(3)` <- 0.3

  # Create file locally.
  wd <- "..//..//data-raw//example"
  century_file(x, "cult.100", wd = wd)


})
