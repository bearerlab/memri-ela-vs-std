# Author: Taylor Uselman
# R Analysis for fractional activation volumes in "Reconfiguration of brain-wide neural activity after early life adversity."

##########################
### USER INPUT REQUIRED ##
setwd("Local Directory")
##########################

wdir=getwd()

# Load R Libraries
lib_ls <- c(
  "tidyverse",
  "RColorBrewer",
  "reshape2",
  "gridExtra",
  "grid",
  "cowplot"
)
lapply(lib_ls, require, character.only = T)


version = 1
output_prefix = paste0(format(Sys.time(), '%y%m%d'),"-v",version)
anyfiles = list.files(path = paste0("./OutputData/ColumnGraphs"), pattern = "output_prefix")
while ((length(anyfiles)>0) == T){
  version = version + 1
  output_prefix = paste0(format(Sys.time(), '%y%m%d'),"-v",version)
  anyfiles = list.files(path = paste0("./OutputData/ColumnGraphs"), pattern = "output_prefix")
}

path = wdir

##########################
### USER INPUT REQUIRED ##
Atlas_lut = "InVivoAtlas_Sort_v10.4.csv"
data = data.frame(Paired = "PostMn_vs_PreMn_ES_SPM_Segment.csv",
                  PairedPostMn = "PostMn_vs_PostMn_ES_SPM_Segment.csv")
##########################


dat_spm_seg_postmn <- read.csv(paste0(path,"InputData/",data$PairedPostMn), header = TRUE, na.strings=c("","-"," "))


dat_spm_seg <- read.csv(paste0(path,"InputData/",data$Paired), header = TRUE, na.strings=c("","-"," "))


  
# Remove Unwanted Variables
## Mutate Variables and Selected Paired Data 
dat_spm_seg = dat_spm_seg %>% 
  mutate(
    ELA = as.character(ELA)
    ,ELA = factor(ELA, levels = c("Normal","ELA"), labels = c("Std","ELA"))
    ,Condition = as.character(Time)
    ,Condition = factor(Condition, levels= c("BL-PreMn","HC","TMT","D9"), labels=c("BL-PreMn","HC","TMT","D9"))
    ,SegAbbr = as.character(SegName)
    ,SegAbbr = as.factor(SegAbbr)
    ,Pval = as.character(Pval)
    ,Pval = factor(Pval,
                   levels = c("0.05","0.01","0.001","1e-04"),
                   labels = c("0.05","0.01","0.001","0.0001"))
  ) %>% 
  select(-Time,-SegName) %>%
  arrange(Test,Tthresh,ELA,Condition,SegAbbr)

dat_spm_seg_postmn = dat_spm_seg_postmn %>% 
  mutate(
    ELA = as.character(ELA)
    ,ELA = factor(ELA, levels = c("Normal","ELA"), labels = c("Std","ELA"))
    ,Condition = as.character(Time)
    ,Condition = factor(Condition,
                        levels = c("TMT_lt_HC","TMT_gt_HC",
                                   "D9_lt_TMT","D9_gt_TMT",
                                   "D9_lt_HC","D9_gt_HC"),
                        labels = c("HC > TMT","HC < TMT",
                                   "TMT > D9","TMT < D9",
                                   "HC > D9","HC < D9"))
    ,SegAbbr = as.character(SegName)
    ,SegAbbr = as.factor(SegAbbr)
    ,Pval = as.character(Pval)
    ,Pval = factor(Pval,
                   levels = c("0.05","0.01","0.001","1e-04"),
                   labels = c("0.05","0.01","0.001","0.0001"))
  ) %>% 
  select(-Time,-SegName) %>%
  arrange(Test,Tthresh,ELA,Condition,SegAbbr)

for (c in 6:13) {
  dat_spm_seg[,c] = dat_spm_seg[,c] %>% as.vector() %>% as.numeric()        
}
for (c in 6:13) {
  dat_spm_seg_postmn[,c] = dat_spm_seg_postmn[,c] %>% as.vector() %>% as.numeric()        
}

dat_spm_seg %>% str()
dat_spm_seg %>% summary()


dat_spm_seg_postmn %>% str()
dat_spm_seg_postmn %>% summary()




## Load Atlas Data
  
dat_spm_seg = load_invivo(atlas_lut = Atlas_lut,
                          segmentation_data = dat_spm_seg)

dat_spm_seg_postmn = load_invivo(atlas_lut = Atlas_lut,
                                 segmentation_data = dat_spm_seg_postmn)




#### Add Percent Voxels and Reorder Timepoints
# SPMs of Post- vs Pre-Mn(II) images
dat_spm_seg = dat_spm_seg %>%
  mutate(
    PerVox = SigVox / Vox)
# SPMs of Post-Mn(II) images
dat_spm_seg_postmn = dat_spm_seg_postmn %>%
  mutate(
    PerVox = SigVox / Vox)




# Set Colors
col_bl = "grey50"
col_norm = "cyan4"
col_ela =  "goldenrod3"
col_hc = "blue3"
col_tmt =  "tomato1" #"red1"
col_d9 = "limegreen" #"green3" #"limegreen"
colorsgroup <- brewer.pal(length(unique(dat_spm_seg$Domain)),"Paired")



##########################################
########### Fractional Volumes ###########
##########################################

## Column Graphs ##

## Load Column Graph Function
source("./fracvol_graph.R")


#####################
## Paired Analysis ##
#####################

########################
## Post vs Pre-Mn(II) ##
########################


