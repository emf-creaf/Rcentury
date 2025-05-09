test_that("Create 'cult' file", {

  x <- list()
  x[[1]] <- list(label = "E", title = "Example", cultra = runif(7), clteff = runif(4))
  names(x[[1]]$cultra) <- paste0("cultra(", 1:7, ")")
  names(x[[1]]$clteff) <- paste0("clteff(", 1:4, ")")
  x[[2]] <- list(label = "E", title = "Example", cultra = runif(7), clteff = runif(4))
  names(x[[2]]$cultra) <- paste0("cultra(", 1:7, ")")
  names(x[[2]]$clteff) <- paste0("clteff(", 1:4, ")")

  # All ok.
  expect_no_error(cult(x))

  # Errorw.
  x$cultra[3] <- -.01
  expect_error(cult(x))

  x$cultra[3] <- 1.3
  expect_error(cult(x))

  x$clteff[2] <- -.01
  expect_error(cult(x))

  x$clteff[2] <- 1.3
  expect_error(cult(x))
})
