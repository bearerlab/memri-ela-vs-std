# Code used for data processing and analysis in 'Reconfiguration of Brain-wide Neural Activity after Early Life Adversity'

__Authors:__ Uselman, Taylor. W, Jacobs, Russell E., and Bearer, Elaine L.

_Please cite the published paper if using this code_

[![DOI](https://img.shields.io/badge/DOI-10.1101/bioRxiv.2023.09.10.557058-blue)](https://doi.org/10.1101/2023.09.10.557058) [![DOI](https://img.shields.io/badge/DOI-10.1101/bioRxiv.2023.09.10.557058-maroon)](https://doi.org/10.1101/2023.09.10.557058)


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
- **[See full explanation of Requirements](requirements/)**

Note that the code listed in this repository uses various software packages from R and Python, all of which have permissive licenses, as well as wrapper scripts for FSL, which has a unique non-commercial [license](https://fsl.fmrib.ox.ac.uk/fsl/docs/#/license). 

## References

**FSL**

[1.](https://pubmed.ncbi.nlm.nih.gov/19059349/)  M.W. Woolrich, S. Jbabdi, B. Patenaude, M. Chappell, S. Makni, T. Behrens, C. Beckmann, M. Jenkinson, S.M. Smith. Bayesian analysis of neuroimaging data in FSL. NeuroImage, 45:S173-86, 2009
    
[2.](https://pubmed.ncbi.nlm.nih.gov/15501092/)  S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-19, 2004
    
[3.](https://pubmed.ncbi.nlm.nih.gov/21979382/)  M. Jenkinson, C.F. Beckmann, T.E. Behrens, M.W. Woolrich, S.M. Smith. FSL. NeuroImage, 62:782-90, 2012

**Nifty Reg**

[4.](https://doi.org/10.1016/S0262-8856(00)00052-4) Ourselin, et al. (2001). Reconstructing a 3D structure from serial histological sections. Image and Vision Computing, 19(1-2), 25–31.

[5.](https://pubmed.ncbi.nlm.nih.gov/26158035/) Modat, et al. (2014). Global image registration using a symmetric block-matching approach. Journal of Medical Imaging, 1(2), 024003–024003. doi:10.1117/1.JMI.1.2.024003

[6.](https://pmc.ncbi.nlm.nih.gov/articles/PMC3043828/) Rueckert, et al.. (1999). Nonrigid registration using free-form deformations: Application to breast MR images. IEEE Transactions on Medical Imaging, 18(8), 712–721. doi:10.1109/42.796284

[7.](https://pubmed.ncbi.nlm.nih.gov/19818524/) Modat, et al. (2010). Fast free-form deformation using graphics processing units. Computer Methods And Programs In Biomedicine,98(3), 278–284. doi:10.1016/j.cmpb.2009.09.002

**R and Python Packages**

_Python_

[8.](https://doi.org/10.1038/s41586-020-2649-2) Harris, C.R., Millman, K.J., van der Walt, S.J. et al. Array programming with NumPy. Nature 585, 357–362 (2020). DOI: 10.1038/s41586-020-2649-2.

_R_

[9.](https://github.com/erikerhardt/erikmisc) Erhard, Erik B. “Erikmisc: Miscellaneous Functions for Solving Complex Data Analysis Workflows.” GitHub, 2021.

[10.](http://www.jstatsoft.org/v21/i12/) Wickham, Hadley. “Reshaping Data with the Reshape Package.” Journal of Statistical Software, vol. 21, no. 12, 2007, pp. 1–20.

[11.](https://CRAN.R-project.org/package=gridExtra) Auguie, Baptiste. gridExtra: Miscellaneous Functions for “Grid” Graphics. 2017.

[12.](https://doi.org/10.21105/joss.02815) Ben-Shachar, Mattan S., et al. “Effectsize: Estimation of Effect Size Indices and Standardized Parameters.” Journal of Open Source Software, vol. 5, no. 56, 2020, p. 2815.

[13.](https://CRAN.R-project.org/package=ggnewscale) Campitelli, Elio. Ggnewscale: Multiple Fill and Colour Scales in “Ggplot2.” 2024.

[14.](https://CRAN.R-project.org/package=aricode) Chiquet, Julien, et al. Aricode: Efficient Computations of Standard Clustering Comparison Measures. 2023.

[15.](https://CRAN.R-project.org/package=RNifti) Clayden, Jon, et al. RNifti: Fast R and C++ Access to NIfTI Images. 2024

[16.](https://socialsciences.mcmaster.ca/jfox/Books/Companion/) Fox, John, and Sanford Weisberg. An R Companion to Applied Regression. Third, Sage, 2019.

[17.](https://CRAN.R-project.org/package=nortest) Gross, Juergen, and Uwe Ligges. Nortest: Tests for Normality. 2015.

[18.](https://doi.org/10.21105/joss.01686) Hadley Wickham, et al. “Welcome to the Tidyverse.” Journal of Open Source Software, vol. 4, no. 43, 2019, p. 1686.

[19.](https://doi.org/10.1038/s41586-020-2649-2) Harris, Charles R., et al. “Array Programming with NumPy.” Nature, vol. 585, no. 7825, Sep. 2020, pp. 357–62.

[20.](https://CRAN.R-project.org/package=RNifti) Jon Clayden, Bob Cox, and Mark Jenkinson. RNifti: Fast R and C++ Access to NIfTI Images. 2024.

[21.](https://CRAN.R-project.org/package=ggpubr) Kassambara, Alboukadel. Ggpubr: “ggplot2” Based Publication Ready Plots. 2023.

[22.](https://CRAN.R-project.org/package=emmeans) Lenth, Russell V. Emmeans: Estimated Marginal Means, Aka Least-Squares Means. 2024.

[23.](https://CRAN.R-project.org/package=gridGraphics) Murrell, Paul, and Zhijian Wen. gridGraphics: Redraw Base Graphics Using “grid” Graphics. 2020.

[24.](https://CRAN.R-project.org/package=RColorBrewer) Neuwirth, Erich. RColorBrewer: ColorBrewer Palettes. 2022.

[25.](https://CRAN.R-project.org/package=nlme) Pinheiro, José, et al. Nlme: Linear and Nonlinear Mixed Effects Models. 2024.

[26.](https://CRAN.R-project.org/package=abind) Plate, Tony, and Richard Heiberger. Abind: Combine Multidimensional Arrays. 2016.

[27.](https://CRAN.R-project.org/package=openxlsx) Schauberger, Philipp, and Alexander Walker. Openxlsx: Read, Write and Edit Xlsx Files. 2023.

[28.](https://ggplot2.tidyverse.org) Wickham, Hadley. Ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.

[29.](https://CRAN.R-project.org/package=cowplot) Wilke, Claus O. Cowplot: Streamlined Plot Theme and Plot Annotations for “Ggplot2.” 2024.

[30.](https://yihui.org/knitr/) Xie, Yihui. Knitr: A General-Purpose Package for Dynamic Report Generation in R. 2025.

[31.](https://doi.org/10.18637/jss.v014.i06) Zeileis, Achim, and Gabor Grothendieck. “Zoo: S3 Infrastructure for Regular and Irregular Time Series.” Journal of Statistical Software, vol. 14, no. 6, 2005, pp. 1–27.

**Bearer Lab:**

[32.](https://doi.org/10.1016/j.jneumeth.2015.09.031) Delora, Adam, et al. “A Simple Rapid Process for Semi-Automated Brain Extraction from Magnetic Resonance Images of the Whole Mouse Head.” Journal of Neuroscience Methods, vol. 257, 2016, pp. 185–93.

[33.](https://doi.org/10.1002/cpmb.40) Medina, Christopher S., et al. “Automated Computational Processing of 3-D MR Images of Mouse Brain for Phenotyping of Living Animals.” Current Protocols in Molecular Biology, vol. 119, no. 1, 2017, p. 29A.5.1-29A.5.38.

[34.](https://doi.org/10.1016/j.neuroimage.2007.05.010) Bearer EL, Zhang X, Jacobs RE. Live imaging of neuronal connections by magnetic resonance: Robust transport in the hippocampal-septal memory circuit in a mouse model of Down syndrome. Neuroimage. 2007 Aug 1;37(1):230-42. doi: 10.1016/j.neuroimage.2007.05.010.

