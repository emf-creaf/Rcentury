test_that("Running list100_47.exe", {


  wd <- "..//..//data-raw//example"
  # expect_no_error(list100("duke", wd))

  params <- list(simulation ="duke",
              output = "out",
              start_time = 1,
              end_time = 100,
              args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc")
  )

  # If output already exists from previous tests, remove.
  fn <- file.path(wd, paste0(params$output, ".lis"))
  if (file.exists(fn)) file.remove(fn)

  # Run. File "out.lis" does not exist.
  list100(wd, params)
  expect_no_error(file.exists(wd, paste0(params$output, ".lis")))

  # Run. File does exist and will throw an error.
  expect_error(list100(wd, params))

})
