# Code used for data processing and analysis in 'Reconfiguration of Brain-wide Neural Activity after Early Life Adversity'

Authors: Uselman, Taylor. W, Jacobs, Russell E., and Bearer, Elaine L.

[![DOI](https://img.shields.io/badge/DOI-10.1101/bioRxiv.2023.09.10.557058-maroon)](https://doi.org/10.1101/2023.09.10.557058)

## Overview

Provided in this repository is the code used (or links to GitHub repositories) in various processing and analysis steps from "Reconfiguration of Brain-wide Neural Activity after Early Life Adversity", _PNAS_, 2025. Below, we link to each of the major subsections of this repository, which correspond to various sections and figures within the manuscript. Corresponding figures for each subsection are listed in the subdirectories `README.md` files. Note that some sections used code from other Bearer Lab GitHub Repos, and require various software dependencies (see requirements). Descriptions/instructions for scripts from those repositories are described on their respective GitHub pages. Links to these repositories are provided within subdirectories here for which that software was used.  

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

**FSL**

[1.](https://pubmed.ncbi.nlm.nih.gov/19059349/)  M.W. Woolrich, S. Jbabdi, B. Patenaude, M. Chappell, S. Makni, T. Behrens, C. Beckmann, M. Jenkinson, S.M. Smith. Bayesian analysis of neuroimaging data in FSL. NeuroImage, 45:S173-86, 2009
    
[2.](https://pubmed.ncbi.nlm.nih.gov/15501092/)  S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-19, 2004
    
[3.](https://pubmed.ncbi.nlm.nih.gov/21979382/)  M. Jenkinson, C.F. Beckmann, T.E. Behrens, M.W. Woolrich, S.M. Smith. FSL. NeuroImage, 62:782-90, 2012

**Nifty Reg**

[4. ](https://doi.org/10.1016/S0262-8856(00)00052-4) Ourselin, et al. (2001). Reconstructing a 3D structure from serial histological sections. Image and Vision Computing, 19(1-2), 25–31.

[5. ](https://pubmed.ncbi.nlm.nih.gov/26158035/) Modat, et al. (2014). Global image registration using a symmetric block-matching approach. Journal of Medical Imaging, 1(2), 024003–024003. doi:10.1117/1.JMI.1.2.024003

[6. ](https://pmc.ncbi.nlm.nih.gov/articles/PMC3043828/) Rueckert, et al.. (1999). Nonrigid registration using free-form deformations: Application to breast MR images. IEEE Transactions on Medical Imaging, 18(8), 712–721. doi:10.1109/42.796284

[7. ](https://pubmed.ncbi.nlm.nih.gov/19818524/) Modat, et al. (2010). Fast free-form deformation using graphics processing units. Computer Methods And Programs In Biomedicine,98(3), 278–284. doi:10.1016/j.cmpb.2009.09.002

**R and Python Packages**
