test_that("check overwrite", {


  # Paths.
  path_out <- tempdir()

  # First write an empty file.
  filename <- "example.txt"
  write.table(data.frame(), file.path(path_out, filename))
  expect_error(check_overwrite(path_out, filename))
  unlink(file.path(path_out, "example.txt"))

  expect_no_condition(check_overwrite(path_out, filename))

  # Schedule path_out for deletion using `withr::defer()`
  withr::defer(unlink(file.path(path_out)), testthat::teardown_env())

})
