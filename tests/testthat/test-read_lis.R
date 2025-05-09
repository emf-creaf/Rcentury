test_that("Reading CENTURY 'lis' files", {

  testthat::expect_no_condition(read_lis("example.lis", "..//..//data-raw"))

  x <- read_lis("example.lis", "..//..//data-raw")
  expect_equal(unname(apply(x, 2, mean)),
               c(1211.52116, 55.55744, 486.36927, 11.23644, 64.96978, 98.58083, 3747.94835, 339.06111, 14897.79286),
               tolerance = .Machine$double.eps^.5)


})
