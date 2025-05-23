test_that("weather file writing", {

  wd <- "..//..//data-raw//example"
  df<- data.frame(month = rep(1:12, 2),
                  year = rep(c(2020, 2021), each = 12),
                  prec = runif(24)*500 + 100,
                  tmin = rnorm(24, mean = 5),
                  tmax = rnorm(24, mean = 15))

  #
  x <- df[, -1]
  expect_error(century_weather(x, "nothing", wd, verbose = FALSE))

  x <- df[-1, ]
  expect_error(century_weather(x, "nothing", wd, verbose = FALSE))

  expect_no_error(century_weather(df, "nothing", wd, verbose = FALSE))

  unlink(check_path("nothing", ".wth", wd, verbose = FALSE))

})
