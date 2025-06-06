test_that("Creating Century files", {

  path1 <- paste0("..//..//data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  path2 <- paste0("..//..//data-raw//Example simulations//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  filename <- list()
  filename[[1]] <- c("clay.sch", "high_ppt.sch", "low_ppt.sch", "sandy.sch", "XILI.sch")
  filename[[2]] <- c("G1.sch", "G3.sch", "G4.sch", "G5.sch")
  filename[[3]] <- c("duke.sch", "harvard.sch")


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
  expect_no_error(write_100(x, "cult", wd, verbose = FALSE))

  # Wrong inputs.
  xx <- x
  xx[[1]]$label <- NULL
  expect_error(write_100(xx, "cult", wd = wd, verbose = FALSE))

  xx <- x
  xx[[1]]$title <- NULL
  expect_error(write_100(xx, "cult", wd = wd, verbose = FALSE))

  xx <- x
  xx[[1]]$`cultra(1)` <- "a"
  expect_error(write_100(xx, "cult", wd = wd, verbose = FALSE))

  xx <- list()
  expect_error(write_100(xx, "cult", wd = wd, verbose = FALSE))

  expect_error(write_100(x, "dumb", wd = wd, verbose = FALSE))

  expect_error(write_100(x, "cult", wd = "./dummy", verbose = FALSE))


})
