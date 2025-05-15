list100 <- function(wd, params) {


  print(wd)
  print(getwd())

  # Check components in 'params'.
  stopifnot("Input 'params' cannot be empty" = !is.null(params))

  # Check that necessary files are in wd.
  stopifnot("Could not find directory" = file.exists(wd))
  fn1 <- file.path(wd, paste0(params["simulation"], ".bin"))
  print(fn1)
  stopifnot("Could not find CENTURY simulation results" = file.exists(fn1))
  fn2 <- file.path(wd, "list100_47.exe")
  stopifnot("Could not find 'list100_47.exe'" = file.exists(fn2))

  # Output file should not exist.
  fn3 <- file.path(wd, params["output"], ".lis")
  stopifnot("Output File already exists" = !file.exists(fn3))


  # Move to directory and run list100_47.exe
  wd_old <- getwd()
  print(wd_old)
  setwd(wd)
  shell("list100_47.exe", input = params, intern = TRUE, wait = TRUE)
  setwd(wd_old)




}
