test_that("Reading CENTURY 'lis' files", {

  wd <- "..//..//data-raw//example"
  testthat::expect_no_condition(read_lis("example.lis", wd))

  x <- read_lis("example.lis", wd)
  expect_equal(unname(apply(x, 2, mean)),
               c(1211.52116, 55.55744, 486.36927, 11.23644, 64.96978, 98.58083, 3747.94835, 339.06111, 14897.79286),
               tolerance = .Machine$double.eps^.5)


})
