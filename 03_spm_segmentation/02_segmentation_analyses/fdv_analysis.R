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
anyfiles = list.files(path = paste0("./OutputData/Heatmaps"), pattern = "output_prefix")
while ((length(anyfiles)>0) == T){
  version = version + 1
  output_prefix = paste0(format(Sys.time(), '%y%m%d'),"-v",version)
  anyfiles = list.files(path = paste0("./OutputData/Heatmaps"), pattern = "output_prefix")
}

path = wdir
Atlas_lut = "InVivoAtlas_Sort_v10.4.csv"
data = "241218_TwoSample_BLAdj_Update.csv" 

dat_spm_seg <- read.csv(paste0(path,"InputData/",data), header = TRUE, na.strings=c("","-"," "))

InVivo_lut <-read.csv(paste0(path,"InputData/",Atlas_lut),header=T, na.strings = c(""," ","NA","-"))

# Remove Unwanted Variables
## Mutate Variables and Selected Paired Data 
dat_spm_seg = dat_spm_seg %>% 
  mutate(
    ELA = as.character(ELA)
    ,ELA = factor(ELA, levels = c("Std","ELA"), labels = c("Std","ELA"))
    ,Condition = as.character(Time)
    ,Condition = factor(Condition,
                        levels= c("HC","TMT","D9"),
                        labels= c("HC","TMT","D9"))
    ,SegAbbr = as.character(SegName)
    ,SegAbbr = as.factor(SegAbbr)
    ,Pval = as.character(Pval)
    ,Pval = factor(Pval,
                   levels = c("0.05","0.01","0.001","0.0001"),
                   labels = c("0.05","0.01","0.001","0.0001"))
  ) %>% 
  select(-Time,-SegName) %>%
  arrange(Test,Tthresh,ELA,Condition,SegAbbr)

for (c in 6:16) {
  dat_spm_seg[,c] = dat_spm_seg[,c] %>% as.vector() %>% as.numeric()        
}

dat_spm_seg %>% str()
dat_spm_seg %>% summary()


## Load Atlas Data

dat_spm_seg = load_invivo(atlas_lut = Atlas_lut,
                          segmentation_data = dat_spm_seg)

#### Add Percent Voxels and Reorder Timepoints
dat_spm_seg = dat_spm_seg %>%
  mutate(
    FDV = SigVox / Vox
  )

  

# Set Colors
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

########################
## Un-Paired Analysis ##
########################


for (p in levels(dat_spm_seg$Pval)) {
  # Figure 6  
  ########
  ## HC ##
  ########
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(ELA == "Std", Condition %in% c("HC"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_norm),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_Std_HCadj_UnpairedSPM_p",p))
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(ELA == "ELA", Condition %in% c("HC"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_ela),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_ELA_HCadj_UnpairedSPM_p",p))
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Condition %in% c("HC"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_norm,col_ela),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_EvS_HCadj_UnpairedSPM_p",p))
  #######
  # TMT #
  #######
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(ELA == "Std", Condition %in% c("TMT"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_norm),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_Std_TMTadj_UnpairedSPM_p",p))
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(ELA == "ELA", Condition %in% c("TMT"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_ela),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_ELA_TMTadj_UnpairedSPM_p",p))
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Condition %in% c("TMT"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_norm,col_ela),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_EvS_TMTadj_UnpairedSPM_p",p))
  ########
  ## D9 ##
  ########
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(ELA == "Std", Condition %in% c("D9"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_norm),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_Std_D9adj_UnpairedSPM_p",p))
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(ELA == "ELA", Condition %in% c("D9"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_ela),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_ELA_D9adj_UnpairedSPM_p",p))
  ggplot_columngraph(data_subset = dat_spm_seg %>% filter(Condition %in% c("D9"), Pval == p),
                     y = "FDV",
                     fill = "ELA",
                     col_vals = c(col_norm,col_ela),
                     plot = T,
                     save = T,
                     fname = paste0(output_prefix,"-CG_EvS_D9adj_UnpairedSPM_p",p))
  
  
  #############################
  ## Save Output Data Tables ##
  #############################
  
  dat_spm_seg_sum <- dat_spm_seg %>% 
    filter(Pval == p) %>%
    group_by(
      ELA,
      Condition
    ) %>%
    summarize(
      sum = sum(FDV),
      med = median(FDV),
      avg = mean(FDV),
      max = max(FDV)
    )
  
  library(openxlsx)
  if (!file.exists(paste0("OutputData/Tables/",output_prefix,"_SPM-Adjusted_Segmentation_Combined_p",p,".xlsx"))) {
    wb <- createWorkbook()
    addWorksheet(wb, "Complete")
    writeDataTable(wb
                   , sheet = "Complete"
                   , dat_spm_seg
                   , colNames = T)
    addWorksheet(wb, "Summmary_byColumnGraph")
    writeDataTable(wb
                   , sheet = "Summmary_byColumnGraph"
                   , dat_spm_seg_sum
                   , colNames = T)
    saveWorkbook(wb, file =  paste0("OutputData/Tables/",output_prefix,"_SPM-Adjusted_Segmentation_Combined_p",p,".xlsx"), overwrite = T)
  }  
}
  

##############################
######## FDV Dynamics ########
##############################

df.unpaired = read.xlsx(
  paste0("OutputData/Tables/",output_prefix,"_SPM-Adjusted_Segmentation_Combined_p0.05.xlsx"),
  sheet = "Complete",
  colNames = TRUE) %>%
  mutate(
    SegAbbr = factor(SegAbbr , levels = SegAbbr[1:101]),
    ELA = factor(ELA, levels = c("Std","ELA")),
    Condition = factor(Condition , levels = c("HC","TMT","D9")),
    Con = ifelse(
      Condition == "HC", 23,
      ifelse(Condition == "TMT", 24,
             216))
  )

for (i in 1:length(levels(df.unpaired.subset1$SegAbbr))) {
  seg = levels(df.unpaired.subset1$SegAbbr)[i]
  df.tmp = df.unpaired.subset1 %>% filter(SegAbbr == seg) %>% select(ELA, Condition, Con, FDV)
  p = ggplot(df.tmp, aes(Condition, FDV, color = ELA, group = ELA)) +
    geom_hline(yintercept = 0, linetype = 5, color = "black") +
    geom_line(linewidth=1) + 
    geom_point(size=2) +
    scale_color_manual(values = c(col_norm,col_ela)) +
    scale_y_continuous(limits = c(0,1), breaks = seq(0,1,0.25))+
    labs(title = seg) +
    theme_bw() +
    theme(plot.title = element_text(hjust=0.5),
          axis.ticks.x  = element_blank(),
          legend.position = "none",
          panel.spacing = unit(1, "lines"),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank())
  plot(p)
  fname = paste0("Fig6D_Dynamics-",seg,"-0FDV")
  ggsave(paste0(fname,".png"),
         plot = p,
         path = paste0("./ImagesOut/",output_prefix,"/"),
         units = "in", 
         width = 2, 
         height = 2,  
         dpi = 320)
}
