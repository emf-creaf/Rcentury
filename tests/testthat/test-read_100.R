test_that("Reading *.100 CENTURY files works", {


  path <- paste0("..//../files_100/data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  # path <- paste0(".//data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  filename <- data("files_100")

  for (i in path) {
    for (j in names(filename)) {
      if (file.exists(file.path(i, h))) {
        x <- read_100(i, j)
    }
  }

})
