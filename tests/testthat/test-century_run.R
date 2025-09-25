test_that("Run Century", {

  # Paths.
  path_exe <- system.file("bin/windows",  package = "Rcentury")
  path_out <- tempdir()
  expect_true(file.exists(path_out))

  # Copy *.exe files.
  x <- c("century_47.exe", "list100_47.exe")
  file.copy(file.path(path_exe, x), path_out, overwrite = TRUE)
  # expect_true(all(file.copy(file.path(path_exe, x), path_out, overwrite = TRUE)))

  # Path to files.
  path_in <- c(system.file("extdata/1.soil_texture_ppt",  package = "Rcentury"),
               system.file("extdata/3.plant_production",  package = "Rcentury"),
               system.file("extdata/4.forest",  package = "Rcentury"))

  # 100 files.
  data("files_100")

  # Schedule files. high_ppt.sch gives error.
  schedule <- list(c("clay.sch", "low_ppt.sch", "sandy.sch", "XILI.sch", "high_ppt.sch"),
                   c("G1.sch", "G3.sch", "G4.sch", "G5.sch"),
                   c("duke.sch", "harvard.sch"))
  names(schedule) <- path_in

  # Weather files.
  weather <- list(c("low_ppt.wth", "low_ppt.wth", "xival.wth"),
                c("xival.wth"),
                c("duke.wth", "harvard.wth"))
  names(weather) <- path_in

  # Site files.
  sites <- list(c("clay.100", "sandy.100", "low_ppt.100", "high_ppt.100", "XILIN.100", "high_ppt.wth"),
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

    # Variable files.
    x <- file.copy(file.path(p, "outvars.txt"), path_out, overwrite = TRUE)

    # If error message is el comando ejecutado '"century_47.exe"' tiene el estatus 2
    # we must erase the previous *.bin.

    for (s in schedule[[p]]) {

      # Delete previous results, if any.

browser()

      suppressWarnings(file.remove(file.path(path_out, c("delete.bin", "delete.lis", "harvest.csv"))))

      suppressPackageStartupMessages(century_run(path_out, s, "delete.bin", "delete.lis", "outvars.txt"))

      expect_true(file.exists(file.path(path_out, "delete.bin")))
      file.remove(file.path(path_out, "delete.bin"))
      expect_false(file.exists(file.path(path_out, "delete.bin")))

      expect_true(file.exists(file.path(path_out, "delete.lis")))
      file.remove(file.path(path_out, "delete.lis"))
      expect_false(file.exists(file.path(path_out, "delete.lis")))

    }
  }

})
