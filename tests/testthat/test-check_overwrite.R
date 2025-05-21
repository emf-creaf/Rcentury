test_that("check overwrite", {


  write.table("Example", "example.txt")
  expect_message(check_overwrite("example.txt"), "File example.txt already exists. Deleting it...")
  expect_message(check_overwrite("example.txt", overwrite = FALSE), "File example.txt does not exist. No need to check for overwrite")
  expect_message(check_overwrite("e.txt"), "File e.txt does not exist. No need to check for overwrite")
  unlink("example.txt")

  # This will generate an error message
  write.table("Example", "example.txt")
  expect_error(check_overwrite("example.txt", overwrite = FALSE))
  unlink("example.txt")


})
