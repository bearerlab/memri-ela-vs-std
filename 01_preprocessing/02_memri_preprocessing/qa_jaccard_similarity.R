################################
##### Uselman et al., 2023 #####
## Analysis of MRI Alignments ##
################################

wdir = "E:/Taylor_Uselman/ELS_PTSD/IP_Data/01_Data_Processing/240102_Reprocessing_PreMnImages/07-2_Normalize/Jaccard_Dice_AlignmentIndices/"
setwd(wdir)


library(tidyverse)

df_jaccard <- read.csv(paste0(wdir,"JaccardSim.csv"), header=TRUE) %>% mutate(
  ELA = factor(ELA, levels=c(1,2), labels=c("Std","ELA"))
  , Cond = factor(Cond, levels=c(1,2,3,4) , labels=c("BL-PreMn","HC","TMT","D9"))
  , Num = factor(Num)
  , ID = ifelse(ELA == "Std",as.numeric(Num),as.numeric(Num)+12) %>% as.factor()
)

df_jaccard_sum <- df_jaccard %>% group_by(ELA,Cond) %>%
  summarise(
    m = mean(JacInd),
    s = sd(JacInd),
    sem = s/n()
  ) %>% ungroup()

library(ggplot2)
p = ggplot(data=df_jaccard, aes(x=Cond, y=JacInd, color=ELA))
p = p + geom_hline(yintercept = 0.95, linetype = "dashed", color = "grey50", size = 0.25)
p = p + geom_rect(xmin = which(levels(as.factor(df_jaccard$Cond))=="BL") -1,
                  xmax = which(levels(as.factor(df_jaccard$Cond))=="D9post") +1,
                  ymin = 0.97, ymax = 0.99, fill = "grey90", alpha=0.05, color="white")
p = p + geom_violin(position=position_dodge(0.75),trim=F, aes(fill=ELA), alpha=0.5,colour="grey75",size=0.05, linetype="dotted")
p = p + geom_point(position=position_dodge(0.75), size=0.1)
# p = p + geom_point(data=df_jaccard_sum, aes(y=m, group=ELA), position=position_dodge(0.75), color="red", size=0.25, shape=13)
p = p + scale_fill_manual(values=c("cyan4","goldenrod3")) 
p = p + scale_color_manual(values=c("cyan4","goldenrod3")) 
p = p + scale_y_continuous(limits = c(0,1.00), breaks = seq(0,1.000,0.1),expand = c(0, 0))
p = p + labs(title=""
             ,x="Condition"
             ,y="Jaccard Index")
p = p + theme_classic()
p = p + theme(plot.title = element_blank()
              , axis.title.x = element_blank()#text(size=8,face="bold",family="sans")
              , axis.text.x = element_text(size=6,face="bold",family="sans")
              , axis.title.y = element_text(size=8,face="bold",family="sans")
              , axis.text.y = element_text(size=6,face="bold",family="sans")
              , legend.position = "none")
p
# ggsave(filename="JaccardIndex_byELA_Cond_v6.tiff"
#        ,plot=p
#        ,device="tiff"
#        ,path=paste0(wdir)
#        ,width=75,height=55,units="mm",dpi=300)

p = ggplot(data=df_jaccard, aes(x=Cond, y=JacInd, color=ELA))
# p = p + geom_hline(yintercept = 0.97, linetype = "dashed", color = "grey50", size = 0.15)
# p = p + geom_hline(yintercept = 0.99, linetype = "dashed", color = "grey50", size = 0.15)
p = p + geom_rect(xmin = which(levels(as.factor(df_jaccard$Cond))=="BL-PreMn") -1,
                  xmax = which(levels(as.factor(df_jaccard$Cond))=="D9") +1,
                  ymin = 0.95, ymax = 0.97, fill = "grey90", alpha=0.05, color="white")
p = p + geom_violin(position=position_dodge(0.75),trim=T, aes(fill=ELA), alpha=0.5,colour="grey75",size=0.05, linetype="dotted")
p = p + geom_point(position=position_dodge(0.75), size=0.1)
# p = p + geom_point(data=df_jaccard_sum, aes(y=m, group=ELA), position=position_dodge(0.75), color="red", size=0.25, shape=13)
p = p + scale_fill_manual(values=c("cyan4","goldenrod3")) 
p = p + scale_color_manual(values=c("cyan4","goldenrod3")) 
p = p + scale_y_continuous(limits = c(0.75,1.00), breaks = seq(0.75,1.000,0.05),expand = c(0, 0))
p = p + labs(title=""
             ,x="Condition"
             ,y="Jaccard Similarity Index")
p = p + theme_classic()
p = p + theme(plot.title = element_blank()
              , axis.title.x = element_blank()#text(size=8,face="bold",family="sans")
              , axis.text.x = element_text(size=6,face="bold",family="sans",angle=45,hjust=1)
              , axis.title.y = element_text(size=8,face="bold",family="sans")
              , axis.text.y = element_text(size=6,face="bold",family="sans")
              , legend.position = "none")
p

# ggsave(filename="JaccardIndex_byELA_Cond_v6.4.tiff"
#        ,plot=p
#        ,device="tiff"
#        ,path=paste0(wdir)
#        ,width=40,height=55,units="mm",dpi=300)

p = ggplot(data=df_jaccard, aes(x=Cond, y=JacInd, color=ELA))
p = p + geom_violin(position=position_dodge(0.75),trim=F, aes(fill=ELA), alpha=0.5,colour="grey75",size=0.05, linetype="dotted")
p = p + geom_point(position=position_dodge(0.75), size=0.1)
p = p + scale_fill_manual(values=c("cyan4","goldenrod3")) 
p = p + scale_color_manual(values=c("cyan4","goldenrod3")) 
p = p + theme_classic()
p = p + theme(legend.title = element_blank(),
              legend.text = element_text(size=6,face="bold",family="sans"),
              legend.position = c(0.48,0.57),
              legend.key.size = unit(0.1, 'in'))

legend <- cowplot::get_legend(p)
# ggsave(filename="Legend_Jaccard_v4.tiff"
#        ,plot=legend
#        ,device="tiff"
#        ,path=paste0(wdir)
#        ,width=0.5,height=0.3,units="in",dpi=300)

library(nlme)
lm.j.c.t <- lme(JacInd ~ ELA*Cond, random = (~1|ID), data = df_jaccard)
library(car)
anova(lm.j.c.t, type = "marginal")

nortest::ad.test(lm.j.c.t$residuals)
leveneTest(JacInd ~ ELA*Cond, data=df_jaccard)
BIC(lm.j.c.t)

