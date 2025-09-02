# Segmentation script package

Scripts listed in this subdirectory were used to extract segment-wise information from Statistical Parametric Maps that were output into a compiled CSV file for subsequent analysis in R.


## Example Folder/File Structure for Running  Measurement Scripts

Below is an example of folder/file structure organization for the segmentation of Statistical Parametric Maps. Any deviation from this format will result in errors at some point throughout the segmentation processes. Note that these functions are highly specific to the dataset used. Use of these scripts for your own analysis would require customization of Group/Condition identifiers in the input filenames and in the `segment_stats_*_v4.sh scripts`.  

**Input:**

The type of SPM t-tests _(paired, post vs preMn; paired, post vs postMn; and unpaired, group 1 post vs group 2 postMn)_ need to be separated into different input folders as provided below. Further, the SPM NIfTI image filenames must follow the format `spmT_{Group}_{Condition}_T{t value}_P{p value}_C{cluster size}.nii`. 

Lastly, both the _InVivo_ Atlas NIfTI file and CSV lookup table need to be within the main directory. 

To run `./feeder.sh`, you first need to navigate to the `./Scripts/` directory.

**Output:**

Two folders will contain output files: `./masks` and `./segstats`.

The masks directory contains the generated anatomical masks used for segmentation, whereas segstats contains the output csv files (both for single images as well as for compiled output). Note that the compiled output CSV file will have the name provided as user input to `./feeder.sh {ATLAS NIfTI} {ATLAS CSV} {OUTPUT CSV}` 

**EXAMPLE USAGE:** `./feeder.sh InVivoAtlas_labels_v10.4.nii InVivoAtlas_sort_v10.4.csv ELA_Std_SPM_Segmentation.csv`

```
{USER DIRECTORY PATH}/ROI_Analysis/
├── All_Within_SPMs/
│  ├── Post_vs_PreMn/
│  │  ├── spmT_S_HCgtBL_T276-P01-C8.nii
│  │  ├── spmT_S_TMTgtBL_T276-P01-C8.nii
│  │  ├── spmT_S_D9gtBL_T276-P01-C8.nii
│  │  ├── spmT_E_HCgtBL_T272-P01-C8.nii
│  │  ├── spmT_E_TMTgtBL_T272-P01-C8.nii
│  │  └── spmT_E_D9gtBL_T272-P01-C8.nii
│  └── Post_vs_PostMn/
│     ├── spmT_S_TMTgtHC_T181-P05-C8.nii
│     ├── spmT_S_TMTltHC_T181-P05-C8.nii
│     ├── spmT_S_D9gtHC_T181-P05-C8.nii
│     ├── spmT_S_D9ltHC_T181-P05-C8.nii
│     ├── spmT_S_D9ltTMT_T181-P05-C8.nii
│     ├── spmT_S_D9ltTMT_T181-P05-C8.nii
│     ├── spmT_E_TMTgtHC_T180-P05-C8.nii
│     ├── spmT_E_TMTltHC_T180-P05-C8.nii
│     ├── spmT_E_D9gtHC_T180-P05-C8.nii
│     ├── spmT_E_D9ltHC_T180-P05-C8.nii
│     ├── spmT_E_D9ltTMT_T180-P05-C8.nii
│     └── spmT_E_D9ltTMT_T180-P05-C8.nii
├── All_Between_SPMs/
│  ├── spmT_EgtS_HC_T172-P05-C8.nii
│  ├── spmT_EgtS_TMT_T172-P05-C8.nii
│  ├── spmT_EgtS_D9_T172-P05-C8.nii
│  ├── spmT_EgtS_HC_T172-P05-C8.nii
│  ├── spmT_EgtS_TMT_T172-P05-C8.nii
│  └── spmT_EgtS_D9_T172-P05-C8.nii
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
└── segstats                   
   ├── {Individual SPM Image CSV Files} # One CSV for every image. 
   └── {Compiled Output CSV File} 
```

Note that the following folders will contain output data:
  
  {USER DIRECTORY PATH}/Segmentation/masks # NIfTI masks generated from the _InVivo_ Atlas
  
  {USER DIRECTORY PATH}/Segmentation/segmentstats # CSV data summaries for each statistical map and compiled CSV.
  
