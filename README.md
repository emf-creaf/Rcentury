
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Rcentury: soil dynamics simulation with CENTURY and R

<!-- badges: start -->

<!-- badges: end -->

<br>

### First steps

The goal of the **Rcentury** R package is to run the CENTURY soil
dynamics simulation from R. **Rcentury** is NOT an implementation of
CENTURY. Rather, it has been built as an interface in R to the actually
CENTURY software, which must have been downloaded in advance and placed
in a local folder. This guarantees that calculations are done via the
actual CENTURY code.

We first need to download and install the CENTURY software locally. This
must be done directly from the web site
<https://www.soilcarbonsolutionscenter.com> (after filling out a consent
form). Two zip-files are automatically downloaded, which must then be
unzipped into a local folder of our choice. The uncompressed folders
contain all the necessary files, plus several user manuals and examples.
Any question related to CENTURY must be addressed directly to the
creators of that software. See contact information on the
<https://www.soilcarbonsolutionscenter.com> web page.

The CENTURY Fortran executable can be used as a stand-alone software to
be run on a Windows command prompt. To do so, just follow the
instructions in the accompanying documents. Additionally, a series of
ASCII files must also be prepared in advance, which will then be read
when CENTURY is executed. Those files include:

- A set of up to 11 option files with extension ‘.100’, containing a
  large set of parameters. The name of these files is fixed.
- A single site file, also with extension ‘.100’, containing
  site-specific parameters. The name of this file can be chosen at will.
- A weather file, with extension ‘.wth’, that includes monthly data for
  precipitation and minimum and maximum temperature for the site.
- A schedule file, with extension ‘.sch’, which details the timing and
  sequence of all events in the simulation.

All these ASCII files, together with the executable ‘century_47.exe’ and
‘list100_47.exe’ programs, must be in the same folder.

The CENTURY example files can be used as starting templates to prepare
our own parameter files. Those example files are located in three
sub-folders that are created when unzipping the CENTURY downloaded
files:

1.  Grassland with grazing simulation ran for a site in Xilingol,
    Mongolia (sub-folder “/Century+Examples/Century
    Examples/1.soil_texture_ppt”).
2.  Plant production for different grass types with different relative
    temperature growth curves (sub-folder “/Century+Examples/Century
    Examples/3.plant_production”).
3.  DUke and Harvard forests (sub-folder “/Century+Examples/Century
    Examples/4.forest”).

In each of those folders we can also find the two executables
**century_47.exe** and **list100_47.exe** that we will use in the
simulations.

<br>

### What is Rcentury for?

Editing and then saving on disk each of those input ASCII files
individually is an extremely tedious and challenging task, particularly
when our goal is to apply the CENTURY model to a large number of
different sites, and/or under a variety of different climatic and land
management scenarios. This manual process is also highly susceptible to
errors, given the vast number of parameters that must be carefully
tuned-up and adjusted.

Therefore, it is a significant improvement in workflow to be able to
perform all these file operations from within a comprehensive software
environment like R. As mentioned above, the goal of package Rcentury is
thus to run CENTURY 4.7 (version Fortran) from within R. That includes
preparing all files (treatments, schedule, weather and site
characteristic), and then read and load the result files into our R
session as a **data.frame**.

<br>

### How to set up and run Rcentury

#### Install Rcentury locally and set working directory

To run CENTURY from a R session with the Rcentury package we may proceed
as follows. First, package Rcentury must be install on our local
computer. The package is publicly available at github and can be easily
fetched:

``` r
devtools::install_github("https://github.com/emf-creaf/Rcentury.git")
```

Then, we load it into our R session:

``` r
library(Rcentury)
```

This ensures that all package functions are available at the R session.

Next step consists of creating a local folder where we will run CENTURY
and where files with simulation results will be saved. For the sake of
illustration, let us create a temporary file and set it as our working
directory.

``` r
temp_dir <- tempdir()     # Random name for the temporary folder.
dir.create(temp_dir)      # Create folder.
setwd(temp_dir)           # Set it as current working directory.
```

<br>

#### Preparing input files

There are two main ways to prepare the ASCII files that are required to
run a CENTURY simulation successfully, namely doing it from scratch or
using the example files available with the compressed ‘.zip’. Hereby we
will be concerned with the latter case.

Now that we have created a temporary folder where to run CENTURY, we
will proceed by copying example files from the folder where they were
unzipped over to our working directory (i.e. ‘temp_dir’). We will also
copy the two executable files to run CENTURY and read results. Let us
assume that those unzipped files are located in
‘C:/Users/your_username/Century/Century Examples/1.soil_texture_ppt’.

``` r
from_dir <- 'C:/Users/your_username/Century/Century Examples/1.soil_texture_ppt'
all_files <- list.files(from_dir, pattern = "100", full.names = TRUE)
file.copy(all_files, temp_dir)
```

#### Prepare a CENTURY simulation

The steps to follow to prepare a CENTURY simulation with the Rcentury
package are as follows:

1.  Download the CENTURY 4.7 files as two compressed zip files (as of
    October 2025) from the web site.

2.  Unfold the zip files into a local folder. You will end up with a
    series of subfolders which enclose manuals and example files.

3.  Next, create a directory where you will hold all required CENTURY
    files and the results of your own simulations. Those files include
    the 4 types of files described above.

4.  Open RStudio

There are three example simulations that accompany the CENTURY ‘.zip’
files.

The ASCII files that are required by the CENTURY software can be read
and write with functions that are provided with the Rcentury package:

- read_100/write_100: to read/write all CENTURY files with extension
  ‘\*.100’ save for site files.
- read_site/write_site: to read/write ers to create input site files
  (extension ‘.100’) for the CENTURY soil model.
- read_weather/write_weather:
- read_schedule/write_schedule: read/write \*.sch CENTURY files.
- read_lis:

These functions allow us to first read the example files provided with
the CENTURY software, change the parameters at will and then write the
modified dataset on disk.

Once those files are available in the same directory where they two
‘.exe’ files are located, we can run CENTURY with the ‘century_run.R’
function. Internally, ‘century_run.R’ runs sequentially ‘century_47.exe’
and ‘list100_47.exe’, creating first a ‘.bin’ file and then an ASCII
‘.lis’, which finally be read with the ‘read_lis.R’ function. The output
of the latter is, finally, a **data.frame** that can be manipulated and
analysed within R.

#### Example

Once installed, you can load it as:
