test_that("Run Century", {

  wd <- "..//..//data-raw//example"
  schedule <- "duke"
  fileout <- "out"
  extended <- FALSE

  # Nothing is wrong.
  expect_no_error(century_run(schedule, fileout, wd, extended))

  # Subdirectory does not exist.
  wwd <- "./dummy"
  expect_error(century_run(schedule, fileout, wwd, extended))

  # Schedule file name is wrong.
  sch <- "asdf"
  expect_error(century_run(sch, fileout, wd, extended))

  # There is no weather file for the schedule file.
  sch <- "dumb"
  expect_error(century_run(sch, fileout, wd, extended))

})
