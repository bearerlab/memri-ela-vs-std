#!/bin/bash

# Inputs to this function are: 
# $1 = primary directory
# $2 = name of antaomtical region
# $3 = lower range of gray scale values to include
# $4 = upper range of gray scale values to include

dir=$1
segment=$2
lthr=$3
uthr=$4
atlas=$5

cd $dir

echo "Creating mask for" $segment

# NOTE FSL has really bad habit of spitting out .gz compressed files on Linux. Here I am preceding each function call to force a single .nii output regardless of FSL defalt preference

# Extract mask and noise 
(FSLOUTPUTTYPE=NIFTI fslmaths $atlas -thr $lthr -uthr $uthr -div $lthr $dir/masks/${2}_mask.nii)
