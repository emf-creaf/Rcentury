test_that("list100 works", {

  wd <- "..//..//data-raw//example"
  file_in <- "duke"
  file_out <- "out"
  params <- list(start_time = 1,
                 end_time = 100,
                 args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc")
  )

  # Nothing is wrong.
  expect_no_error(century_list100(file_in, file_out, wd, params = params))

  # Wrong inputs.
  wwd <- "./dummy"
  expect_error(century_list100(file_in, file_out, wwd, params = params))


  fin <- "dumb"
  expect_error(century_list100(fin, file_out, wd, params = params))

  pp <- params
  pp$start_time <- .1
  expect_error(century_list100(file_in, fout, wd, params = pp))

  pp <- params
  pp$start_time <- -1
  expect_error(century_list100(file_in, fout, wd, params = pp))

  pp <- params
  pp$end_time <- .1
  expect_error(century_list100(file_in, fout, wd, params = pp))

  pp <- params
  pp$end_time <- -1
  expect_error(century_list100(file_in, fout, wd, params = pp))

  pp <- params
  pp$args <- "dumb"
  expect_error(century_list100(file_in, file_out, wd, params = pp))


  })
