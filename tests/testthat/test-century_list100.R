test_that("list100 works", {


  wd <- "..//..//data-raw//example"
  # expect_no_error(list100("duke", wd))

  params <- list(start_time = 1,
                 end_time = 100,
                 args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc")
  )

  # If output already exists from previous tests, remove.
  fn <- file.path(wd, paste0(params$output, ".lis"))
  if (file.exists(fn)) file.remove(fn)

  # Run. File "out.lis" does not exist.
  century_list100("duke", "out", wd, params)
  expect_no_error(file.exists(wd, paste0(params$output, ".lis")))

  # Run. File does exist and will throw an error.
  expect_error(century_list100(wd, params))

  })
