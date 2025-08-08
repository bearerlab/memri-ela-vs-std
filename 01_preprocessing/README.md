# MEMRI Data Preprocessing, Quality Controls, and Behavioral Analysis

## Overview
This section contains scripts for preprocessing longitudinal Mn(II)-enhanced MRI data, implementing quality control measures, and analyzing mouse exploration in the custom arena. 

**Associated Figures/Tables:**
- Figure 1B-E (behavioral panel and processing overview)
- Supplemental Figures S1-2, and S6 (data processing overview and quality controls)

## Directory Structure

Note: Files/Scripts listed below are placed in order of processing steps - intermingled between sub-directories, and not necessarily in alphanumeric order.

```
01_preprocessing/
├── behavioral_analysis/
│   └── behavioral_analysis.Rmd          # Main behavioral processing and analysis
└── memri_preprocessing/
    ├── Slice_Interpolation.m            # Interpolates slices with RF feedthrough artifacts
    ├── 01_Skull_Stripping/
        ├── SkullStrip.sh                # Feeder/Organization Script
        └── SkullStripper_v4.py          # Skull Stripping Function (NiftyReg dependencies)
    ├── 02_Modal_Scaling/
        ├── modal_scale_nii_int32.m      # Primary Modal Scaling Function
        ├── find_hist.m                  # Helper functions to determine histograms, nonlinear 
        ├── peakdet.m
        ├── peakcostfn.m
        ├── find_hist_data.m
        └── padstring.m
    ├── 03_Quality_Control/
        ├── snr_analysis.Rmd              # MR Signal-to-Noise (SNR) comparisons
        ├── average.sh                    # Visual Alignment Quality
        ├── jaccard_similarity.sh         # Extracts Values to Determine Jaccard Indices to template
        ├── jaccard_similarity.R          # Calculates, graphs, and tests differences in Jaccard Indices
        ├── mutual_information.R          # Calculates, graphs, and tests differences in NMI
        └── roi_warped_v_smoothed.Rmd     # Determines the effect of smoothing on information
    └── avg_preMn_diff_adjustment.sh      # Adjusts ELA images for average pre-Mn(II) difference from Std
```

## Script Descriptions

### Behavioral Analysis Scripts

#### `behavioral_analysis.Rmd`
**Purpose:** To assess changes in exploratory behavior after ELA and during TMT (predator odor). 
**Dependencies:** None.
**Usage:** Knit in RStudio.
**Inputs:** Raw Data in txt format output by Noldus Ethovision XT 15.
**Outputs:** Behavioral analysis statistical reports and Figure 1B-D panels.

### MEMRI Preprocessing Scripts

#### `slice_interpolation.m`
**Purpose:** To interpolate slices containing RF feedthrough artifacts with adjacent slice anatomy. 
**Dependencies:** None.
**Usage:** MATLAB run -- Currently only interpolates across Coronal slices.
**Inputs:** 1) Raw images; 2) Slice #'s or range of slices in need of interpolating
**Outputs:** Slice interpolated images

#### `snr_analysis.Rmd`
**Purpose:** To check whether SNR and global Mn(II) dose effects are similar between groups. 
**Dependencies:** None.
**Usage:** Knit in R.
**Inputs:** 1) Raw images; 2) Slice #'s or range of slices in need of interpolating
**Outputs:** Slice interpolated images

Note: For measurements, see [/RegionOfInterest/README.md]{/RegionOfInterest/README.md}

#### `SkullStrip.sh` & `SkullStripper_v4.py`
**Purpose:** To extract the brain from non-brain tissue 
**Dependencies:** FSL / NiftyReg
**Usage:** `./SkullStrip.sh <input_dir> <output_dir>`
**Inputs:** 
    - Raw images with header correction, placed inside a directory called `Input`
    - Template image and mask, placed inside a directory called `Reference` 
**Outputs:** 
    - Masks (a `Masks` directory will be generated)
    - Skull Stripped Images (a `Stripped` directory will be generated)

#### `modal_scale_nii_int32.m` and others
**Purpose:** To intensity normalize MEMRI images according to the modal intensity of a template.
**Dependencies:** MATLAB/None.
**Usage:** Run in MATLAB. Use defaults for user input for _# bins_ and _delta_ values. 
**Inputs:** 
    - Skull-stripped linearly aligned images
    - Template image (single image or MDT) 
**Outputs:** 
    - Modally scaled images
    - Optional: PNGs of modally scaled histograms.

#### `average.sh`, `jaccard_similarity.sh`, `jaccard_similarity.R`, and `mutual_information.R`
**Purpose:** To quantify anatomical similarity after linear/non-linear alignments. 
**Dependencies:** FSL (for .sh scripts) and R packages listed in /requirements/requirements.md.
**Usage:** 
1) Run in WSL terminal - `average.sh` (requires input images to be organized in subdirectories for averaging).
2) Run in WSL terminal - `jaccard_similarity.sh` (requires hard-coded directories and file names).
3) Run in R/RStudio - `jaccard_similarity.R` (input is the output of (2)).
4) Run in R/RStudio - `mutual_information.R` (must be placed inside directory with warped images).

**Inputs:** Warped (non-linearly aligned) images.
**Outputs:** Images for Fig. S2I, Jaccard Indices and Normalized Mutual Information Values and Fig. S2F.

#### `roi_warped_v_smoothed.Rmd`
**Purpose:** To determine if smoothing results in a difference/loss of information from MEMRI signal intensities. 
**Dependencies:** None.
**Usage:** Knit in RStudio. 
**Inputs:** ROI summary csv generated by ROI measurement scripts (see note below).
**Outputs:** Fig. S6 graphs and statistical summaries.

Note: For ROI measurements, see [/02_roi_analysis/](#../02_roi_analysis/README.md)

#### `avg_preMn_diff_adjustment.Rmd`
**Purpose:** To adjust ELA post-Mn(II) images for pre-existing differences between groups' (ELA vs Std) pre-Mn(II) images. 
**Dependencies:** FSL.
**Usage:** In WSL terminal, `./avg_preMn_diff_adjustment.sh`
**Inputs:** ELA pre-Mn(II) images, difference image between ELA and Std pre-Mn(II).
**Outputs:** Fig. S6 graphs and statistical summaries.

Note: For ROI measurements, see [/02_roi_analysis/](#../02_roi_analysis/README.md)
