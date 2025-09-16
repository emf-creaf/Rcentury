test_that("check overwrite", {


  # Paths.
  pathname <- tempdir()

  # First write an empty file.
  filename <- "example.txt"
  write.table(data.frame(), file.path(pathname, filename))
  expect_error(check_overwrite(pathname, filename))
  unlink(file.path(pathname, "example.txt"))

  expect_no_condition(check_overwrite(pathname, filename))

})
