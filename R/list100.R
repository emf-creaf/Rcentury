#' Title
#'
#' @param wd
#' @param params
#'
#' @returns
#' @export
#'
#' @examples
#' wd <- ".//data-raw//example"
#' params <- list(simulation ="duke",
#'   output = "out",
#'   start_time = 1,
#'   end_time = 100,
#'   args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc"))
#' list100(wd, params)
list100 <- function(wd, params) {


  # Check that directory exists.
  stopifnot("Could not find directory" = file.exists(wd))


  # Check components in 'params'.
  stopifnot("Input 'params' cannot be empty" = !is.null(params))
  stopifnot("Input 'params' must be a list" = is.list(params))
  stopifnot("Wrong components in 'params'" =
              all(c("simulation", "output", "start_time", "end_time", "args") %in% names(params)))
  stopifnot("Components 'start_time' and 'end_time' in 'params' must be positive integers" =
              all(is.numeric(params$start_time) &
                    is.numeric(params$end_time) &
                    round(params$start_time) == params$start_time &
                    round(params$end_time) == params$end_time &
                    params$start_time > 0 &
                    params$end_time > 0
              )
  )


  # Check that necessary files are in wd.
  fn1 <- file.path(wd, paste0(params$simulation, ".bin"))
  stopifnot("Could not find CENTURY simulation results" = file.exists(fn1))
  fn2 <- file.path(wd, "list100_47.exe")
  stopifnot("Could not find 'list100_47.exe'" = file.exists(fn2))

  # Output file should not exist.
  fn3 <- file.path(wd, paste0(params$output, ".lis"))
  stopifnot("Output File already exists" = !file.exists(fn3))


  # Move to directory, run list100_47.exe and move back.
  wd_old <- getwd()
  setwd(wd)
  shell("list100_47.exe", input = unlist(params), intern = TRUE, wait = TRUE)
  setwd(wd_old)




}
