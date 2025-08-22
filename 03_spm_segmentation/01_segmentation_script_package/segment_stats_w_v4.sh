#!/bin/bash

# Author: Taylor W. Uselman

# This script performs the segmentation of an SPM paired t-test image for a given segment, based on input from segment_stats_feeder_v4.sh.

# Inputs
spm=$1 # SPM T-statistic image
name=$(basename $spm)
thr=$2 # threshold for T-values
dir=$3 # primary working directory

# Outputs
# Total Volume of 
# volume of overlapped SPM and mask

echo "Segmenting ${name}..."
ANIMID=$(echo ${name:0:${#name}-4})

# Setup output csv file header
echo "SPM,Test,Tthresh,Pval,ELA,Time,SegName,Vox,Vol_mm,MeanT_thr,StDevT_thr,MinT_thr,MaxT_thr,SigVox,SigVol_mm,Cx,Cy,Cz" > $dir/segstats/${ANIMID}_segstats_w.csv

if [[ $ANIMID == *"_S_"* ]]
then
    ELA="Standard"
elif [[ $ANIMID == *"_E_"* ]]
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

# Condition
if [[ $ANIMID == *"HC"* ]]
then
    TIME="HC"
elif [[ $ANIMID == *"TMT"* ]]
then
    TIME="TMT"
elif [[ $ANIMID == *"D9"* ]]
then
    TIME="D9"
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
  # Push segmentation info into a comma-delimited CSV file
  TOTAL=$(echo $ANIMID,"Paired",$thr,$pval,$ELA,$TIME,$SNAME,${MASKSIZE}${STATS} | tr ' ' ',')
  echo $TOTAL >> $dir/segstats/${ANIMID}_segstats_w.csv
done
echo ""
