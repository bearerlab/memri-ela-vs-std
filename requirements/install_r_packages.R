#! R 
##########################################################
# Author: Taylor W. Uselman (Bearer Lab)
# Date: 9/3/2025
#
# This script installs R packages required for processing
# and analysis of MEMRI/Ethovision Data in "Reconfiguration
# of brain-wide neural activity after early life adversity"
# by Uselman TW, Jacobs RE, and Bearer EL (2025)
#
##########################################################

# List of packages to install
packages_to_manage <- c(
  # Data processing packages
  "openxlsx",
  "tidyverse",
  "abind",
  "reshape2",
  "RNifti",
  # Data Visualization
  "knitr",
  "cowplot",
  "gridExtra",
  "reshape2",
  "RNifti",
  "gridGraphics",
  "ggplot2",
  "ggnewscale",
  "ggpubr",
  "RColorBrewer",
  #Data Analysis/Statistics:
  "nlme",
  "emmeans",
  "car",
  "effectsize",
  "zoo",
  "aricode",
  "nortest"
  )

# Function to check, install, and load packages
install_r_packages <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
  }
}

# Apply the function to each package in the list
invisible(lapply(packages_to_manage, install_r_packages))
