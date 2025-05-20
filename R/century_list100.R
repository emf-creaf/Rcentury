#' Run list100.exe file
#'
#' @description
#' \code{century_list100} runs \code{list100.exe} files
#'
#' @param wd
#' @param params
#'
#' @returns
#' @export
#'
#' @examples
#' wd <- ".//data-raw//example"
#' file_in <- "duke"
#' file_out <- "out"
#' params <- list(start_time = 1,
#'   end_time = 1000,
#'   args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc"))
#' century_list100(file_in, file_out, wd, params)
century_list100 <- function(file = file, fileout = fileout, wd = wd, params = params, overwrite = TRUE) {


  # Check correct paths and files.
  # fin <- paste0(file, ".bin")
  # fout <- paste0(fileout, ".lis")
  # if (!is.null(wd)) {
  #   stopifnot("Path 'wd' does not exist" = file.exists(wd))
  #   fin <- file.path(wd, fin)
  #   fout <- file.path(wd, fout)
  # }
  fin <- check_file(file, ".bin", wd)
  fout <- check_file(fileout, ".lis", wd)
  stopifnot("Could not find CENTURY simulation results" = file.exists(fin))
  if (file.exists(fout)) {
    if (overwrite) unlink(fout) else stop("Output file already exists. Set 'overwrite' to TRUE?")
  }
  stopifnot("Could not find 'list100_47.exe'" = file.exists(file.path(wd, "list100_47.exe")))


  # Check components in 'params'.
  stopifnot("Input 'params' cannot be empty" = !is.null(params))
  stopifnot("Input 'params' must be a list" = is.list(params))
  stopifnot("Wrong components in 'params'" = all(c("start_time", "end_time", "args") %in% names(params)))
  stopifnot("Components 'start_time' and 'end_time' in 'params' must be positive integers" =
              all(with(params, is.numeric(c(params$start_time)) & start_time > 0 & end_time > 0 &
                         round(start_time) == start_time & round(end_time) == end_time)))
  stopifnot("There must be at least one element in 'args'" = length(params$args) > 0)


  # Check that variables in 'args' are correct.
  data(databin)
  stopifnot("Some variables in 'args' are incorrect" = all(params$args %in% databin$Variable))


  # Add file names to list100 inputs.
  params <- c(file, fileout, params)


  # Move to directory, run list100_47.exe and move back.
  wd_old <- getwd()
  setwd(wd)
  shell("list100_47.exe", input = unlist(params), intern = TRUE, wait = TRUE)
  setwd(wd_old)

}
