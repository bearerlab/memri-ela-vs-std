#!/bin/bash

# $1 = primary directory
# $2 = scripts directory

dir=$1
sdir=$2

[[ ! -d $dir/segstats ]] && mkdir $dir/segstats

# Point script to where the spm files are (Within and Between Group SPM Input Subfolders)

# Within Group
echo ""
echo "Running SPM segmentation for Post vs Pre-Mn(II) images"
echo "Note ERROR:: messages occur for segments with no significant voxels"
echo "Please ignore this error"

FLIST=(`ls $dir/All_Within_SPMs/Post_vs_PreMn/*/*.nii`) 
for ((n=0;n<${#FLIST[@]};n++));
do
	fname=${FLIST[$n]}
	thr=$(echo $fname | grep -Po '(_T)\K\d+')
	thr=$(echo "${thr:0:1}.${thr:1}")
	$sdir/segment_stats_w_v4.sh $fname $thr $dir
done

echo ""
echo "Running SPM segmentation for Post vs Post-Mn(II) images"
echo "Note ERROR:: messages occur for segments with no significant voxels"
echo "Please ignore this error"

FLIST=(`ls $dir/All_Within_SPMs/Post_vs_PostMn/*/*.nii`) 
for ((n=0;n<${#FLIST[@]};n++));
do
	fname=${FLIST[$n]}
	thr=$(echo $fname | grep -Po '(_T)\K\d+')
	thr=$(echo "${thr:0:1}.${thr:1}")
	$sdir/segment_stats_w_postMn_v4.sh $fname $thr $dir
done

# Between Group
echo ""
echo "Running Between Group SPM segmentation"
echo "Note ERROR:: messages occur for segments with no significant voxels"
echo "Please ignore this error"

FLIST=(`ls $dir/All_Between_SPMs/*/*/*.nii`)
cnt=0
for ((n=0;n<=${#FLIST[@]};n++));
do
	fname=${FLIST[$n]}
	thr=$(echo $fname | grep -Po '(_T)\K\d+')
	thr=$(echo "${thr:0:1}.${thr:1}")
	$sdir/segment_stats_b_v4.sh $fname $thr $dir
done
