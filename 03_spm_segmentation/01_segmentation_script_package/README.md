# Segmentation script package

Scripts listed in this subdirectory were used to extract segment-wise information from Statistical Parametric Maps that were output into a compiled CSV file for subsequent analysis in R.


## Example Folder/File Structure for Running  Measurement Scripts

Below is an example of folder/file structure organization for the segmentation of Statistical Parametric Maps. Any deviation from this format will result in errors at some point throughout the segmentation processes. 

**Input:**

Note that the type of SPM t-tests _(paired, post vs preMn; paired, post vs postMn; and unpaired, group 1 post vs group 2 postMn)_ need to be separated into different input folders as provided below. Further, the SPM NIfTI image filenames must follow the format `spmT_{Group}_{Condition}_T{t value}_P{p value}_C{cluster size}.nii`. 

Lastly, both the _InVivo_ Atlas NIfTI file and CSV lookup table need to be within the main directory. 

To run `./feeder.sh`, you first need to navigate to the `./Scripts/` directory.

**Output:**

Two folders will contain output files: `./masks` and `./segstats`.

The masks directory contains the generated anatomical masks used for segmentation, whereas segstats contains the output csv files (both for single images as well as for compiled output). Note that the compiled output CSV file will have the name provided as user input to `./feeder.sh {ATLAS NIfTI} {ATLAS CSV} {OUTPUT CSV}` 

```
{USER DIRECTORY PATH}/ROI_Analysis/
├── All_Within_SPMs/
│  ├── Post_vs_PreMn/
│  │  ├── spmT_S_HC_T272-P01-C8.nii
│  │  ├── spmT_
│  │  ├── spmT_
│  │  ├── spmT_
│  │  ├── spmT_
│  │  └── spmT_
│  ├── Post_vs_PostMn/
│  │  ├── spmT_
│  │  ├── spmT_
│  │  ├── spmT_
│  │  ├── spmT_
│  │  ├── spmT_
│  │  └── spmT_
├── All_Between_SPMs/   
├── scripts/
│  ├── feeder.sh
│  ├── create_mask_feeder.sh
│  ├── mask_creation.sh
│  ├── mask_creator.sh
│  ├── segment_stats_feeder.sh
│  ├── segments_stats_w_v4.sh
│  ├── segments_stats_w_postMn_v4.sh
│  ├── segments_stats_b_v4.sh
│  └── compile.py  
├── masks                             
   └── {Anatomical NIFTI masks for each segment in the InVivo Atlas}
└── segstats                    # Compiles output text files from ROI.sh into a single CSV file
   ├── {Individual SPM Image CSV Files}
   └── {Compiled Output CSV File}
```

Note that the following folders will contain output data:
  
  {USER DIRECTORY PATH}/ROI_Analysis/InputImages/ROIs/{Subdirectories for ROI Names provided in ROI_feeder.sh} 
  
  {USER DIRECTORY PATH}/ROI_Analysis/OutputData/ROIs_NIfTIs
  
  {USER DIRECTORY PATH}/ROI_Analysis/OutputData/ROIs_txt
