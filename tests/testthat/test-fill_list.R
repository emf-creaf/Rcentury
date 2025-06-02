test_that("multiplication works", {

  df <- data.frame("A", "Example")
  for (i in 1:11) df <- rbind(df, c(i, letters[i]))
  x <- fill_list(df, "cult.100")
  y <- list()
  y$label = "A"
  y$title = "Example"
  for (i in 1:11) y[[LETTERS[i]]] <- as.numeric(i)
  y <- list(y)
  expect_identical(x, y)

})
