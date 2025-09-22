
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rcentury

<!-- badges: start -->

<!-- badges: end -->

The goal of Rcentury is to run CENTURY 4.7 (version Fortran) from within
R. That includes preparing treatments, schedule, weather and site
characteristic files with **.100** extension, and then reading and
loading the resulting **lis** file into your R session as a
**data.frame**.

## Installation

The package is available at github for download.

``` r
devtools::install_github("https://github.com/emf-creaf/Rcentury.git")
#> Using GitHub PAT from the git credential store.
#> Skipping install of 'Rcentury' from a github remote, the SHA1 (f3fe4f64) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

``` r
library(Rcentury)
## basic example code
```

## Example files

## How to prepare a simulation

There are two main ways to prepare the files that are required to run a
simulation successfully:

1.  From scratch:
2.  Using example files:

## Example

Once installed, you can load it as:
