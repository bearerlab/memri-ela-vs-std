# Segmentation of Statistical Maps of MEMRI Signal Intensities and Calculation of Fractional Volumes

## Overview
This section contains scripts for segmenting MEMRI images, including mask generation and application, segment-wise statistical summaries (voxel counts), compilation of data, and graphing column graphs. Note that the feeder scripts are used throughout to organize subroutines. 

This version of our _InVivo_ Atlas segmentation utilizes FSL functions (fslmaths and fslstats). These scripts wrap FSL, bash, and Python in a way to mask the atlas; parse, mask and summarize SPM images; and compile output data for R analysis. 

**Associated Figures/Tables:**
- Figure 5-6 (Fractional Activation Volumes and Fractional Difference Volumes)
- Supplemental Figures S7 and S9 (SPM paired t-test between conditions, and comparison of anatomy by Jacobian Determinants of Deformations)
- Supplemental Tables S5, 6A/B, and S7 (Segment Abbreviations and naming; and segmental summaries of SPM volumes in Fig. 5, 6, and S7)

## Directory Structure

Note: Files/Scripts listed below are placed in order of processing steps - intermingled between sub-directories, and not necessarily in alphanumeric order.

```
03_spm_segmentation/
├── 01_segmentation_script_package/
   ├── feeder_v4.sh                    # A base 'Feeder' Script that was slightly modified for each ROI analysis below. The feeder script defines the locations/size of ROIs to be measured. 
   ├── create_mask_feeder.v4           # A script that creates another "feeder" script for segmentation based on InVivo Atlas CSV file.  
   ├── mask_creator_v4.sh              # This is the feeder script generated, which uses the mask_creation_v4 function/script to create a mask image from each segment. 
   ├── mask_creation_v4.sh             # Create the mask images for each segment based on InVivo Atlas CSV file info
   ├── segment_stats_feeder_v4.sh      # Feeder script that reads the names of SPM images in /Inputs/All_Within_Group/ and /Inputs/All_Between_Group/ subdirectories. The SPM file names have the format 'spmT_{Group}_{Condition}_T{Tval}-P{Pval}-C8.nii' This script reads the t-values for thresholding statistical maps for segmentation.
   ├── segment_stats_w_v4.sh           # Extracts segment statistics from Paired T-test SPMs that compared post-Mn(II) to pre-Mn(II) image (within group)
   ├── segment_stats_w_postMn_v4.sh    # Extracts segment statistics from Paired T-test SPMs that compare between post-Mn(II) images (within group)
   ├── segment_stats_b_v4.sh           # Extracts segment statistics from Unpaired T-test SPMs (between-group SPMs)
   └── combine_v4.py                   # Compiles CSV output files generated for each SPM image into a single CSV file.
├── fracvol_graph.R                    # Function for graphing fractional volumes according to InVivo Atlas anatomical groupings.
├── 02_segmentation_analyses/                   
│  ├── fav_analysis.Rmd                # R markdown file analysis of Paired SPM t-tests             
│  └── fdv_analysis.Rmd                # R markdown file analysis of Unpaired SPM t-tests  
└── 04_Anatomical_Comparisons     
   ├── ROI_feeder_cfos.sh                    
   ├── Fig4_cfos_analysis.Rmd          # R markdown file for comparisons in Fig. 4
   └── memri_test_retest_analysis.Rmd  # R markdown file for supplmental test-retest              

```

## Script Descriptions

### ROI Measurement Scripts (non-specific)

[01_segmentation_script_package/](./01_segmentation_script_package/)

#### `ROI_feeder.sh`
**Purpose:** To feed input image information and ROI location to ROI.sh. 

**Dependencies:** None.

**Usage:** ./ROI_feeder_{xx}.sh 

**Inputs:** 
  - Processed (intensity-normalized, anatomically-aligned) images, organized in an input sub-directory by Group and/or Condition (see protocol in Word Document for more)
  - X-Y-Z voxel location, ROI size, input folder names, identification variables

