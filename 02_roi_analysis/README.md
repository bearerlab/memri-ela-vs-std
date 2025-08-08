# Region of Interest Analysis and Comparisons between MEMRI and c-fos IHC

## Overview
This section contains scripts for ROI Measurements from MEMRI Images, and other scripts for the analysis of these images and correlations with c-fos+ staining in micrographs. 

**Associated Figures/Tables:**
- Figure 3-4 (ROI comparisons of signal intensity magnitudes, and Comparisons to c-fos+ staining)
- Supplemental Figures S4-6 (test-retest, bootstrapped correlations, effects of smoothing)
- Supplemental Tables S2-4 (ROI locations - for Fig. 3, and statistical summaries)

## Directory Structure

Note: Files/Scripts listed below are placed in order of processing steps - intermingled between sub-directories, and not necessarily in alphanumeric order.

```
02_roi_analysis/
├── 01_roi_script_package/
│   ├── ROI_feeder.sh                    # 
│   ├── ROI.sh                           # 
│   ├── ROI_Compiler.sh                  #
│   ├── 00_SNR                           #
│   │   ├── ROI_feeder.sh                    # 
│   │   ├── ROI.sh                           # 
│   │   ├── ROI_Compiler.sh                  #
│   ├── 01_Fig3_memri                    #
│   │   ├── ROI_feeder.sh                    # 
│   │   ├── ROI.sh                           # 
│   │   ├── ROI_Compiler.sh                  #
│   ├── 02_Fig4_cfos_comparisons         #
│   │   ├── ROI_feeder.sh                    # 
│   │   ├── ROI.sh                           # 
│   │   ├── ROI_Compiler.sh                  #
│   └── 03_smoothing_effects             #
│       ├── ROI_feeder.sh                    # 
│       ├── ROI.sh                           # 
│       └── ROI_Compiler.sh                  #
└──


```

## Script Descriptions

### ROI Measurement Scripts (non-specfic)

#### `behavioral_analysis.Rmd`
**Purpose:** To assess changes in exploratory behavior after ELA and during TMT (predator odor). 
**Dependencies:** None.
**Usage:** Knit in RStudio.
**Inputs:** Raw Data in txt format output by Noldus Ethovision XT 15.
**Outputs:** Behavioral analysis statistical reports and Figure 1B-D panels.

