test_that("multiplication works", {


  wd <- "..//..//data-raw//example"
  file <- "duke"
  extended <- FALSE
  verbose <- TRUE

  # params <- list(start_time = 1,
  #                end_time = 100,
  #                args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc")
  # )

  # If output already exists from previous tests, remove.
  fn <- file.path(wd, paste0(params$output, ".lis"))
  if (file.exists(fn)) file.remove(fn)

  # Run. File "out.lis" does not exist.
  century_read_lis(file, wd, params, verbose)
  expect_no_error(file.exists(wd, paste0(params$output, ".lis")))

  # Run. File does exist and will throw an error.
  expect_error(century_read_lis(wd, params))

})
