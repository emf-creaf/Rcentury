test_that("Reading *.100 CENTURY files works", {


  path <- paste0("..//..//data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))
  path <- paste0(".//data-raw//Century+Examples//Century Examples//", c("1.soil_texture_ppt", "3.plant_production", "4.forest"))


  read_100(path[1], "fix.100")

})
