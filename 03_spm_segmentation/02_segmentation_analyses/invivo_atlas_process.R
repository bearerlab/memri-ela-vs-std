# Author: Taylor W. Uselman
# Date: 09/2/2025
# Loading and Processing InVivo Atlas Segmentation Data
# Version 10.4 with fiber tracts removed.

load_invivo <- function(atlas_lut = "InVivoAtlas_Sort_v10.4.csv",
                        segmentation_data = NULL
                        ) {
  if (is.null(segmentation_data)) {
    stop("Please provide segmentation R data frame.")
  }
  
  InVivo_lut = read.csv(paste0(path,"InputData/",atlas_lut),header=T, na.strings = c(""," ","NA","-"))
  
  ## Load Segment Data
  InVivo_lut = InVivo_lut %>%
    mutate(
      # Unpaired T-test Contrast
      Index = as.character(Original_Invivo_Index),
      Index = as.factor(Index),
      
      SegName = as.character(SegmentName),
      SegName = as.factor(SegName),
      
      SegAbbr = as.character(Abbr.Cleaned),
      SegAbbr = as.factor(SegAbbr),
      
      SegGroup = as.character(Grouping),
      SegGroup = as.factor(SegGroup),
      
      Domain = as.character(Domain),
      Domain = factor(Domain,
                      levels = 
                        c(
                          "OLF",
                          "CTX",
                          "HIP",
                          "AMY",
                          "STR/PAL",
                          "THA",
                          "HYP",
                          "MB",
                          "HB",
                          "CB",
                          "WM",
                          "V",
                          "WB"
                        ),
                      labels = 
                        c(
                          "OLF",
                          "CTX",
                          "HIP",
                          "AMY",
                          "STR/PAL",
                          "THA",
                          "HYP",
                          "MB",
                          "HB",
                          "CB",
                          "WM",
                          "V",
                          "WB"
                        )
      )
    ) %>% select(Index,SegAbbr,SegGroup,Domain) %>% arrange(SegAbbr)
  
  segmentation_data$SegGroup = rep(InVivo_lut$SegGroup)
  segmentation_data$Domain = rep(InVivo_lut$Domain)
  
  # Below we create a list of segments that we want to remove from our analysis
  
  seg_to_remove = c("WB" #_WholeBrain" #1
                    ,"VL" #_Lateral_ventricle" #2
                    ,"V3"#_Third_ventricle" #3
                    ,"aot"#_Accessory_optic_tract" #4
                    ,"opt"#_Optic_tract" #5
                    ,"onl"#_Olfactory_nerve_layer_of_main_olfactory_bulb" #6
                    ,"SEZ"#_Subependymal_zone" #7
                    ,"aco"#_Anterior_commissure_olfactory_limb" #8
                    ,"em"#_External_medullary_lamina_of_the_thalamus" #9
                    ,"cc"#_Corpus_callosum" #10
                    ,"int"#_Internal_capsule" #11
                    ,"fi"#_Fimbria" #12
                    ,"vhc"#_Ventral_hippocampal_commisure" #13
                    ,"st"#_Stria_terminalis" #14
                    ,"sm"#_Stria_medullaris" # 15
                    ,"Gr")#_Gr") #16
  
  ## Remove from data file        
  segmentation_data = segmentation_data[!(segmentation_data$SegAbbr %in% seg_to_remove),]
  segmentation_data = segmentation_data %>% droplevels.data.frame()
  
  reorder = match(levels(segmentation_data$SegGroup),segmentation_data$SegGroup)
  
  segmentation_data = segmentation_data %>% mutate(
    SegAbbr = factor(SegAbbr,
                     levels = SegAbbr[reorder])
  )
  
  return(segmentation_data)
}