**Outputs:** Feeds the ROI location and metadata provided to ROI.sh for extraction

#### `ROI.sh`
**Purpose:** To measure signal intensities from MEMRI images based on ROI_feeder.sh. 

**Dependencies:** FSL - fslroi, fslstats

**Usage:** ./ROI.sh loc x y z sz fn lab1 lab2 lab3

**Inputs:** 
 - loc = ROI location name/abbreviation
 - x = x coordinate
 - y = y coordinate
 - z = z coordinate
 - sz = size of cube - all should be 5x5x5 voxels
 - fn = image folder name within "InputImages" directory
 - lab1 = grouping variable #1
 - lab2 = grouping variable #2
 - lab3 = grouping variable #3
 - Processed (intensity-normalized, anatomically-aligned) images, organized in an input sub-directory by Group and/or Condition (see protocol in Word Document for more). Note that if these are not organized/named as in ./ROI_feeder_{xx}.sh (or visa versa) then there will be an error.

**Outputs:**
  - Signal intensity statistics from specified ROIs and image metadata in TXT files.
  - ROI images for overlay on 3D images, if desired.

#### `ROI_Compiler.sh`
**Purpose:** To compile the TXT files created by ROI.sh into a single CSV file. 

**Dependencies:** None.

**Usage:** ./ROI_Compiler.sh {Output CSV name}.csv

**Inputs:** 
  - Desired filename for compiled CSV 

**Outputs:** Signal intensity statistics from specified ROIs and image metadata in TXT files.

### ROI Analysis Markdown Files 

#### `SNR_memri_analysis.Rmd`
**Purpose:** To statistically compare and visualize SNR between groups - test whether there is a difference in MnCl2 dose via differences in SNR.

**Dependencies:** R/RStudio (see [requirements]{../requirements/requirements.md}).

**Usage:** Knit R Markdown File in R Studio

**Inputs:** CSV file generated by running ./ROI_feeder_snr.sh 

**Outputs:** Statistical summaries and plots shown in Fig. S2D.

#### `Fig3_analysis.Rmd`
**Purpose:** To perform comparisons described in results text for Fig. 3. Comparison of threat-activated regions within the ELA group (A) and between groups (B).  

**Dependencies:** R/RStudio (see 

**Usage:** Knit R Markdown File in R Studio

**Inputs:** CSV file generated by running ./ROI_feeder_fig3.sh 

**Outputs:** Statistical summaries and plots shown in Fig. 3 and Tables S3-4.

#### `Fig4_cfos_analysis.Rmd`
**Purpose:** To compare signal intensities and c-fos counts between regions of high and low signal/staining and to perform between-modality correlations.

**Dependencies:** R/RStudio (see [requirements]{../requirements/requirements.md}).

**Usage:** Knit R Markdown File in R Studio

**Inputs:** CSV file generated by running ./ROI_feeder_cfos.sh 

**Outputs:** Statistical summaries and plots shown in Fig. 4 and S5.

#### `memri_test_retest_analysis.Rmd`
**Purpose:** To test differences in MEMRI signal intensities as in Fig, 4, but on the other subset of mice whose brains were not processed for histology.

**Dependencies:** R/RStudio (see [requirements]{../requirements/requirements.md}).

**Usage:** Knit R Markdown File in R Studio

**Inputs:** CSV file generated by running ./ROI_feeder_cfos.sh 

**Outputs:** Statistical summaries and plots shown in Fig. S2D.

#### `smoothing_memri_analysis.Rmd`
**Purpose:** To statistically compare signal intensities of images before and after smoothing.

**Dependencies:** R/RStudio (see [requirements]{../requirements/requirements.md}).

**Usage:** Knit R Markdown File in R Studio

**Inputs:** CSV file generated by running ./ROI_feeder_smooth.sh

**Outputs:** Statistical summaries and plots shown in Fig. S6.
