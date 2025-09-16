test_that("Testing path and file names", {


  # Errors.
  expect_error(check_path_file())
  expect_error(check_path_file(""))
  expect_error(check_path_file("", "crop.100"))
  expect_error(check_path_file(getwd(), "nothing"))
  expect_error(check_path_file(c(getwd(), getwd()), "nothing"))

  # This is correct.
  expect_no_condition(check_path_file(getwd(), "nothing.100"))

  # Error.
  expect_error(check_path_file(c(getwd(), getwd()), c("nothing.100", "more_nothing.100")))


})
