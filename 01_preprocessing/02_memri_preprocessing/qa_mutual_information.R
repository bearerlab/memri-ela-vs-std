########################
### NMI Calculation ###
########################

# This function calculates the normalized mutual information of all NIfTI images in a directory with a template/reference image.

# The purpose of this function is to assess anatomical aligment of to MR images using NMI (as NMI is a typical metric used in the cost functions of alignment algorithms) 

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

## R Packages
library(RNifti)
# library(tidyverse)
library(aricode)

## Step 1: Load template and calculate histogram
if (file.exists("./NormMutInfo.rds")) {
  # Save a single object to a file
  saveRDS(mtcars, "NormMutInfo.rds")
  # Restore it under a different name
  df <- readRDS("NormMutInfo.rds")
} else {
  template <- file.choose(getwd())
  template <- readNifti(template)
  
  minInt = 1000
  template_thr = template[which(template > minInt)]
  
  Nbins = 256
  
  maxInt = 15000
  seqInt = seq(minInt,maxInt,(maxInt-minInt)/Nbins)
  temp_hist = c()
  dat_hist = c()
  for (i in 2:Nbins) {
    if (i == 2) {
      cat("Calculating Template Histogram\n")
      temp_hist[(i-1)] = length(which(template_thr > seqInt[(i-1)] & template_thr < seqInt[i]))
    } else {
      temp_hist_tmp = length(which((template_thr > seqInt[(i-1)]) & (template_thr < seqInt[i])))
      temp_hist = c(temp_hist,temp_hist_tmp)
    }
    cat(paste0("\r",round((((i-1)/(Nbins-1)))*100,1),"%"))
  }
  
  
  ## Step 2: Load individual images and calculate histograms
  nii_flist <- list.files(pattern = "hist.nii", ignore.case = F)
  
  dat_hist_list = list()
  for (nii_i in 1:length(nii_flist)) {
    cat(paste0("\nLoading and Calculating Histogram for ",nii_flist[nii_i],"\n"))
    nii = readNifti(nii_flist[nii_i])
    nii_thr = nii[which(nii > minInt)]
    dat_hist = c()
    for (i in 2:Nbins) {
      if (i == 2) {
        dat_hist[(i-1)] = length(which(nii_thr > seqInt[(i-1)] & nii_thr < seqInt[i]))
      } else {
        dat_hist_tmp = length(which((nii_thr > seqInt[(i-1)]) & (nii_thr < seqInt[i])))
        dat_hist = c(dat_hist,dat_hist_tmp)
      }
      cat(paste0("\r",round((((i-1)/(Nbins-1)))*100,1),"%"))
    }
    dat_hist_list[[nii_i]] = dat_hist
  }
  
  
  ## Step 3: Calculcate NMI
  dat_hist_nmi = c()
  for (nii_i in 1:length(nii_flist)) {
    # NMI() function from the aricode package 
    dat_hist_nmi[nii_i] = NMI(temp_hist, dat_hist_list[[nii_i]], variant = "sqrt")
  }
  
  
  df = data.frame(
    images = nii_flist,
    NMI = dat_hist_nmi
    ) %>% 
    mutate(
      Num = parse_number(images),
      Group = ifelse(grepl("PTSD", images, fixed = TRUE),"Std","ELA"),
      Group = factor(Group, levels = c("Std","ELA")),
      ID = ifelse(Group == "Std", Num, Num + 12),
      Con = ifelse(grepl("_pre.", images, fixed = TRUE),"BL-PreMn",
                   ifelse(grepl("PreF", images, fixed = TRUE),"HC",
                          ifelse(grepl("PostF", images, fixed = TRUE),"TMT","D9"))),
      Con = factor(Con, levels = c("BL-PreMn","HC","TMT","D9")),
      ) 
  # Save df to a file
  saveRDS(df, "./NormMutInfo.rds")
}


p = ggplot(data=df, aes(x=Con, y=NMI, color=Group))
p = p + geom_rect(xmin = which(levels(as.factor(df$Con))=="BL-PreMn") -1,
                  xmax = which(levels(as.factor(df$Con))=="D9") +1,
                  ymin = 0.9, ymax = 0.93, fill = "grey90", alpha=0.05, color="white")
p = p + geom_violin(position=position_dodge(0.75),trim=T, aes(fill=Group), alpha=0.5,colour="grey75",size=0.05, linetype="dotted")
p = p + geom_point(position=position_dodge(0.75), size=0.1)
p = p + scale_fill_manual(values=c("cyan4","goldenrod3")) 
p = p + scale_color_manual(values=c("cyan4","goldenrod3")) 
p = p + scale_y_continuous(limits = c(0.75,1.00), breaks = seq(0.75,1.000,0.05),expand = c(0, 0))
p = p + labs(title=""
             ,x="Condition"
             ,y="Normalized Mutual Information")
p = p + theme_classic()
p = p + theme(plot.title = element_blank()
              , axis.title.x = element_blank()
              , axis.text.x = element_text(size=6,face="bold",family="sans",angle=45,hjust=1)
              , axis.title.y = element_text(size=8,face="bold",family="sans")
              , axis.text.y = element_text(size=6,face="bold",family="sans")
              , legend.position = "none")
p

# ggsave(filename="NMI_byELA_Cond_v6.4.tiff"
#        ,plot=p
#        ,device="tiff"
#        ,path="Local Directory"
#        ,width=40,height=55,units="mm",dpi=300)

library(nlme)
lme.out = lme(NMI ~ Group*Con,
              random = (~1|ID),
              data = df)
anova(lme.out, type="marginal")

nortest::ad.test(lme.out$residuals)
leveneTest(NMI ~ Group*Con, data=df)
BIC(lme.out)
