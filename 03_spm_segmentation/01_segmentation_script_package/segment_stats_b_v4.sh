#!/bin/bash

# Inputs
spm=$1 # contrast image of difference between gray scales of post and pre injection images
thr=$2 # threshold for differences in gray scale between post injection and pre injection images
# NOTE: we want to only see increases in signal intensity due to Mn2+ accumulation therefore the default threshold will be zero
dir=$3 # primary working directory

name=$(basename $spm) 

# Outputs
echo "Segmenting ${name}..."
ANIMID=$(echo ${name:0:${#name}-4})
# Setup output csv file header
echo "SPM,Test,Tthresh,Pval,ELA,Time,SegName,Vox,Vol_mm,MeanT_thr,StDevT_thr,MinT_thr,MaxT_thr,SigVox,SigVol_mm,Cx,Cy,Cz" > $dir/segstats/${ANIMID}_segstats_b.csv

# ELA (Normal/ELA)
if [[ $ANIMID == *"SgtE"* ]]
then
    ELA="Std"
elif [[ $ANIMID == *"SltE"* ]]
then
    ELA="ELA"
else
    echo "ELA not recognized"
fi

# Time point (B/PS/D9_Pre/D9_Post)
if [[ $ANIMID == *"HC"* ]]
then
    TIME="HC"
elif [[ $ANIMID == *"TMT"* ]] #PostF_4
then
    TIME="TMT"
# elif [[ $ANIMID == *"D9Pre"* ]]
# then
#     TIME="D9pre"
elif [[ $ANIMID == *"D9"* ]]
then
    TIME="D9"
else
    echo "Time point not recognized"
fi

if [[ $name == *"P05"* ]];
then
  pval="0.05"
elif [[ $name == *"P01"* ]];
then
  pval="0.01"
elif [[ $name == *"P001"* ]];
then
  pval="0.001"
elif [[ $name == *"P0001"* ]];
then
  pval="0.0001"
else
  echo "T/P value not recognized"
fi

# Pull all mask files and calculate total mask size and overlap size
for f in $dir/masks/*.nii # Indexing here based on filename convention of filtered mask file
do
  
  # Get segment name from mask
  SNAME=$(basename $f)
  SNAME=${SNAME:0:${#SNAME}-9}

  # Get total mask size first
  MASKSIZE=$(fslstats $f -V | tr ' ' ',')
  
  # Get total voxels from spm that fall within mask, and calculate range, and mean (also pipe it through to replace space delimiter with comma for easier sorting)
  STATS=$(fslstats $spm -k $f -n -M -S -R -V -C | tr ' ' ',')
  
  # Push segmentation info into a comma-delimited CSV file
  TOTAL=$(echo $ANIMID,"Unpaired",$thr,$pval,$ELA,$TIME,$SNAME,${MASKSIZE}${STATS})
  echo $TOTAL >> $dir/segstats/${ANIMID}_segstats_b.csv
done
echo ""
