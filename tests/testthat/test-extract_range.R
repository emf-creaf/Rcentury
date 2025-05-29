test_that("multiplication works", {

  df <- data.frame(Variable = letters[1:4],
                   Range = c("0 to 1", NA, "? to ?", "0 or 1 or 7"))
  out <- list(a = c(min = 0, max = 1),
              b = NA,
              c = c(min = -Inf, max = Inf),
              d = factor(c(0, 1, 7)))
  expect_identical(extract_range(df), out)

})
