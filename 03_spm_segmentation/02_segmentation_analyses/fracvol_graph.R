# Author: Taylor W. Uselman
# Date: 09/2/2025
# Column Graph Plotting for Fractional Volume Segmentation of Brain-wide Statistical Maps

if (!require("ggplot2")) {
  install.packages("ggplot2")
  require("ggplot2")
}
ggplot_columngraph = function(data_subset,
                              y = c("FDV","FAV","CohD_mean","CohD_max"),
                              fill = NULL,
                              col_vals = c("gray50", "black"),
                              plot = T,
                              save = T,
                              fname = NULL,
                              fig_dims = c(3.3,1.1)) {
  if (is.null(fill)) {stop("Need to specify variable for 'fill'")}
  if (save == T && is.null(fname)) {stop("Need to specify file name (fname option) if saving plot and data subset to csv")}
  
  xcnt = data_subset %>% 
    filter(Pval == 0.01) %>%
    group_by(Test, ELA, Condition, Domain) %>% 
    select(Domain) %>%
    summarise(cnt=n()) %>% 
    filter(Test == unique(data_subset$Test)[1],
           ELA == unique(data_subset$ELA)[1],
           Condition == unique(data_subset$Condition)[1]) %>% 
    pull(cnt)
  
  xvals = c()
  for (i in 1:length(xcnt)) {
    if (i == 1) {
      xvals[i] = 0.5
    } else {
      xvals[i] = xvals[i-1] + xcnt[i-1]
    }
  }
  xvals[(length(xcnt)+1)] = xvals[length(xcnt)] + xcnt[length(xcnt)]
  bckgrnd_col = c()
  for (i in 1:length(xcnt)){
    if (i %% 2 == 1) {
      bckgrnd_col[i] = "white"
    } else {
      bckgrnd_col[i] = "grey40"
    }
  }
  
  annotation_locations = (xvals[-length(xvals)] + (xcnt/2))
  
  if (y == "CohD_mean" || y == "CohD_max") {
    ymax1 = data_subset[,which(colnames(data_subset)==y)] %>% max(., na.rm = FALSE) %>% ceiling()
    bks = seq(0, ymax1, round(ymax1/4,1))
    lms = c(-0.15*ymax1,ymax1)
  } else {
    ymax1 = 1
    bks = seq(0, 1.0, 0.25)
    lms = c(-0.15,1.0)
  }
  
  p0 = ggplot(data = data_subset,
              aes_string(x = "SegAbbr",
                         y = y[1],
                         fill = fill))
  p0 = p0 + annotate(xmin = xvals[-length(xvals)],
                     xmax = xvals[-1],
                     ymin = 0.0,
                     ymax = ymax1,
                     geom = 'rect',
                     alpha = 0.1,
                     fill = bckgrnd_col)
  p0 = p0 + annotate(xmin = xvals[-length(xvals)],
                     xmax = xvals[-1],
                     ymin = -0.15*ymax1,
                     ymax = 0,
                     geom = 'rect',
                     alpha = 0.25,
                     fill = colorsgroup)
  p0 = p0 + annotate(x = annotation_locations,
                     y = -0.075,
                     geom = 'text',
                     label = as.character(levels(data_subset[["Domain"]])),
                     size = 1.75)
  p0 = p0 + geom_bar(position=position_dodge(0.75), stat = "identity", width=0.7)
  p0 = p0 + scale_fill_manual(values = col_vals)
  p0 = p0 + geom_hline(yintercept = 0, linetype = "solid", linewidth=0.2, color ="black", alpha = 1)
  
  p0 = p0 + scale_y_continuous(breaks = bks, limits = lms, expand = c(0,0))
  p0 = p0 + scale_x_discrete(drop=F)
  p0 = p0 + labs(x = "",
                 y = "",
                 title = "")
  p0 = p0 + theme_bw()
  p0 = p0 + theme(plot.title = element_blank(),
                  axis.title.x = element_blank(), 
                  axis.text.x = element_blank(),
                  axis.title.y = element_blank(),
                  axis.text.y = element_text(size=6,family="sans"),
                  axis.ticks.x  = element_blank(),
                  legend.position = "none",
                  panel.spacing = unit(1, "lines"),
                  panel.grid.major.x = element_blank(),
                  panel.grid.minor.x = element_blank(),
                  panel.grid.major.y = element_blank(),
                  panel.grid.minor.y = element_blank())
  if (plot == T) {
    print(p0)
  } 
  if (save == T) {
    if (!dir.exists("OutputData")) {dir.create("OutputData")}
    if (!dir.exists("OutputData/ColumnGraphs")) {dir.create("OutputData/ColumnGraphs")}
    if (!dir.exists("OutputData/Tables")) {dir.create("OutputData/Tables")}
    ggsave(paste0(fname,".png"),
           plot = p0,
           path = "./OutputData/ColumnGraphs",
           units = "in", 
           width = fig_dims[1], 
           height = fig_dims[2],  
           dpi = 320)
    write.csv(data_subset,
              file = paste0("OutputData/Tables/",fname,".csv"),
              row.names = F)
  }
}