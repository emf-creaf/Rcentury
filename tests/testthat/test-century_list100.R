test_that("list100 works", {

  wd <- "..//..//data-raw//example"
  file_in <- "duke"
  file_out <- "out"
  params <- list(start_time = 1,
                 end_time = 100,
                 args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc")
  )

  # Nothing is wrong.
  expect_message(expect_no_error(century_list100(file_in, file_out, wd, params = params, verbose = FALSE)))

  # # Wrong inputs.
  wwd <- "./dummy"
  expect_error(century_list100(file_in, file_out, wwd, params = params, verbose = FALSE))

  fin <- "dumb"
  expect_error(century_list100(fin, file_out, wd, params = params, verbose = FALSE))

  pp <- params
  pp$start_time <- .1
  expect_error(century_list100(file_in, fout, wd, params = pp, verbose = FALSE))

  pp <- params
  pp$start_time <- -1
  expect_error(century_list100(file_in, fout, wd, params = pp, verbose = FALSE))

  pp <- params
  pp$end_time <- .1
  expect_error(century_list100(file_in, fout, wd, params = pp, verbose = FALSE))

  pp <- params
  pp$end_time <- -1
  expect_error(century_list100(file_in, fout, wd, params = pp, verbose = FALSE))

  pp <- params
  pp$args <- "dumb"
  expect_error(century_list100(file_in, file_out, wd, params = pp, verbose = FALSE))


  })