for (p in levels(dat_spm_seg$Pval)) {
  cat(paste0("p=",p,"\r"))
  # HC alone
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Test == "Paired", ELA == "ELA", Condition %in% c("HC"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_ELA_PairedSPM_HConly_p",p)),
                     fig_dims = c(3.3,1.1))
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Test == "Paired", ELA == "Std", Condition %in% c("HC"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_Std_PairedSPM_HConly_p",p)),
                     fig_dims = c(3.3,1.1))
}

for (p in levels(dat_spm_seg$Pval)) {
  cat(paste0("p=",p,"\r"))
  # Figure 5
  ## Fig 5A. ELA  HC to TMT
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Test == "Paired", ELA == "ELA",
                                                                Condition %in% c("HC","TMT"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc, col_tmt),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_ELA_PairedSPM_TMTandHC_p",p)),
                     fig_dims = c(3.3,1.1))
  
  ## Fig 5B. ELA TMT to D9
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Test == "Paired", ELA == "ELA",
                                                                 Condition %in% c("TMT","D9"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_tmt, col_d9),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_ELA_PairedSPM_D9andTMT_p",p)))
  
  ## Fig 5C. ELA HC to D9
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Test == "Paired", ELA == "ELA",
                                                                 Condition %in% c("HC","D9"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc, col_d9),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_ELA_PairedSPM_D9andHC_p",p)))
  
  ## Fig 5D. Std  HC to TMT
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Test == "Paired", ELA == "Std",
                                                                 Condition %in% c("HC","D9"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc, col_d9),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_Std_PairedSPM_D9andHC_p",p)))
  
}




#########################
## Post vs Post-Mn(II) ##
#########################

for (p in levels(dat_spm_seg_postmn$Pval)) {
  cat(paste0("p=",p,"\r"))
  # Figure S8
  ggplot_columngraph(data_subset = dat_spm_seg_postmn %>% filter(ELA == "ELA", Condition %in% c("HC > TMT","HC < TMT"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc, col_tmt),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_ELA_Paired-PostMn-SPM_TMTandHC_p",p)),
                     fig_dims = c(3.3,1.1))
  
  ggplot_columngraph(data_subset = dat_spm_seg_postmn %>% filter(ELA == "ELA", Condition %in% c("HC > D9","HC < D9"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc, col_d9),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_ELA_Paired-PostMn-SPM_D9andHC_p",p)))
  
  ## Fig 4D. Std  HC to TMT
  ggplot_columngraph(data_subset = dat_spm_seg_postmn %>% filter(ELA == "Std", Condition %in% c("HC > TMT","HC < TMT"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc, col_tmt),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_Std_Paired-PostMn-SPM_TMTandHC_p",p)),
                     fig_dims = c(3.3,1.1))
  
  ## Fig 4F. Std HC to TMT
  ggplot_columngraph(data_subset = dat_spm_seg_postmn %>% filter(ELA == "Std", Condition %in% c("HC > D9","HC < D9"), Pval == p),
                     y = "PerVox",
                     fill = "Condition",
                     col_vals = c(col_hc, col_d9),
                     plot = T,
                     save = T,
                     fname = paste0(paste0(output_prefix,"-CG_Std_Paired-PostMn-SPM_D9andHC_p",p)))
  
}

#############################
## Save Output Data Tables ##
#############################

library(openxlsx)
### Save Paired T-test Data for PostMn > PreMn
dat_paired_spm_seg_subset <- dat_spm_seg %>%
  filter(Test == "Paired") %>%
  select(Test,ELA,Condition,Pval,Tthresh,SegAbbr,SegGroup,Domain,Vox,SigVox,PerVox) %>%
  arrange(ELA,Condition,Pval,SegGroup) %>%
  mutate(
    FAV = PerVox %>% round(.,3)
  ) %>%
  select(-c(PerVox))

dat_paired_spm_seg_subset %>% head(.,10)

if (!file.exists(paste0("OutputData/Tables/",output_prefix,"_SPM_Segmentation_Combined.xlsx"))) {
  wb <- createWorkbook()
  addWorksheet(wb, "Complete")
  writeDataTable(wb
                 , sheet = "Complete"
                 , dat_paired_spm_seg_subset
                 , colNames = T)
  saveWorkbook(wb, file =  paste0("OutputData/Tables/",output_prefix,"_SPM_Segmentation_Combined.xlsx"), overwrite = T)
}



dat_pairedpostmn_spm_seg_subset <- dat_spm_seg_postmn %>%
  select(Test,ELA,Condition,Pval,Tthresh,SegAbbr,SegGroup,Domain,Vox,SigVox,PerVox) %>%
  arrange(ELA,Condition,Pval,SegGroup) %>%
  mutate(
    FAV = PerVox %>% round(.,3)
  ) %>%
  select(-c(PerVox))

dat_pairedpostmn_spm_seg_subset %>% head(.,10)

if (!file.exists(paste0("OutputData/Tables/",output_prefix,"_SPM_PostMn_Segmentation_Combined.xlsx"))) {
  wb <- createWorkbook()
  addWorksheet(wb, "Complete")
  writeDataTable(wb
                 , sheet = "Complete"
                 , dat_pairedpostmn_spm_seg_subset
                 , colNames = T)
  saveWorkbook(wb, file =  paste0("OutputData/Tables/",output_prefix,"_SPM_PostMn_Segmentation_Combined.xlsx"), overwrite = T)
}