test_that("Reading CENTURY 'lis' files", {

  wd <- "..//..//data-raw//example"
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

  # Read out.lis
  df <- read_lis(wd, "out")

  # Checks.
  expect_no_error(df[1, 1] == 1)
  expect_equal(c("time", params$args), colnames(df))




})
