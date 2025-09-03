# Requirements for Running Scripts

## Operating System Script Compatibility
All code was written and revised on a Windows 10/11 OS (x86_64, mingw32, Intel i7, 32GB RAM). R/Rmd files were run via RStudio for Windows, and Python/Bash scripts were run via Windows Subsystem Linux (WSL). Certain Bash and Python scripts have dependencies for FMRIB Software Library (FSL v6.0, https://fsl.fmrib.ox.ac.uk/fsl/docs/) and Nifty Reg (https://github.com/KCL-BMEIS/niftyreg).

Notice that the scripts generated for this manuscript follow the naming conventions/file directories used by the researchers or have been modified for user input of a local directory. These will likely need to be updated to run any scripts on the user's system.   

_Bash (GNU bash, version 5.2.21(1))_: All bash scripts were converted from Windows/PC (DOS) to Unix compatibility using dos2unix (https://dos2unix.sourceforge.io/). All converted bash scripts were run in the WSL terminal application. If any bash scripts were not converted to Unix format before upload, please submit an Issue via GitHub and use the 'dos2unix' command for conversion.   

_Python (3.11.5)_: Python  scripts were written/revised in Windows and run in WSL. If using Windows,  WSL is the preferred interface for compatibility across software used.  

_R/RStudio (4.4.1)_: R scripts and Markdown were written and executed via RStudio's Windows Installation. Scripts should run across different operating systems

## Packages

Below are lists of dependencies/required packages for scripts used in this manuscript. In this folder are scripts to install the required packages:

_Bash_: While no specific packages are required for Bash scripts, they do use multiple FSL functions. Thus, FSL must be installed and set up appropriately for bash scripts to run.

_Python_: [install_python_packages.py](./install_python_packages.py)

_Note that only numpy is needed in the current version. If desired, install this module manually without the need for the install_python_packages.py script above._
  1) Data Processing:
       - numpy

_R:_ [install_r_packages.R](./install_r_packages.R)

  1) Data Processing:
       - openxlsx
       - tidyverse
       - abind
       - reshape2
       - RNifti

  2) Data Visualization:
       - knitr
       - cowplot
       - grid
       - gridExtra
       - gridGraphics
       - ggplot2
       - ggnewscale
       - ggpubr
       - RColorBrewer

  3) Data Analysis/Statistics:
       - nlme
       - emmeans
       - car
       - effectsize
       - zoo
       - aricode
       - nortest


_R Helper Functions_:
Two R helper functions were acquired from [Advanced Data Analytics I/II (2019/2022)](https://statacumen.com/teaching/ada1/ada1-f19/) written by Dr. Erik B. Erhardt, of the University of New Mexico's Department of Statistics. The latest versions of these functions have been posted to Dr. Erhardt's GitHub ([_erikmisc_](https://github.com/erikerhardt/erikmisc/)).
1) _bs_one_samp_dist()_ -- bootstrapped resampled distribution of residuals from one-sample tests to check assumption of normality. 
2) _bs_two_samp_dist()_ -- bootstrapped resampled distribution of residuals from two-sample tests to check assumption of normality. 
