test_that("Run Century", {

  wd <- "..//..//data-raw//example"
  schedule <- "duke"
  fileout <- "out"
  extended <- FALSE

  # Nothing is wrong.
  expect_no_error(century_run(schedule, fileout, wd, extended, verbose = FALSE))

  # Subdirectory does not exist.
  wwd <- "./dummy"
  expect_error(century_run(schedule, fileout, wwd, extended, verbose = FALSE))

  # Schedule file name is wrong.
  sch <- "asdf"
  expect_error(century_run(sch, fileout, wd, extended, verbose = FALSE))

  # There is no weather file for the schedule file.
  sch <- "dumb"
  expect_error(century_run(sch, fileout, wd, extended, verbose = FALSE))


  # Same, but with verbose = TRUE.
  wd <- "..//..//data-raw//example"
  schedule <- "duke"
  fileout <- "out"
  extended <- FALSE

  # Nothing is wrong.
  expect_message(expect_message(expect_message(century_run(schedule, fileout, wd, extended, verbose = TRUE))))

  # Subdirectory does not exist.
  wwd <- "./dummy"
  expect_message(expect_error(century_run(schedule, fileout, wwd, extended, verbose = TRUE)))

  # # Schedule file name is wrong.
  sch <- "asdf"
  expect_message(expect_message(expect_error(century_run(sch, fileout, wd, extended, verbose = TRUE))))

  # # There is no weather file for the schedule file.
  sch <- "dumb"
  expect_message(expect_message(expect_message(expect_error(century_run(sch, fileout, wd, extended, verbose = TRUE)))))
})
