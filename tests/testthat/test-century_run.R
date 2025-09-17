test_that("Run Century", {

  # Paths.
  path_exe <- system.file("bin/windows",  package = "Rcentury")
  path_out <- tempdir()

  # Copy *.exe files.
  x <- c("century_47.exe", "list100_47.exe")
  expect_true(all(file.copy(file.path(path_exe, x), path_out, overwrite = TRUE)))

  # Path to files.
  path_in <- c(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))

  # 100 files.
  data("files_100")

  # Schedule files.
  schedule <- list(c("clay.sch", "high_ppt.sch", "low_ppt.sch", "sandy.sch", "XILI.sch"),
                   c("G1.sch", "G3.sch", "G4.sch", "G5.sch"),
                   c("duke.sch", "harvard.sch"))
  names(schedule) <- path_in

  # Weather files.
  weather <- list(c("low_ppt.wth", "low_ppt.wth", "xival.wth"),
                c("xival.wth"),
                c("duke.wth", "harvard.wth"))
  names(weather) <- path_in

  # Site files.
  sites <- list(c("clay.100", "sandy.100", "low_ppt.100", "high_ppt.100", "XILIN.100"),
                c("XILIN.100"),
                c("duke.100", "harvard.100"))
  names(sites) <- path_in

  # Copy files.
  for (p in path_in) {

    # Files with extension '.100'.
    for (f in names(files_100)) {
      if (!any(f %in% c("fert.100", "harv.100", "irri.100", "omad.100"))) {
        file.copy(file.path(p, f), path_out, overwrite = TRUE)
      } else {
        if (p != path_in[3]) file.copy(file.path(p, f), path_out, overwrite = TRUE)
      }
    }

    # Weather files.
    x <- file.copy(file.path(p, weather[[p]]), path_out, overwrite = TRUE)

    # Site files.
    x <- file.copy(file.path(p, sites[[p]]), path_out, overwrite = TRUE)

    # Schedule files.
    x <- file.copy(file.path(p, schedule[[p]]), path_out, overwrite = TRUE)

    # If error message is el comando ejecutado '"century_47.exe"' tiene el estatus 2
    # we must erase the previous *.bin.

    for (s in schedule[[p]]) {
      browser()
      century_run(path_out, s, "kk")
    }

  }







  #   # File names.
  #   x <- c("crop.100", "cult.100", "fire.100", "fix.100", "graz.100", "tree.100", "trem.100")
  # file.copy()


#
#
#   # File names.
#   x <- c("crop.100", "cult.100", "fire.100", "fix.100", "graz.100", "tree.100", "trem.100")
#   file_100 <- list(c(x, "fert.100", "harv.100", "irri.100", "omad.100"),
#                    c(x, "fert.100", "harv.100", "irri.100", "omad.100"), x)
#   file_site <- list(c("high_ppt.100", "low_ppt.100", "XILIN.100", "sandy.100", "clay.100"),
#                     c("XILIN.100"),
#                     c("duke.100", "harvard.100"))
#   file_schedule <- list(c("high_ppt.sch", "low_ppt.sch", "XILI.sch", "sandy.sch", "clay.sch"),
#                         c("G1.sch", "G3.sch", "G4.sch", "G5.sch"),
#                         c("duke.sch", "harvard.sch"))
#   file_weather <- list(c("high_ppt.wth", "low_ppt.wth", "xival.wth"),
#                        c("xival.wth"),
#                        c("duke.wth", "harvard.wth"))
#
#
#   # Name lists.
#   names(file_site) <- names(file_100) <- names(file_schedule) <- names(file_weather) <- path_in
#
#
#   # First we empty de Example/ directories. Only *.exe files will remain.
#   for (i in path_out) {
#     unlink(file.path(i, paste0("*.100")))
#     unlink(file.path(i, paste0("*.sch")))
#     unlink(file.path(i, paste0("*.wth")))
#     unlink(file.path(i, paste0("*.bin")))
#   }
#
#
#   # Next we read and write, rather than copy, all required files to each subdirectory.
#   for (i in path_in) {
#     for (j in file_100[[i]]) {
#       print(j)
#       x <- read_100(i, j)
#       write_100(x, path_out[[i]], j)
#       y <- read_100(path_out[[i]], j)
#       expect_true(identical(x, y))
#     }
#   }
#
# #
# #
# #   files <- list(c("low_ppt.wth", "low_ppt.wth", "xival.wth"),
# #                 c("xival.wth"),
# #                 c("duke.wth", "harvard.wth"))
# #   names(path_out) <- names(files) <- path_in
# #
# #
# #   # Nothing is wrong.
# #   for (i in path) {
# #     for (j in files[[i]]) {
# #       expect_no_error(century_run(i, j, fileout, wd, extended, verbose = FALSE))
# #
# #
# #     }
# #   }
# #   expect_no_error(century_run(path, , fileout, wd, extended, verbose = FALSE))
# #
# #   # Subdirectory does not exist.
# #   wwd <- "./dummy"
# #   expect_error(century_run(schedule, fileout, wwd, extended, verbose = FALSE))
# #
# #   # Schedule file name is wrong.
# #   sch <- "asdf"
# #   expect_error(century_run(sch, fileout, wd, extended, verbose = FALSE))
# #
# #   # There is no weather file for the schedule file.
# #   sch <- "dumb"
# #   expect_error(century_run(sch, fileout, wd, extended, verbose = FALSE))
# #
# #
# #   # Same, but with verbose = TRUE.
# #   wd <- "..//..//data-raw//example"
# #   schedule <- "duke"
# #   fileout <- "out"
# #   extended <- FALSE
# #
# #   # Nothing is wrong.
# #   expect_message(expect_message(expect_message(century_run(schedule, fileout, wd, extended, verbose = TRUE))))
# #
# #   # Subdirectory does not exist.
# #   wwd <- "./dummy"
# #   expect_message(expect_error(century_run(schedule, fileout, wwd, extended, verbose = TRUE)))
# #
# #   # # Schedule file name is wrong.
# #   sch <- "asdf"
# #   expect_message(expect_message(expect_error(century_run(sch, fileout, wd, extended, verbose = TRUE))))
# #
# #   # # There is no weather file for the schedule file.
# #   sch <- "dumb"
# #   expect_message(expect_message(expect_message(expect_error(century_run(sch, fileout, wd, extended, verbose = TRUE)))))

})
