# Code used for data processing and analysis in 'Reconfiguration of Brain-wide Neural Activity after Early Life Adversity'

Authors: Uselman, Taylor. W, Jacobs, Russell E., and Bearer, Elaine L.

[![DOI](https://img.shields.io/badge/DOI-10.1101/bioRxiv.2023.09.10.557058-maroon)](https://doi.org/10.1101/2023.09.10.557058)

## Overview

This repository lists the code (or links to code repositories) used for various processing and analysis steps in "Reconfiguration of Brain-wide Neural Activity after Early Life Adversity", _PNAS_, 2025. Below, we link to each of the major subsections of this repository, which correspond to various sections and figures within the manuscript. Corresponding figures for each subsection are listed in the subdirectories `README.md` files. Note that some sections used code from other Bearer Lab GitHub Repos. General explanations for these scripts are described in the respective repository pages, with links provided within corresponding subdirectories.    

Please review each of the following subdirectories for more information on 1) MEMRI data preprocessing, quality controls, and behavioral analysis; 2)  ROI measurements and c-fos comparisons; and 3) SPM segmentation and analysis.

## Repository Subdirectories
- **[01_preprocessing/](01_preprocessing/)** - MEMRI data preprocessing, quality controls, and behavioral analysis (Figures 1, S1-S3 and S4-S6)
- **[02_roi_analysis/](02_roi_analysis/)** - ROI measurements and c-fos comparisons (Fig. 3-4, S2 and S4-6, and Tables S2-S4)
- **[03_spm_segmentation/](03_spm_segmentation/)** - SPM segmentation and analysis (Fig. 5-6, S7 and S9, and Tables S5-S7)

## Requirements
- Unix/Linux system (scripts converted from Windows) - or need dos2unix/unix2dos conversion
- [FSL (FMRIB Software Library)](https://fsl.fmrib.ox.ac.uk/fsl/docs/#/)
- [NiftyReg](https://github.com/KCL-BMEIS/niftyreg)
- Various R and Python Packages (see packages used in requirement notes)
- **[See full explanation of Requirements](requirements/requirements.md)**

Note that the code listed in this repository uses various software packages from R and Python, all of which have permissive licenses, as well as wrapper scripts for FSL, which has a unique non-commercial [license](https://fsl.fmrib.ox.ac.uk/fsl/docs/#/license). 

## References
