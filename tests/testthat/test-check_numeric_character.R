test_that("multiplication works", {

  expect_identical(check_numeric_character("?"), -Inf)
  expect_identical(check_numeric_character("?", "max"), Inf)
  expect_identical(check_numeric_character("a"), "a")
  expect_identical(check_numeric_character("-5"), -5)
  expect_identical(check_numeric_character("34.3"), 34.3)

  expect_error(check_numeric_character("?", "dummy"))

})
