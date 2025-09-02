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
└── 02_segmentation_analyses/
   ├── fracvol_graph.R                 # Function for graphing fractional volumes according to InVivo Atlas anatomical groupings.
   ├── fav_analysis.Rmd                # R markdown file analysis of Paired SPM t-tests             
   └── fdv_analysis.Rmd                # R markdown file analysis of Unpaired SPM t-tests  
             

```


