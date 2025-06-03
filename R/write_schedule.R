write_schedule <- function(l, path, filename, overwrite = TRUE) {




  # Checks.
  stopifnot("Input must be a 'list'" = is.list(l))
  stopifnot("Elements in input 'list' is wrong" = all(c("header", "block_info") %in% names(x)))
  stopifnot("Elements in list 'header' are wrong" = all(labels[1:15] %in% names(l$header)))
  stopifnot("File already exists. Set 'ovewrite' to TRUE if you wish to overwrite" = check_overwrite(file.path(path, filename), overwrite = overwrite))


  #

}
