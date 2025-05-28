test_that("multiplication works", {


  expect_error(split_string(2345, "t"))
  expect_error(split_string(c("234", "66gh"), "m"))
  expect_error(split_string("asdfasfd", 5))
  expect_identical(split_string("asdfasdf78", "a"), c("sdf", "sdf78"))
  expect_identical(split_string("a", "a"), character(0))

})
