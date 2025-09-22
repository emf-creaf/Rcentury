check_functions_tests <- function() {

  # Assuming you're in the package's root directory
  # Get a list of R script files
  r_files <- list.files("R", pattern = "\\.R$", full.names = FALSE)

  # Get a list of testthat script files
  test_files <- list.files("tests/testthat", pattern = "^test-.*\\.R$", full.names = FALSE)

  # Remove the .R extension from R file names
  r_names <- sub("\\.R$", "", r_files)

  # Remove the 'test-' prefix and '.R' extension from test file names
  test_names <- sub("^test-", "", test_files)
  test_names <- sub("\\.R$", "", test_names)

  # Check for missing test files
  missing_tests <- setdiff(r_names, test_names)
  if (length(missing_tests) > 0) {
    message("⚠️ The following R files are missing corresponding testthat scripts:")
    print(paste0(missing_tests, ".R"))
  } else {
    message("✅ All R files have a corresponding testthat script.")
  }

  # Check for extra test files
  extra_tests <- setdiff(test_names, r_names)
  if (length(extra_tests) > 0) {
    message("⚠️ The following testthat scripts do not correspond to an R file:")
    print(paste0("test-", extra_tests, ".R"))
  } else {
    message("✅ There are no extra testthat scripts.")
  }
}
