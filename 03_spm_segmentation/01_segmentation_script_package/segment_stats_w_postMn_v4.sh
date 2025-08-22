#!/bin/bash


# Inputs
# $1 = contrast image of difference between gray scales of post and pre injection images
# $2 = threshold for differences in gray scale between post injection and pre injection images
# NOTE: we want to only see increases in signal intensity due to Mn2+ accumulation therefore the default threshold will be zero
# $3 = primary directory

spm=$1
name=$(basename $spm)
thr=$2
#echo "T = ${thr}"
dir=$3

# Outputs
# Total Volume of 
# volume of overlapped SPM and mask

echo "Segmenting ${name}..."
ANIMID=$(echo ${name:0:${#name}-4})

# Setup output csv file header
echo "SPM,Test,Tthresh,Pval,ELA,Time,SegName,Vox,Vol_mm,MeanT_thr,StDevT_thr,MinT_thr,MaxT_thr,SigVox,SigVol_mm,Cx,Cy,Cz" > $dir/segstats/${ANIMID}_segstats_w.csv
#^ removed GENO from between ELA and Time

if [[ $ANIMID == *"S"* ]]
then
    ELA="Normal"
elif [[ $ANIMID == *"E"* ]]
then
    ELA="ELA"
else
    echo "ELA Status not recognized"
fi
if [[ $name == *"P05"* ]];
then
  pval="0.05"
elif [[ $name == *"P01"* ]];
then
  pval="0.01"
elif [[ $name == *"P005"* ]];
then
  pval="0.005"
elif [[ $name == *"P001"* ]];
then
  pval="0.001"
elif [[ $name == *"P0005"* ]];
then
  pval="0.0005"
elif [[ $name == *"P0001"* ]];
then
  pval="0.0001"
else
  echo "T/P value not recognized"
fi
# # Genotype (WT/KO)
#     if [[ $ANIMID == *"WT"* ]]
#     then
#         GENO="WT"
#     elif [[ $ANIMID == *"KO"* ]]
#     then
#         GENO="KO"
#     else
#         echo "Genotype not recognized"
#     fi
# Condition
if [[ $ANIMID == *"D9gtHC"* ]]
then
    TIME="D9_gt_HC"
elif [[ $ANIMID == *"D9ltHC"* ]]
then
    TIME="D9_lt_HC"
elif [[ $ANIMID == *"TMTgtHC"* ]]
then
    TIME="TMT_gt_HC"
elif [[ $ANIMID == *"TMTltHC"* ]]
then
    TIME="TMT_lt_HC"
elif [[ $ANIMID == *"D9gtTMT"* ]]
then
    TIME="D9_gt_TMT"
elif [[ $ANIMID == *"D9ltTMT"* ]]
then
    TIME="D9_lt_TMT"
else
    echo "Time point not recognized"
fi


# Pull all mask files and calculate total mask size and overlap size
for f in $dir/masks/*.nii; # Indexing here based on filename convention of filtered mask file
do

  # Get segment name from mask
  SNAME=$(basename $f)
  SNAME=${SNAME:0:${#SNAME}-9}

  # Get total mask size first
  MASKSIZE=$(fslstats $f -V | tr ' ' ',')
  
  # Get Segmental Stats from TMap
  ## When performing normal analysis
  STATS=$(fslstats $spm -k $f -l $thr -n -M -S -R -V -C | tr ' ' ',')
  # Push segmentation info into comma delimited csv file
  TOTAL=$(echo $ANIMID,"Paired",$thr,$pval,$ELA,$TIME,$SNAME,${MASKSIZE}${STATS} | tr ' ' ',')
  echo $TOTAL >> $dir/segstats/${ANIMID}_segstats_w.csv
done
echo ""