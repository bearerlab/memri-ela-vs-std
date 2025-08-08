# Requirements for Running Scripts

## Operating System Script Compatibility
All code was written and revised on a Windows 10/11 OS (x86_64, mingw32, 32GB RAM), with R/Rmd files were run via RStudio for Windows, and Python or Bash scripts were run via Windows Subsystem Linux (WSL). Certain Bash and Python scripts have dependencies for FMRIB Software Library (FSL, https://fsl.fmrib.ox.ac.uk/fsl/docs/).

Notice that the scripts generated for this manuscript follow the naming conventions/file directories used by the researchers. These will likely need to be updated for running any scripts on your systems.   

_Bash (GNU bash, version 5.2.21(1))_: All bash scripts were converted from Windows/PC (DOS) to Unix compatibility using dos2unix (https://dos2unix.sourceforge.io/). All converted bash scripts were run in the WSL terminal application. If any bash scripts were not converted to Unix format before upload, please submit an Issue via GitHub and use the 'dos2unix' command for conversion.   

_Python (3.11.5)_: Python  scripts were written/revised in Windows and run in WSL. If using Windows,  WSL is the preferred interface for compatibility across dependencies.  

_R/RStudio (4.4.1)_: R scripts and Markdown were written and executed via RStudio's Windows Installation. Scripts should run across different operating systems

## Packages

Below are lists of dependencies/required packages for scripts used in this manuscript. In this folder are scripts to install the required packages:

For R: [./Install_R_Packages.R]

For Python: [./Install_Python_Packages.py]

_Bash_: While no specific packages are required for Bash scripts, they do use multiple FSL functions. Thus, FSL must be installed and set up appropriately for bash scripts to run.

_Python_: 
  - os
  - numpy

_R_:

  Data Processing:
  - openxlsx
  - tidyverse
  - abind

  Data Visualization:
  - knitr
  - ggplot2
  - ggnewscale

  Data Analysis/Statistics:
  - nlme
  - emmeans
  - cars 
  - effectsize
  - zoo
  - stats (built-in default)


_R Helper Functions_:
See `./helper_functions.R`
