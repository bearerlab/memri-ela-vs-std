# MEMRI Pre-processing and Quality Control Code

This subdirectory contains the code or links to the GitHub repos for code used for processing MEMRI images and for performing quantitative quality assurance tests. 

Please see Bearer Lab GitHub repositories for [Skull Stripping](https://github.com/bearerlab/skull-stripper), [Modal Scaling](https://github.com/bearerlab/modal-scaling), and [ROI analysis](https://github.com/bearerlab/memri-roi-measurement).  

## Repo File Structure 
```
memri-ela-vs-std/01_preprocessing/02_memri_preprocessing/
├── Slice_Interpolation.m            # Interpolates slices with RF feedthrough artifacts
├── See Bearer Lab GitHub Repo on Skull Stripping. 
├── See Bearer Lab GitHub Repo on Modal Scaling.
└── 01_Quality_Control/
  ├── snr_analysis.Rmd              # MR Signal-to-Noise (SNR) comparisons
  ├── average.sh                    # Visual Alignment Quality
  ├── jaccard_similarity.sh         # Extracts Values to Determine Jaccard Indices to template
  ├── jaccard_similarity.R          # Calculates, graphs, and tests differences in Jaccard Indices
  ├── mutual_information.R          # Calculates, graphs, and tests differences in NMI
  └── roi_warped_v_smoothed.Rmd     # Determines the effect of smoothing on information
```

