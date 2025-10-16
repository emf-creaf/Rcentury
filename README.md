
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Rcentury: soil dynamics simulation with CENTURY and R

<!-- badges: start -->

<!-- badges: end -->

<br>

### Downloading and setting up CENTURY

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

The CENTURY software can be used in stand-alone mode, to be run on a
Windows command prompt. To do so, just follow the instructions in the
accompanying documents (available after uncompressing). Additionally, a
series of ASCII files must also be prepared in advance, which will then
be read when CENTURY is executed. Those files include:

- A set of up to 11 option files with extension ‘.100’, containing a
  large set of parameters. The name of these files is fixed.
- A single site file, also with extension ‘.100’, containing
  site-specific parameters. The name of this file can be chosen at will.
- A weather file, with extension ‘.wth’, that includes monthly data for
  precipitation and minimum and maximum temperature for the site.
- A schedule file, with extension ‘.sch’, which specifies the timing for
  scheduling management actions and controlling crop growth throughout
  the simulation.

All these ASCII files, together with the executable ‘century_47.exe’ and
‘list100_47.exe’ programs, must be in the same folder. Notice that the
CENTURY zip-files contain examples of those four types of ASCII input
files plus the two ‘.exe’ programs. Therefore, the CENTURY example files
can be used as starting templates to prepare our own parameter files.
Those example files are located in three sub-folders that are created
when unzipping the CENTURY downloaded files:

1.  Grassland with grazing simulation ran for a site in Xilingol,
    Mongolia (sub-folder “/Century+Examples/Century
    Examples/1.soil_texture_ppt”).
2.  Plant production for different grass types with different relative
    temperature growth curves (sub-folder “/Century+Examples/Century
    Examples/3.plant_production”).
3.  Duke and Harvard forests (sub-folder “/Century+Examples/Century
    Examples/4.forest”).

In each of those folders we can also find the two executables
‘century_47.exe’ and ‘list100_47.exe’ that we will use in the
simulations.

<br>

### What is Rcentury for?

Editing, modifying and then saving on disk each of those input ASCII
files individually is an extremely tedious and challenging task,
particularly when our goal is to apply the CENTURY model to a large
number of different sites, and/or under a variety of different climatic
and land management scenarios. This manual process is also highly
susceptible to errors, given the vast number of parameters that must be
carefully tuned-up and adjusted.

Therefore, it is a significant improvement in workflow to be able to
perform all these file operations from within a comprehensive software
environment like R. As mentioned above, the goal of package **Rcentury**
is thus to run CENTURY 4.7 from within R. That includes preparing all
files (treatments, schedule, weather and site characteristic), and then
read and load the result files into our R session as a **data.frame**.

<br>

#### Main functions in the Rcentury package

The ASCII files that are required by the CENTURY software can be read
and write with functions that are provided with the **Rcentury**
package:

- **read_100**/**write_100**: to read/write files with extension ‘.100’,
  save for site files.
- **read_site**/**write_site**: to read/write input site files (also
  extension ‘.100’).
- **read_weather**/**write_weather**: to read/write weather files
  (extension ‘.wth’).
- **read_schedule**/**write_schedule**: to read/write schedule files
  (extension ‘.sch’).
- **read_lis**: utility program to read binary ‘.bin’ files containing
  results from the simulation.

These functions allow us to first read the example files provided with
the CENTURY software, change the parameters at will and then write the
modified dataset on disk.

Once those files are available in the same directory where they two
‘.exe’ files are located, we can run CENTURY with the **century_run.R**
function. Internally, **century_run** runs sequentially the following
programs:

1.  ‘century_47.exe’: it creates a binary file on disk with extension
    ‘.bin’.
2.  ‘list100_47.exe’: it reads the ‘.bin’ file and builds an ASCII ASCII
    ‘.lis’ file containing a sequence of columns with results.
3.  **read_lis.R**: it reads the ‘.lis’ ASCII file into the R session as
    a **data.frame** that can be manipulated and analysed.
