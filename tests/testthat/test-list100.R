test_that("Running list100_47.exe", {


  wd <- "..//..//data-raw//example"
  # expect_no_error(list100("duke", wd))

  params <- c(simulation ="duke",
              output = "out",
              start_time = 1,
              end_time = 100,
              args = c("fcacc", "rlvacc", "frtacc", "fbracc", "rlwacc")
  )

  list100(wd, params)




})
