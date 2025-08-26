# Analysis of Raw Ethovision XT 15 Video Recording Data

Raw TXT data files of tracked videos were extracted from EthoVision XT 15. These TXT files were loaded and processed in R using the `behavioral_analysis.Rmd` file. The markdown file is broken up into two sections. 

The first section defines a function called _load.etvz.txt_ loads the TXT files iteratively, processes their header information, compiles data and header information across TXT files, and converts data into to an R data frame. TXT files contain variables of time, x-y location, area, area change, elongation, distance, velocity, and hot-one-encoded categorical variables for moving, mobility, and side of arena. Std and ELA datasets were loaded/processed separately. After the initial processing, the processed data were saved as .RData files to load in future as necessary. Please see this paper's _Supplemental Information (SI) Appendix_ for detail on the processing steps performed. 

The second section summarized the raw data into 1-minute epochs and into trial-wise average/variance for each mouse. These values were used for statistical analysis via linear-mixed effect models.   
